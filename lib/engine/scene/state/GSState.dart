import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fquest_engine/engine/scene/entities/AnimationEntity.dart';
import 'package:fquest_engine/engine/scene/entities/AnimationSequencer.dart';
import 'package:fquest_engine/engine/scene/entities/DialogOptionEntity.dart';
import 'package:fquest_engine/engine/scene/entities/SpeechEntity.dart';

import '../../services/animation/AnimationScheduler.dart';
import 'GSGlobalState.dart';

class _Speech extends StateNotifier<SpeechEntity?> {
  _Speech() : super(null);

  void set(SpeechEntity? speech) {
    state = speech;
  }
}

class _SceneName extends StateNotifier<String?> {
  _SceneName() : super(null);

  void setName(String name) {
    state = name;
  }
}

class GSState {
  static final speech = StateNotifierProvider<_Speech, SpeechEntity?>((ref) {
    return _Speech();
  });

  static final sceneName = StateNotifierProvider<_SceneName, String?>((ref) {
    return _SceneName();
  });

  static shouldUpdateScene(WidgetRef ref, String currentSceneName) {
    final sceneId = ref.read(GSState.sceneName.notifier).state;
    return (sceneId != null) || sceneId != currentSceneName;
  }

  static onSelectDialogOption(
      BuildContext context, WidgetRef ref, DialogOptionEntity option) {
    option.wasSelected = true;
    ref
        .read(GSGlobalState.interpreter.notifier)
        .state
        ?.eval(option.onSelectProg, option.environment);
  }

  static onPressNext(WidgetRef ref) {
    final isTextAnimationActive = AnimationScheduler.getAnimation('speechText');

    if (isTextAnimationActive != null) {
      AnimationScheduler.scheduleAnimation(
          'speechTextSetFull',
          AnimationSequencer(parallel: [
            AnimationEntity(animationName: 'speechTextSetFull', props: {})
          ]));
    } else {
      final speech = ref.read(GSState.speech.notifier).state;
      if ((speech != null && speech.dialogOptions.isEmpty) || speech == null) {
        ref.read(GSGlobalState.interpreter.notifier).state?.evalNext();
      }
    }
  }
}
