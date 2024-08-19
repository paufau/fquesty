import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fquest_engine/engine/scene/state/GSContainerState.dart';
import 'package:fquest_engine/engine/scene/widgets/surface/SurfaceWidget.dart';

class SurfacesContainerWidget extends ConsumerWidget {
  const SurfacesContainerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final surfaces = ref
        .watch(GSContainerState.surfaces)
        .values;
    surfaces.toList().sort((a, b) => a.zIndex.compareTo(b.zIndex));

    return Stack(
      children: [for (var surface in surfaces) SurfaceWidget(
        surfaceEntity: surface, key: Key(surface.label),)
      ],
    );
  }
}