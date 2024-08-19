import 'package:fquest_engine/cmp/ast/nodes/base/BaseNode.dart';
import 'package:json_annotation/json_annotation.dart';

part 'PauseNode.g.dart';

@JsonSerializable(explicitToJson: true)
class PauseNode extends BaseNode {
  String playerLabel;

  PauseNode({required this.playerLabel}) : super(type: ENodeType.PAUSE);

  factory PauseNode.fromJson(Map<String, dynamic> json) =>
      _$PauseNodeFromJson(json);

  Map<String, dynamic> toJson() => _$PauseNodeToJson(this);
}