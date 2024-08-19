import 'package:fquest_engine/cmp/ast/nodes/base/BaseNode.dart';
import 'package:json_annotation/json_annotation.dart';

part 'AnchorNode.g.dart';

@JsonSerializable(explicitToJson: true)
class AnchorNode extends BaseNode {
  String label;

  AnchorNode({required this.label}) : super(type: ENodeType.ANCHOR);

  factory AnchorNode.fromJson(Map<String, dynamic> json) =>
      _$AnchorNodeFromJson(json);

  Map<String, dynamic> toJson() => _$AnchorNodeToJson(this);
}