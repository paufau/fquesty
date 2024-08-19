// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'IfNode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IfNode<T> _$IfNodeFromJson<T extends BaseNode>(Map<String, dynamic> json) =>
    IfNode<T>(
      condNode: BaseNodeConverter<T>().fromJson(json['condNode']),
      thenNode: BaseNodeConverter<T>().fromJson(json['thenNode']),
      elseNode: BaseNodeConverter<T?>().fromJson(json['elseNode']),
    )..type = $enumDecode(_$ENodeTypeEnumMap, json['type']);

Map<String, dynamic> _$IfNodeToJson<T extends BaseNode>(IfNode<T> instance) =>
    <String, dynamic>{
      'type': _$ENodeTypeEnumMap[instance.type],
      'condNode': BaseNodeConverter<T>().toJson(instance.condNode),
      'thenNode': BaseNodeConverter<T>().toJson(instance.thenNode),
      'elseNode': BaseNodeConverter<T?>().toJson(instance.elseNode),
    };

const _$ENodeTypeEnumMap = {
  ENodeType.NUM: 'NUM',
  ENodeType.STR: 'STR',
  ENodeType.BOOL: 'BOOL',
  ENodeType.VAR: 'VAR',
  ENodeType.FUNC: 'FUNC',
  ENodeType.CALL: 'CALL',
  ENodeType.IF: 'IF',
  ENodeType.ASSIGN: 'ASSIGN',
  ENodeType.BINARY: 'BINARY',
  ENodeType.PROG: 'PROG',
  ENodeType.RETURN: 'RETURN',
  ENodeType.SCENE: 'SCENE',
  ENodeType.WAIT: 'WAIT',
  ENodeType.CHARACTER: 'CHARACTER',
  ENodeType.SHOW: 'SHOW',
  ENodeType.HIDE: 'HIDE',
  ENodeType.SPEECH: 'SPEECH',
  ENodeType.DIALOG_OPTION: 'DIALOG_OPTION',
  ENodeType.ANCHOR: 'ANCHOR',
  ENodeType.JUMP: 'JUMP',
  ENodeType.PLAYER: 'PLAYER',
  ENodeType.PLAY: 'PLAY',
  ENodeType.PAUSE: 'PAUSE',
  ENodeType.SPRITE: 'SPRITE',
  ENodeType.ANIMATION: 'ANIMATION',
  ENodeType.SURFACE: 'SURFACE',
  ENodeType.CLEAN: 'CLEAN',
  ENodeType.ANIMATE: 'ANIMATE',
};
