import 'package:fquest_engine/cmp/ast/nodes/base/BaseNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/base/BaseNodeConverter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'IfNode.g.dart';

@JsonSerializable(explicitToJson: true)
class IfNode<T extends BaseNode> extends BaseNode {
  IfNode({required this.condNode, required this.thenNode, this.elseNode}) : super(type: ENodeType.IF);

  @BaseNodeConverter()
  T condNode;
  @BaseNodeConverter()
  T thenNode;
  @BaseNodeConverter()
  T? elseNode;

  factory IfNode.fromJson(Map<String, dynamic> json) =>
      _$IfNodeFromJson(json);

  Map<String, dynamic> toJson() => _$IfNodeToJson(this);
}