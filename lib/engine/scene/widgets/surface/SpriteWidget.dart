import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fquest_engine/engine/scene/entities/AnimationSequencer.dart';
import 'package:fquest_engine/engine/scene/entities/SpriteEntity.dart';
import 'package:fquest_engine/engine/scene/entities/SurfaceEntiry.dart';
import 'package:fquest_engine/engine/scene/state/GSContainerState.dart';

import '../../../../cmp/ast/nodes/animation/AnimationNode.dart';
import '../../../character/Position.dart';
import '../../../services/animation/AnimationScheduler.dart';
import '../../entities/AnimationEntity.dart';

class SpriteWidget extends ConsumerStatefulWidget {
  const SpriteWidget(
      {Key? key, required this.spriteEntity, required this.surfaceEntity})
      : super(key: key);

  final SpriteEntity spriteEntity;
  final SurfaceEntity surfaceEntity;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _SpriteWidgetState();
  }
}

class _SpriteWidgetState extends ConsumerState<SpriteWidget>
    with TickerProviderStateMixin {
  Function() removeListener = () => null;
  Position position = Position(left: 0, bottom: 0);

  double opacity = 1;
  Duration opacityDuration = const Duration(milliseconds: 0);

  double scale = 1;
  Duration scaleDuration = const Duration(milliseconds: 0);

  Offset offset = Offset.zero;
  Duration offsetDuration = const Duration(milliseconds: 0);

  bool isStateInitialized = false;

  removeCurrentSprite() {
    ref
        .read(widget.surfaceEntity.sprites.notifier)
        .remove(widget.spriteEntity.label);
  }

  @override
  dispose() {
    removeListener();
    super.dispose();
  }

  checkAnimationType(AnimationEntity animation, String? animationName) {
    if (animation.animationName != animationName) {
      throw Exception(
          'Expecting $animationName animation but get ${animation.animationName}');
    }
  }

  bind(Function() callback) {
    if (isStateInitialized == false) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        callback();
      });
    } else {
      callback();
    }
  }

  fadeInAnimationRunner(AnimationEntity animation) {
    checkAnimationType(animation, AnimationNamesMap[EAnimationName.FADE_IN]);

    opacityDuration =
        Duration(milliseconds: (animation.props['duration'] as double).toInt());

    bind(() => setState(() {
          opacity = 1;
        }));
  }

  setDefaultsAnimationRunner(AnimationEntity animation) {
    checkAnimationType(animation, 'setDefaults');
    if (animation.props['opacity'] != null) {
      opacity = animation.props['opacity'];
    }
    if (animation.props['scale'] != null) {
      scale = animation.props['scale'];
    }
    if (animation.props['position'] != null) {
      position.merge(animation.props['position']);
    }
    if (animation.props['slideY'] != null) {
      offset += Offset(0, animation.props['slideY']);
    }
    if (animation.props['slideX'] != null) {
      offset += Offset(animation.props['slideX'], 0);
    }
  }

  scaleAnimationRunner(AnimationEntity animation) {
    checkAnimationType(animation, AnimationNamesMap[EAnimationName.SCALE]);
    final _scale = animation.props['scale'] as double;
    final _durationMs = (animation.props['duration'] as double).toInt();

    bind(() => setState(() {
      scale = _scale;
      scaleDuration = Duration(milliseconds: _durationMs);
    }));
  }

  fadeOutAnimationRunner(AnimationEntity animation) {
    checkAnimationType(animation, AnimationNamesMap[EAnimationName.FADE_OUT]);
    final durationMs = (animation.props['duration'] as double).toInt();

    bind(() => setState(() {
      opacityDuration = Duration(milliseconds: durationMs);
      opacity = 0;
    }));
  }

  slideAnimationRunner(AnimationEntity animation) {
    checkAnimationType(animation, AnimationNamesMap[EAnimationName.SLIDE]);
    final slideX = animation.props['slideX'];
    final slideY = animation.props['slideY'];
    final durationMs = (animation.props['duration'] as double).toInt();

    bind(() => setState((){
      offsetDuration = Duration(milliseconds: durationMs);
      offset += Offset(slideX ?? 0, slideY ?? 0);
    }));
  }

  deleteAnimationRunner(AnimationEntity animation) {
    checkAnimationType(animation, 'delete');
    final durationMs = (animation.props['duration'] as double).toInt();
    Future.delayed(Duration(milliseconds: durationMs), removeCurrentSprite);
  }

  runAnimationsSequence(dynamic sequencer) {
    Map<String, Function(AnimationEntity)> animationRunners = {
      'setDefaults': setDefaultsAnimationRunner,
      'delete': deleteAnimationRunner,
      AnimationNamesMap[EAnimationName.FADE_IN]!: fadeInAnimationRunner,
      AnimationNamesMap[EAnimationName.SCALE]!: scaleAnimationRunner,
      AnimationNamesMap[EAnimationName.FADE_OUT]!: fadeOutAnimationRunner,
      AnimationNamesMap[EAnimationName.SLIDE]!: slideAnimationRunner,
    };

    if (sequencer != null) {
      if (sequencer.runtimeType == AnimationSequencer) {
        sequencer as AnimationSequencer;

        for (var animation in sequencer.parallel) {
          final runner = animationRunners[animation.animationName];
          if (runner != null) {
            runner(animation);
          }

        }
      } else {
        throw Exception('Expecting instance of AnimationNode');
      }
    }
  }

  @override
  initState() {
    super.initState();

    removeListener =
        AnimationScheduler.addListener(widget.spriteEntity, (sequencer) {
      runAnimationsSequence(sequencer);
    });

    final sequencer = AnimationScheduler.getAnimation(widget.spriteEntity);
    runAnimationsSequence(sequencer);

    isStateInitialized = true;
  }

  @override
  Widget build(BuildContext context) {
    final sprite = widget.spriteEntity;
    final computeSize = ref.read(GSContainerState.computeSize);

    return Positioned(
        left: position.left == null ? null : computeSize(position.left ?? 0),
        bottom:
            position.bottom == null ? null : computeSize(position.bottom ?? 0),
        top: position.bottom == null ? computeSize(position.top ?? 0) : null,
        right: position.left == null ? computeSize(position.right ?? 0) : null,
        child: SizedBox(
            width: computeSize(sprite.size.width),
            height: computeSize(sprite.size.height),
            child: AnimatedSlide(
              offset: offset,
              duration: offsetDuration,
              child: AnimatedScale(
                scale: scale,
                duration: scaleDuration,
                child: AnimatedOpacity(
                  opacity: opacity,
                  duration: opacityDuration,
                  child: Image(image: AssetImage(sprite.assetPath)),
                ),
              ),
            )));
  }
}
