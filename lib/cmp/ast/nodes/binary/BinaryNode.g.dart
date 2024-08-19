// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BinaryNode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BinaryNode<T> _$BinaryNodeFromJson<T extends BaseNode>(
        Map<String, dynamic> json) =>
    BinaryNode<T>(
      operator: json['operator'] as String,
      leftNode: BaseNodeConverter<T>().fromJson(json['leftNode']),
      rightNode: BaseNodeConverter<T>().fromJson(json['rightNode']),
    )..type = $enumDecode(_$ENodeTypeEnumMap, json['type']);

Map<String, dynamic> _$BinaryNodeToJson<T extends BaseNode>(
        BinaryNode<T> instance) =>
    <String, dynamic>{
      'type': _$ENodeTypeEnumMap[instance.type],
      'operator': instance.operator,
      'leftNode': BaseNodeConverter<T>().toJson(instance.leftNode),
      'rightNode': BaseNodeConverter<T>().toJson(instance.rightNode),
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
