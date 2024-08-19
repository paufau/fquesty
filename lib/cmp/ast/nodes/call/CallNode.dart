import 'package:fquest_engine/cmp/ast/nodes/base/BaseNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/base/BaseNodeConverter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'CallNode.g.dart';

@JsonSerializable(explicitToJson: true)
class CallNode<T extends BaseNode> extends BaseNode {
  CallNode({required this.func, required this.args}) : super(type: ENodeType.CALL);

  @BaseNodeConverter()
  T func;
  @BaseNodeConverter()
  List<T> args;

  factory CallNode.fromJson(Map<String, dynamic> json) =>
      _$CallNodeFromJson(json);

  Map<String, dynamic> toJson() => _$CallNodeToJson(this);
}