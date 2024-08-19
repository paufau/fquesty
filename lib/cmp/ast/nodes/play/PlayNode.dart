import 'package:fquest_engine/cmp/ast/nodes/base/BaseNode.dart';
import 'package:json_annotation/json_annotation.dart';

part 'PlayNode.g.dart';

@JsonSerializable(explicitToJson: true)
class PlayNode extends BaseNode {
  String playerLabel;
  String assetPath;

  PlayNode({required this.assetPath, required this.playerLabel}) : super(type: ENodeType.PLAY);

  factory PlayNode.fromJson(Map<String, dynamic> json) =>
      _$PlayNodeFromJson(json);

  Map<String, dynamic> toJson() => _$PlayNodeToJson(this);
}