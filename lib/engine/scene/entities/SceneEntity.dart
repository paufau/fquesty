import 'package:fquest_engine/cmp/ast/nodes/base/BaseNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/scene/SceneNode.dart';

class SceneEntity {
  SceneEntity({required this.name, required this.nodes});

  String name;
  BaseNode nodes;

  factory SceneEntity.fromNode (SceneNode node) {
    return SceneEntity(name: node.name, nodes: node.prog);
  }
}