// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CallNode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CallNode<T> _$CallNodeFromJson<T extends BaseNode>(Map<String, dynamic> json) =>
    CallNode<T>(
      func: BaseNodeConverter<T>().fromJson(json['func']),
      args: (json['args'] as List<dynamic>)
          .map(BaseNodeConverter<T>().fromJson)
          .toList(),
    )..type = $enumDecode(_$ENodeTypeEnumMap, json['type']);

Map<String, dynamic> _$CallNodeToJson<T extends BaseNode>(
        CallNode<T> instance) =>
    <String, dynamic>{
      'type': _$ENodeTypeEnumMap[instance.type],
      'func': BaseNodeConverter<T>().toJson(instance.func),
      'args': instance.args.map(BaseNodeConverter<T>().toJson).toList(),
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
