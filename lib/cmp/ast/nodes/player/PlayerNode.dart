import 'package:fquest_engine/cmp/ast/nodes/base/BaseNode.dart';
import 'package:json_annotation/json_annotation.dart';

part 'PlayerNode.g.dart';

@JsonSerializable(explicitToJson: true)
class PlayerNode extends BaseNode {
  String label;

  PlayerNode({required this.label }) : super(type: ENodeType.PLAYER);

  factory PlayerNode.fromJson(Map<String, dynamic> json) =>
      _$PlayerNodeFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerNodeToJson(this);
}