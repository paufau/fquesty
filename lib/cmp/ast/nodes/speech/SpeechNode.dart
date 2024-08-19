import 'package:fquest_engine/cmp/ast/nodes/base/BaseNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/base/BaseNodeConverter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'SpeechNode.g.dart';

@JsonSerializable(explicitToJson: true)
class SpeechNode<T extends BaseNode> extends BaseNode {
  @BaseNodeConverter()
  T character;
  @BaseNodeConverter()
  T text;
  @BaseNodeConverter()
  List<T> dialogOptions;

  SpeechNode({required this.character, required this.text, this.dialogOptions = const []})
      : super(type: ENodeType.SPEECH);

  factory SpeechNode.fromJson(Map<String, dynamic> json) =>
      _$SpeechNodeFromJson(json);

  Map<String, dynamic> toJson() => _$SpeechNodeToJson(this);
}
