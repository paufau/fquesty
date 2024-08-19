import 'package:fquest_engine/cmp/ast/nodes/base/BaseNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/base/BaseNodeConverter.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../engine/character/Position.dart';

part 'SpriteNode.g.dart';

@JsonSerializable(explicitToJson: true)
class SpriteNode<T extends BaseNode> extends BaseNode {
  String label;

  @BaseNodeConverter()
  T assetPath;

  SpriteNode({required this.assetPath, required this.label}) : super(type: ENodeType.SPRITE);

  factory SpriteNode.fromJson(Map<String, dynamic> json) =>
      _$SpriteNodeFromJson(json);

  Map<String, dynamic> toJson() => _$SpriteNodeToJson(this);
}