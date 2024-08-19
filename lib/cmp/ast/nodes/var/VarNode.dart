import 'package:fquest_engine/cmp/ast/nodes/base/BaseNode.dart';
import 'package:json_annotation/json_annotation.dart';

part 'VarNode.g.dart';

@JsonSerializable(explicitToJson: true)
class VarNode extends BaseNode {
  VarNode({required this.value}) : super(type: ENodeType.VAR);

  String value;

  factory VarNode.fromJson(Map<String, dynamic> json) =>
      _$VarNodeFromJson(json);

  Map<String, dynamic> toJson() => _$VarNodeToJson(this);
}