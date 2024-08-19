import 'package:fquest_engine/cmp/streams/UuidStream.dart';
import 'package:fquest_engine/engine/scene/entities/AnimationSequencer.dart';


class AnimationScheduler {
  static final Map<dynamic, AnimationSequencer> _scheduledAnimations = {};

  static final UuidStream _listenersUuid = UuidStream();
  static final Map<dynamic, Map<int, Function(AnimationSequencer value)>> _listeners = {};

  static Function() addListener (dynamic key, Function(AnimationSequencer value) cb) {
    final id = _listenersUuid.next();

    _listeners[key] = {
      ...(_listeners[key] ?? {}),
      id: cb
    };

    return () {
      _listeners[key]?.remove(id);
    };
  }

  static broadcastAnimationEvent(dynamic key, AnimationSequencer sequencer) {
    final listeners = _listeners[key];
    if (listeners != null && listeners.keys.isNotEmpty) {
      for (var listener in listeners.values) {
        listener(sequencer);
      }
    }
  }

  static syncScheduleOrBroadcast(dynamic key, AnimationSequencer sequencer) {
    AnimationSequencer? animation = _scheduledAnimations[key];
    if (animation != null) {
      scheduleAnimation(key, sequencer);
    } else {
      broadcastAnimationEvent(key, sequencer);
    }
  }

  static scheduleAnimation (dynamic key, AnimationSequencer sequencer) {
    AnimationSequencer? animation = _scheduledAnimations[key];
    if (animation != null) {
      animation.parallel.addAll(sequencer.parallel);
      print(sequencer.parallel.map((e) => e.animationName));
    } else {
      _scheduledAnimations[key] = sequencer;
    }
  }

  static AnimationSequencer? getAnimation(dynamic key) {
    final value = _scheduledAnimations[key];

    if (_scheduledAnimations.containsKey(key)) {
      _scheduledAnimations.remove(key);
    }

    return value;
  }
}