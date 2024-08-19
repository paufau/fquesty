import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fquest_engine/cmp/ast/nodes/animate/AnimateNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/animation/AnimationNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/assign/AssignNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/base/BaseNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/binary/BinaryNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/bool/BoolNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/call/CallNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/character/CharacterNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/clean/CleanNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/func/FuncNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/hide/HideNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/if/IfNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/jump/JumpNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/num/NumNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/pause/PauseNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/play/PlayNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/player/PlayerNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/prog/ProgNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/return/ReturnNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/scene/SceneNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/show/ShowNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/speech/SpeechNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/sprite/SpriteNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/str/StrNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/surface/SurfaceNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/var/VarNode.dart';
import 'package:fquest_engine/engine/ast/interpreter/interruptService/InterruptService.dart';
import 'package:fquest_engine/engine/ast/interpreter/models/EvalResult.dart';
import 'package:fquest_engine/engine/scene/entities/AnimationEntity.dart';
import 'package:fquest_engine/engine/scene/entities/AnimationSequencer.dart';
import 'package:fquest_engine/engine/scene/entities/CharacterEntity.dart';
import 'package:fquest_engine/engine/scene/entities/SceneEntity.dart';
import 'package:fquest_engine/engine/scene/entities/SpeechEntity.dart';
import 'package:fquest_engine/engine/scene/entities/SpriteEntity.dart';
import 'package:fquest_engine/engine/scene/entities/SurfaceEntiry.dart';
import 'package:fquest_engine/engine/scene/state/GSContainerState.dart';
import 'package:fquest_engine/engine/scene/state/GSGlobalState.dart';
import 'package:fquest_engine/engine/services/animation/AnimationScheduler.dart';
import 'package:fquest_engine/engine/services/player/PlayerService.dart';
import 'package:fquest_engine/engine/story/Story.dart';

import '../../scene/state/GSState.dart';
import 'environment/Environment.dart';

class Interpreter {
  Interpreter({required this.ref, required this.context});

  WidgetRef ref;
  BuildContext context;

  InterruptService interruptService = InterruptService();

  preloadAssets(List<String> assets) async {
    for (var asset in assets) {
      precacheImage(AssetImage(asset), context);
    }
  }

  dynamic applyOperation(String op, dynamic a, dynamic b) {
    num(dynamic x) {
      if (x is double) {
        return x;
      }
      throw Exception('Expected number, but got $x');
    }

    div(dynamic x) {
      if (num(x) != 0) {
        return x;
      }
      throw Exception('Divide by zero');
    }

    switch (op) {
      case '+':
        return num(a) + num(b);
      case '-':
        return num(a) - num(b);
      case '*':
        return num(a) * num(b);
      case '/':
        return num(a) / div(b);
      case '%':
        return num(a) % div(b);
      case '&&':
        return a && b;
      case '||':
        return a || b;
      case '<':
        return num(a) < num(b);
      case '>':
        return num(a) > num(b);
      case '<=':
        return num(a) <= num(b);
      case '>=':
        return num(a) >= num(b);
      case '==':
        return a == b;
      case '!=':
        return a != b;
    }

    throw Exception('Unable to apply operator $op');
  }

  makeFunction(FuncNode node, Environment env) {
    return (List<dynamic> args) {
      final names = node.vars;
      final scope = env.extend();
      for (int i = 0; i < names.length; i++) {
        if (args[i] != null) {
          scope.def(names[i], args[i]);
        } else {
          throw Exception('Undefined value of variable "${names[i]}"');
        }
      }
      return eval(node.bodyNode, scope, autoLaunchNextProg: false);
    };
  }

  Future<EvalResult> evalNext() async {
    final node = interruptService.getNextNode();

    if (node != null) {
      return eval(node.progNode, node.progEnv, skipProgPushing: true);
    }
    return EvalResult(value: true);
  }

  Future<AnimationSequencer> evalAnimationSequencer(
      BaseNode node, Environment env) async {
    final maybeAnimationSequencer = (await eval(node, env)).value;

    if (maybeAnimationSequencer.runtimeType == AnimationEntity) {
      return AnimationSequencer(parallel: [maybeAnimationSequencer]);
    }

    return maybeAnimationSequencer;
  }

