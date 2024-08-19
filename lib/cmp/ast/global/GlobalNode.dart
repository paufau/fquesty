import 'package:fquest_engine/cmp/ast/nodes/base/BaseNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/base/BaseNodeConverter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'GlobalNode.g.dart';

@JsonSerializable(explicitToJson: true)
class GlobalNode<T extends BaseNode> {
  GlobalNode({required this.scenes, required this.topLevelNode});

  Set<String> scenes;

  @BaseNodeConverter()
  T topLevelNode;

  factory GlobalNode.fromJson(Map<String, dynamic> json) =>
      _$GlobalNodeFromJson(json);

  Map<String, dynamic> toJson() => _$GlobalNodeToJson(this);
}
