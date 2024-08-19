import 'package:fquest_engine/cmp/ast/nodes/base/BaseNode.dart';
import 'package:json_annotation/json_annotation.dart';

part 'BoolNode.g.dart';

@JsonSerializable(explicitToJson: true)
class BoolNode extends BaseNode {
  BoolNode({required this.value}) : super(type: ENodeType.BOOL);

  bool value;

  factory BoolNode.fromJson(Map<String, dynamic> json) =>
      _$BoolNodeFromJson(json);

  Map<String, dynamic> toJson() => _$BoolNodeToJson(this);
}