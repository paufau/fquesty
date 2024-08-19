import 'package:fquest_engine/cmp/ast/nodes/base/BaseNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/base/BaseNodeConverter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ReturnNode.g.dart';

@JsonSerializable(explicitToJson: true)
class ReturnNode<T extends BaseNode> extends BaseNode {
  ReturnNode({required this.returnNode}) : super(type: ENodeType.RETURN);

  @BaseNodeConverter()
  T returnNode;

  factory ReturnNode.fromJson(Map<String, dynamic> json) =>
      _$ReturnNodeFromJson(json);

  Map<String, dynamic> toJson() => _$ReturnNodeToJson(this);
}