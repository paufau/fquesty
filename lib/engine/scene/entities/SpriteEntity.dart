import 'dart:ui';

import 'package:fquest_engine/cmp/ast/nodes/base/BaseNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/sprite/SpriteNode.dart';
import 'package:fquest_engine/engine/services/asset/AssetSizeService.dart';

import '../../ast/interpreter/models/EvalResult.dart';

class SpriteEntity {
  String label;
  String assetPath;
  Size size;

  SpriteEntity({required this.size, required this.label, required this.assetPath});

  static Future<SpriteEntity> fromNode (SpriteNode node, Future<EvalResult> Function(BaseNode) eval) async {
    final label = node.label;
    final assetPath = (await eval(node.assetPath)).value;
    final size = await AssetSizeService.getAssetImageSize(assetPath);

    return SpriteEntity(size: size, label: label, assetPath: assetPath);
  }
}