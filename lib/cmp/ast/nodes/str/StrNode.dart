import 'package:fquest_engine/cmp/ast/nodes/base/BaseNode.dart';
import 'package:json_annotation/json_annotation.dart';

part 'StrNode.g.dart';

@JsonSerializable(explicitToJson: true)
class StrNode extends BaseNode {
  StrNode({required this.value}) : super(type: ENodeType.STR);

  String value;

  factory StrNode.fromJson(Map<String, dynamic> json) =>
      _$StrNodeFromJson(json);

  Map<String, dynamic> toJson() => _$StrNodeToJson(this);
}