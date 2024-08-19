import 'package:fquest_engine/cmp/ast/nodes/base/BaseNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/base/BaseNodeConverter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'AssignNode.g.dart';

@JsonSerializable(explicitToJson: true)
class AssignNode<T extends BaseNode> extends BaseNode {
  AssignNode({required this.leftNode, required this.rightNode}) : super (type: ENodeType.ASSIGN);

  @BaseNodeConverter()
  T leftNode;
  @BaseNodeConverter()
  T rightNode;

  factory AssignNode.fromJson(Map<String, dynamic> json) =>
      _$AssignNodeFromJson(json);

  Map<String, dynamic> toJson() => _$AssignNodeToJson(this);
}