import 'package:fquest_engine/cmp/ast/nodes/anchor/AnchorNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/animate/AnimateNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/animation/AnimationNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/assign/AssignNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/base/BaseNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/binary/BinaryNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/bool/BoolNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/call/CallNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/character/CharacterNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/clean/CleanNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/dialog/option/DialogOptionNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/func/FuncNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/hide/HideNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/if/IfNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/jump/JumpNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/num/NumNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/pause/PauseNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/play/PlayNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/player/PlayerNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/prog/ProgNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/return/ReturnNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/scene/SceneNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/show/ShowNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/speech/SpeechNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/sprite/SpriteNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/str/StrNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/surface/SurfaceNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/var/VarNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/wait/WaitNode.dart';
import 'package:json_annotation/json_annotation.dart';

final Map<String, ENodeType> nodesMap = () {
  Map<String, ENodeType> map = {};

  ENodeType.values.forEach((element) {
    map[element.name] = element;
  });

  return map;
}();

class BaseNodeConverter<T> implements JsonConverter<T, Object?> {
  const BaseNodeConverter();

  @override
  fromJson(Object? json) {
    if (json == null) {
      return null as T;
    }

    if (json is Map<String, dynamic> && json.containsKey('type')) {
      switch (nodesMap[json['type']]) {
        case ENodeType.NUM:
          return NumNode.fromJson(json) as T;
        case ENodeType.STR:
          return StrNode.fromJson(json) as T;
        case ENodeType.BOOL:
          return BoolNode.fromJson(json) as T;
        case ENodeType.VAR:
          return VarNode.fromJson(json) as T;
        case ENodeType.FUNC:
          return FuncNode.fromJson(json) as T;
        case ENodeType.CALL:
          return CallNode.fromJson(json) as T;
        case ENodeType.IF:
          return IfNode.fromJson(json) as T;
        case ENodeType.ASSIGN:
          return AssignNode.fromJson(json) as T;
        case ENodeType.BINARY:
          return BinaryNode.fromJson(json) as T;
        case ENodeType.PROG:
          return ProgNode.fromJson(json) as T;
        case ENodeType.RETURN:
          return ReturnNode.fromJson(json) as T;
        case ENodeType.SCENE:
          return SceneNode.fromJson(json) as T;
        case ENodeType.WAIT:
          return WaitNode.fromJson(json) as T;
        case ENodeType.CHARACTER:
          return CharacterNode.fromJson(json) as T;
        case ENodeType.SHOW:
          return ShowNode.fromJson(json) as T;
        case ENodeType.SPEECH:
          return SpeechNode.fromJson(json) as T;
        case ENodeType.DIALOG_OPTION:
          return DialogOptionNode.fromJson(json) as T;
        case ENodeType.ANCHOR:
          return AnchorNode.fromJson(json) as T;
        case ENodeType.JUMP:
          return JumpNode.fromJson(json) as T;
        case ENodeType.HIDE:
          return HideNode.fromJson(json) as T;
        case ENodeType.PLAYER:
          return PlayerNode.fromJson(json) as T;
        case ENodeType.PLAY:
          return PlayNode.fromJson(json) as T;
        case ENodeType.PAUSE:
          return PauseNode.fromJson(json) as T;
        case ENodeType.SPRITE:
          return SpriteNode.fromJson(json) as T;
        case ENodeType.ANIMATION:
          return AnimationNode.fromJson(json) as T;
        case ENodeType.SURFACE:
          return SurfaceNode.fromJson(json) as T;
        case ENodeType.CLEAN:
          return CleanNode.fromJson(json) as T;
        case ENodeType.ANIMATE:
          return AnimateNode.fromJson(json) as T;
      }
    }

    throw Exception('Unable to deserialize action: $json');
  }

  @override
  Object? toJson(object) => object;
}
