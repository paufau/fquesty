import 'package:fquest_engine/cmp/ast/nodes/base/BaseNode.dart';
import 'package:json_annotation/json_annotation.dart';

part 'JumpNode.g.dart';

@JsonSerializable(explicitToJson: true)
class JumpNode extends BaseNode {
  String label;

  JumpNode({required this.label}) : super(type: ENodeType.JUMP);

  factory JumpNode.fromJson(Map<String, dynamic> json) =>
      _$JumpNodeFromJson(json);

  Map<String, dynamic> toJson() => _$JumpNodeToJson(this);
}