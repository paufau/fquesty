import 'package:fquest_engine/cmp/ast/nodes/base/BaseNode.dart';
import 'package:json_annotation/json_annotation.dart';

part 'WaitNode.g.dart';

@JsonSerializable(explicitToJson: true)
class WaitNode extends BaseNode {
  WaitNode() : super(type: ENodeType.WAIT);

  factory WaitNode.fromJson(Map<String, dynamic> json) =>
      _$WaitNodeFromJson(json);

  Map<String, dynamic> toJson() => _$WaitNodeToJson(this);
}