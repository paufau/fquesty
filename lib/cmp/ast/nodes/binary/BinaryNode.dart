import 'package:fquest_engine/cmp/ast/nodes/base/BaseNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/base/BaseNodeConverter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'BinaryNode.g.dart';

@JsonSerializable(explicitToJson: true)
class BinaryNode<T extends BaseNode> extends BaseNode {
  BinaryNode({required this.operator, required this.leftNode, required this.rightNode}) : super(type: ENodeType.BINARY);

  String operator;
  @BaseNodeConverter()
  T leftNode;
  @BaseNodeConverter()
  T rightNode;

  factory BinaryNode.fromJson(Map<String, dynamic> json) =>
      _$BinaryNodeFromJson(json);

  Map<String, dynamic> toJson() => _$BinaryNodeToJson(this);
}