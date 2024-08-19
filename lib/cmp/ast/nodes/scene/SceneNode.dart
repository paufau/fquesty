import 'package:fquest_engine/cmp/ast/nodes/base/BaseNode.dart';
import 'package:json_annotation/json_annotation.dart';

import '../base/BaseNodeConverter.dart';

part 'SceneNode.g.dart';

@JsonSerializable(explicitToJson: true)
class SceneNode<T extends BaseNode> extends BaseNode {
  SceneNode({required this.prog, required this.name}) : super(type: ENodeType.SCENE);

  String name;
  @BaseNodeConverter()
  T prog;

  factory SceneNode.fromJson(Map<String, dynamic> json) =>
      _$SceneNodeFromJson(json);

  Map<String, dynamic> toJson() => _$SceneNodeToJson(this);
}