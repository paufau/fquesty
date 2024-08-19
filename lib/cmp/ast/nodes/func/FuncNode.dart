import 'package:fquest_engine/cmp/ast/nodes/base/BaseNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/base/BaseNodeConverter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'FuncNode.g.dart';

@JsonSerializable(explicitToJson: true)
class FuncNode<T extends BaseNode> extends BaseNode {
  FuncNode({required this.vars, required this.bodyNode}) : super(type: ENodeType.FUNC);

  List<String> vars;
  @BaseNodeConverter()
  T bodyNode;

  factory FuncNode.fromJson(Map<String, dynamic> json) =>
      _$FuncNodeFromJson(json);

  Map<String, dynamic> toJson() => _$FuncNodeToJson(this);
}