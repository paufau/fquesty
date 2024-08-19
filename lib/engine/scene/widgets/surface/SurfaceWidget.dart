import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fquest_engine/engine/scene/entities/SurfaceEntiry.dart';
import 'package:fquest_engine/engine/scene/widgets/surface/SpriteWidget.dart';

class SurfaceWidget extends ConsumerWidget {
  const SurfaceWidget({Key? key, required this.surfaceEntity})
      : super(key: key);

  final SurfaceEntity surfaceEntity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sprites = ref.watch(surfaceEntity.sprites);

    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      bottom: 0,
      child: Stack(children: [
        for (var sprite in sprites.values)
          SpriteWidget(
            surfaceEntity: surfaceEntity,
            spriteEntity: sprite,
            key: Key(sprite.label),
          )
      ]),
    );
  }
}
