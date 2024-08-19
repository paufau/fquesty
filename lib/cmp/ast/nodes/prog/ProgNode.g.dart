// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProgNode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProgNode<T> _$ProgNodeFromJson<T extends BaseNode>(Map<String, dynamic> json) =>
    ProgNode<T>(
      prog: (json['prog'] as List<dynamic>)
          .map(BaseNodeConverter<T>().fromJson)
          .toList(),
      anchors: Map<String, int>.from(json['anchors'] as Map),
      usedAssets: (json['usedAssets'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    )..type = $enumDecode(_$ENodeTypeEnumMap, json['type']);

Map<String, dynamic> _$ProgNodeToJson<T extends BaseNode>(
        ProgNode<T> instance) =>
    <String, dynamic>{
      'type': _$ENodeTypeEnumMap[instance.type],
      'prog': instance.prog.map(BaseNodeConverter<T>().toJson).toList(),
      'anchors': instance.anchors,
      'usedAssets': instance.usedAssets,
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
