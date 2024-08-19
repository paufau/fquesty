import 'package:fquest_engine/cmp/ast/nodes/base/BaseNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/character/CharacterNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/sprite/SpriteNode.dart';
import 'package:fquest_engine/engine/ast/interpreter/models/EvalResult.dart';
import 'package:fquest_engine/engine/character/Position.dart';
import 'package:fquest_engine/engine/scene/entities/SpriteEntity.dart';

class CharacterEntity {
  CharacterNode characterNode;
  SpriteEntity? sprite;
  String? name;

  Position position = Position();

  CharacterEntity({required this.characterNode});

  static Future<CharacterEntity> fromNode(CharacterNode node, Future<EvalResult> Function(BaseNode) eval) async {
    CharacterEntity entity = CharacterEntity(characterNode: node);

    if (node.name != null) {
      entity.name = (await eval(node.name!)).value;
    }

    if (node.sprite != null && node.sprite.runtimeType == SpriteNode) {
      entity.sprite = await SpriteEntity.fromNode(node.sprite as SpriteNode, eval);
    }

    return entity;
  }
}