  Future<SpriteEntity> evalSpriteEntity(BaseNode node, Environment env) async {
    final maybeSpriteEntity = (await eval(node, env)).value;

    if (maybeSpriteEntity.runtimeType == CharacterEntity) {
      maybeSpriteEntity as CharacterEntity;
      if (maybeSpriteEntity.sprite == null) {
        throw Exception(
            'Unable to get sprite from a character without a sprite property');
      }
      return maybeSpriteEntity.sprite!;
    }

    maybeSpriteEntity as SpriteEntity;
    return maybeSpriteEntity;
  }

  Future<EvalResult> evalInherited(BaseNode node) {
    final progEntity = interruptService.getNextNode();
    return eval(node, progEntity != null ? progEntity.progEnv : globalEnv);
  }

  Future<EvalResult> eval(BaseNode node, Environment env,
      {bool skipProgPushing = false,
      bool autoLaunchNextProg = true,
      isTopLevelProg = false}) async {
    // print(node.type);
    switch (node.type) {
      case ENodeType.NUM:
        return EvalResult(value: (node as NumNode).value);
      case ENodeType.STR:
        return EvalResult(value: (node as StrNode).value);
      case ENodeType.BOOL:
        return EvalResult(value: (node as BoolNode).value);
      case ENodeType.VAR:
        return EvalResult(value: env.get((node as VarNode).value));
      case ENodeType.FUNC:
        return EvalResult(value: makeFunction(node as FuncNode, env));
      case ENodeType.CALL:
        final func = (await eval((node as CallNode).func, env)).value;
        List<dynamic> args = [];

        for (var v in node.args) {
          args.add((await eval(v, env)).value);
        }

        return EvalResult(value: func(args));
      case ENodeType.IF:
        final condition = await eval((node as IfNode).condNode, env);

        if (condition.isInterrupt) return condition;

        if (condition.value == true) {
          return eval(node.thenNode, env);
        } else if (node.elseNode != null) {
          return eval(node.elseNode!, env);
        }
        return EvalResult(value: false);
      case ENodeType.ASSIGN:
        if ((node as AssignNode).leftNode.type != ENodeType.VAR) {
          throw Exception('Cannot assign to ${node.leftNode.toJson()}');
        }
        return EvalResult(
            value: env.set((node.leftNode as VarNode).value,
                (await eval(node.rightNode, env)).value));
      case ENodeType.BINARY:
        return EvalResult(
            value: applyOperation(
                (node as BinaryNode).operator,
                (await eval(node.leftNode, env)).value,
                (await eval(node.rightNode, env)).value));
      case ENodeType.PROG:
        node as ProgNode;
        if (!skipProgPushing) {
          interruptService.progStack
              .push(node, isTopLevelProg ? env : env.extend());
        }

        final progEntity = interruptService.getNextNode();

        if (progEntity != null) {
          final newEnv = progEntity.progEnv;

          if (progEntity.progNode.usedAssets.isNotEmpty) {
            preloadAssets(progEntity.progNode.usedAssets);
          }

          for (int i = progEntity.lastEvaluatedIndex + 1;
              i < progEntity.progNode.prog.length;
              i++) {
            progEntity.lastEvaluatedIndex = i;
            final res = await eval(progEntity.progNode.prog[i], newEnv);
            if (res.isInterrupt) {
              return res;
            }
          }

          if (autoLaunchNextProg) {
            evalNext();
          }
        }

        return EvalResult(value: true);
      case ENodeType.RETURN:
        return eval((node as ReturnNode).returnNode, env);
      case ENodeType.SCENE:
        node as SceneNode;
        ref.read(GSGlobalState.scenes.notifier).set(SceneEntity.fromNode(node));

        return eval(node.prog, globalEnv);
      case ENodeType.WAIT:
        return EvalResult(value: true, isInterrupt: true);
      case ENodeType.CHARACTER:
        node as CharacterNode;
        final characterEntity =
            await CharacterEntity.fromNode(node, (n) => eval(n, env));

        env.set(node.label, characterEntity);

        return EvalResult(value: characterEntity);
      case ENodeType.SHOW:
        node as ShowNode;

        SurfaceEntity surfaceEntity = (await eval(node.surface, env)).value;
        SpriteEntity spriteEntity = await evalSpriteEntity(node.sprite, env);

        ref
            .read(surfaceEntity.sprites.notifier)
            .add(surfaceEntity, spriteEntity);

        AnimationSequencer animationSequencer = node.props.animation != null
            ? await evalAnimationSequencer(node.props.animation!, env)
            : AnimationSequencer(parallel: []);

        animationSequencer.parallel
            .insert(0, AnimationEntity(animationName: 'setDefaults', props: {
          "opacity": node.props.opacity != null
              ? (await eval(node.props.opacity!, env)).value
              : null,
          "scale": node.props.scale != null
              ? (await eval(node.props.scale!, env)).value
              : null,
          "slideX": node.props.slideX != null
              ? (await eval(node.props.slideX!, env)).value
              : null,
          "slideY": node.props.slideY != null
              ? (await eval(node.props.slideY!, env)).value
              : null,
          "position": node.props.position,
        }));

        AnimationScheduler.scheduleAnimation(spriteEntity, animationSequencer);

        return EvalResult(value: true);
      case ENodeType.SPEECH:
        final speech = node as SpeechNode;
        ref
            .read(GSState.speech.notifier)
            .set(await SpeechEntity.create(speech, (n) => eval(n, env), env));
        return EvalResult(value: true, isInterrupt: true);
      case ENodeType.DIALOG_OPTION:
        return EvalResult(value: true);
      case ENodeType.ANCHOR:
        return EvalResult(value: true);
      case ENodeType.JUMP:
        final scenes = ref.read(Story.prog.notifier).state?.scenes;
        final label = (node as JumpNode).label;

        if (scenes != null && scenes.contains(label)) {
          final scene = await ref.read(Story.prog.notifier).loadScene(label);
          eval(scene, env);
        } else {
          interruptService.jumpToAnchor(label);
          evalNext();
        }

        return EvalResult(value: true, isInterrupt: true);
      case ENodeType.HIDE:
        node as HideNode;

        SpriteEntity spriteEntity = await evalSpriteEntity(node.sprite, env);

        AnimationSequencer animationSequencer = node.props.animation != null
            ? await evalAnimationSequencer(node.props.animation!, env)
            : AnimationSequencer(parallel: []);

        double longestAnimationDuration = 0;
        for (var animation in animationSequencer.parallel) {
          if (animation.props['duration'] != null &&
              animation.props['duration'] > longestAnimationDuration) {
            longestAnimationDuration = animation.props['duration'];
          }
        }

        animationSequencer.parallel.add(AnimationEntity(
            animationName: 'delete',
            props: {"duration": longestAnimationDuration}));

        AnimationScheduler.broadcastAnimationEvent(
            spriteEntity, animationSequencer);

        return EvalResult(value: true);
      case ENodeType.PLAYER:
        PlayerService.add(node as PlayerNode);
        return EvalResult(value: true);
      case ENodeType.PLAY:
        final playNode = node as PlayNode;
        final player = PlayerService.get(playNode.playerLabel);
        player?.play(playNode.assetPath);
        return EvalResult(value: true);
      case ENodeType.PAUSE:
        final player = PlayerService.get((node as PauseNode).playerLabel);
        player?.pause();
        return EvalResult(value: true);
      case ENodeType.SPRITE:
        node as SpriteNode;

        final spriteEntity =
            await SpriteEntity.fromNode(node, (n) => eval(n, env));
        env.set(spriteEntity.label, spriteEntity);

        return EvalResult(value: spriteEntity);
      case ENodeType.ANIMATION:
        node as AnimationNode;
        Map<String, dynamic> entityProps = {};
        for (var propKey in node.props.keys) {
          entityProps[propKey] = (await eval(node.props[propKey]!, env)).value;
        }

        final animationEntity = AnimationEntity(
            animationName: node.animationName, props: entityProps);

        return EvalResult(value: animationEntity);
      case ENodeType.SURFACE:
        node as SurfaceNode;
        final surfaceEntity =
            await SurfaceEntity.fromNode(node, (n) => eval(n, env));

        ref.read(GSContainerState.surfaces.notifier).add(surfaceEntity);
        env.set(surfaceEntity.label, surfaceEntity);

        return EvalResult(value: surfaceEntity);
      case ENodeType.CLEAN:
        node as CleanNode;
        if (node.surface.type == ENodeType.VAR &&
            (node.surface as VarNode).value == 'dialog') {
          ref.read(GSState.speech.notifier).set(null);
        } else {
          SurfaceEntity surface = (await eval(node.surface, env)).value;
          ref.read(surface.sprites.notifier).removeAll();
        }

        return EvalResult(value: true);
      case ENodeType.ANIMATE:
        node as AnimateNode;

        SpriteEntity spriteEntity = await evalSpriteEntity(node.sprite, env);
        AnimationSequencer? animationSequencer =
            await evalAnimationSequencer(node.animation, env);

        AnimationScheduler.syncScheduleOrBroadcast(
            spriteEntity, animationSequencer);

        return EvalResult(value: true);
    }
  }
}
