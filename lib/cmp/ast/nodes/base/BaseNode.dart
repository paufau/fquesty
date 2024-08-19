
import 'package:json_annotation/json_annotation.dart';

part 'BaseNode.g.dart';

enum ENodeType {
  // BASE LOGIC
  NUM,
  STR,
  BOOL,
  VAR,
  FUNC,
  CALL,
  IF,
  ASSIGN,
  BINARY,
  PROG,
  RETURN,
  // ENGINE SPECIFIC
  SCENE,
  WAIT,
  CHARACTER,
  SHOW,
  HIDE,
  SPEECH,
  DIALOG_OPTION,
  ANCHOR,
  JUMP,
  PLAYER,
  PLAY,
  PAUSE,
  SPRITE,
  ANIMATION,
  SURFACE,
  CLEAN,
  ANIMATE,
}

@JsonSerializable()
class BaseNode {
  ENodeType type;

  BaseNode({required this.type});

  factory BaseNode.fromJson(Map<String, dynamic> json) =>
      _$BaseNodeFromJson(json);

  Map<String, dynamic> toJson() => _$BaseNodeToJson(this);
}