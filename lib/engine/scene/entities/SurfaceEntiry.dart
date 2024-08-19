import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fquest_engine/cmp/ast/nodes/base/BaseNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/surface/SurfaceNode.dart';
import 'package:fquest_engine/engine/scene/entities/SpriteEntity.dart';

import '../../ast/interpreter/models/EvalResult.dart';

class _SpriteNotifier extends StateNotifier<Map<String, SpriteEntity>> {
  _SpriteNotifier(Map<String, SpriteEntity> state) : super(state);

  add(SurfaceEntity surfaceEntity, SpriteEntity spriteEntity) {
    if (surfaceEntity.singleSprite) {
      removeAll();
    }
    state[spriteEntity.label] = spriteEntity;
  }

  remove(String label) {
    state.remove(label);
  }

  removeAll() {
    state = {};
  }

  SpriteEntity? get(String label) {
    return state[label];
  }
}

class SurfaceEntity {
  String label;
  double zIndex;
  bool singleSprite;
  StateNotifierProvider<_SpriteNotifier, Map<String, SpriteEntity>> sprites =
      StateNotifierProvider<_SpriteNotifier, Map<String, SpriteEntity>>((ref) {
    return _SpriteNotifier({});
  });

  SurfaceEntity(
      {required this.label, required this.zIndex, this.singleSprite = false});

  static Future<SurfaceEntity> fromNode(
      SurfaceNode node, Future<EvalResult> Function(BaseNode) eval) async {
    final label = node.label;
    final zIndex = node.zIndex;
    final singleSprite = node.singleSprite ?? false;

    return SurfaceEntity(
        label: label, zIndex: zIndex, singleSprite: singleSprite);
  }
}
