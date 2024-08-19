import 'package:fquest_engine/cmp/ast/nodes/base/BaseNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/base/BaseNodeConverter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'CleanNode.g.dart';

@JsonSerializable(explicitToJson: true)
class CleanNode<T extends BaseNode> extends BaseNode {
  @BaseNodeConverter()
  T surface;

  CleanNode({required this.surface}) : super(type: ENodeType.CLEAN);

  factory CleanNode.fromJson(Map<String, dynamic> json) =>
      _$CleanNodeFromJson(json);

  Map<String, dynamic> toJson() => _$CleanNodeToJson(this);
}