import 'package:fquest_engine/cmp/ast/nodes/base/BaseNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/base/BaseNodeConverter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'AnimateNode.g.dart';

@JsonSerializable(explicitToJson: true)
class AnimateNode<T extends BaseNode> extends BaseNode {
  @BaseNodeConverter()
  T sprite;

  @BaseNodeConverter()
  T animation;

  AnimateNode({required this.sprite, required this.animation}) : super(type: ENodeType.ANIMATE);

  factory AnimateNode.fromJson(Map<String, dynamic> json) =>
      _$AnimateNodeFromJson(json);

  Map<String, dynamic> toJson() => _$AnimateNodeToJson(this);
}