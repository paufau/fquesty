import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fquest_engine/engine/ast/interpreter/Interpreter.dart';
import 'package:fquest_engine/engine/ast/interpreter/environment/Environment.dart';
import 'package:fquest_engine/engine/scene/entities/AnimationEntity.dart';
import 'package:fquest_engine/engine/scene/entities/AnimationSequencer.dart';
import 'package:fquest_engine/engine/scene/entities/SceneEntity.dart';
import 'package:fquest_engine/engine/scene/state/GSContainerState.dart';
import 'package:fquest_engine/engine/story/Story.dart';

class _ScenesNotifier extends StateNotifier<Map<String, SceneEntity>> {
  _ScenesNotifier({this.onStartFound}) : super({});

  Function(SceneEntity scene)? onStartFound;

  set(SceneEntity scene) {
    state[scene.name] = scene;
    if (scene.name == 'start' && onStartFound != null) {
      onStartFound!(scene);
    }
  }

  SceneEntity? get(String name) {
    return state[name];
  }
}

final globalEnv = Environment();

class _InterpreterNotifier extends StateNotifier<Interpreter?> {
  _InterpreterNotifier() : super(null);

  init(BuildContext context, WidgetRef ref) async {
    state = Interpreter(ref: ref, context: context);
    final global = await ref.read(Story.prog.notifier).loadInitialProg();

    globalEnv.def('print', print);

    globalEnv.def('schedule', (params) async {
      final time = params[0];
      final callback = params[1];
      Future.delayed(
          Duration(milliseconds: (time as double).toInt()), () => callback([]));
    });

    globalEnv.def('parallel', (params) async {
      List<AnimationEntity> animations = [];
      for (var p in params) {
        if (p.runtimeType == AnimationEntity) {
          animations.add(p);
        }
      }
      return AnimationSequencer(parallel: animations);
    });

    state!.eval(global.topLevelNode, globalEnv, isTopLevelProg: true);
  }
}

class GSGlobalState {
  static final scenes =
      StateNotifierProvider<_ScenesNotifier, Map<String, SceneEntity>>((ref) {
    return _ScenesNotifier(onStartFound: (scene) {
      ref.read(GSContainerState.currentSceneName.notifier).set(scene.name);
    });
  });

  static final interpreter =
      StateNotifierProvider<_InterpreterNotifier, Interpreter?>((ref) {
    return _InterpreterNotifier();
  });
}
