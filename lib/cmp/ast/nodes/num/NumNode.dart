import 'package:fquest_engine/cmp/ast/nodes/base/BaseNode.dart';
import 'package:json_annotation/json_annotation.dart';

part 'NumNode.g.dart';

@JsonSerializable(explicitToJson: true)
class NumNode extends BaseNode {
  NumNode({required this.value}) : super(type: ENodeType.NUM);

  double value;

  factory NumNode.fromJson(Map<String, dynamic> json) =>
      _$NumNodeFromJson(json);

  Map<String, dynamic> toJson() => _$NumNodeToJson(this);
}