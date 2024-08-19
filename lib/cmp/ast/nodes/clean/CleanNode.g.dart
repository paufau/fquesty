// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CleanNode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CleanNode<T> _$CleanNodeFromJson<T extends BaseNode>(
        Map<String, dynamic> json) =>
    CleanNode<T>(
      surface: BaseNodeConverter<T>().fromJson(json['surface']),
    )..type = $enumDecode(_$ENodeTypeEnumMap, json['type']);

Map<String, dynamic> _$CleanNodeToJson<T extends BaseNode>(
        CleanNode<T> instance) =>
    <String, dynamic>{
      'type': _$ENodeTypeEnumMap[instance.type],
      'surface': BaseNodeConverter<T>().toJson(instance.surface),
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
