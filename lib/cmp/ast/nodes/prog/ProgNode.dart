import 'package:fquest_engine/cmp/ast/nodes/base/BaseNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/base/BaseNodeConverter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ProgNode.g.dart';

@JsonSerializable(explicitToJson: true)
class ProgNode<T extends BaseNode> extends BaseNode {
  ProgNode({required this.prog, required this.anchors, this.usedAssets = const []}) : super(type: ENodeType.PROG);

  @BaseNodeConverter()
  List<T> prog;

  Map<String, int> anchors;
  List<String> usedAssets;

  factory ProgNode.fromJson(Map<String, dynamic> json) =>
      _$ProgNodeFromJson(json);

  Map<String, dynamic> toJson() => _$ProgNodeToJson(this);
}