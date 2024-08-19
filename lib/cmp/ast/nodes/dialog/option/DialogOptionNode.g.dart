// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DialogOptionNode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DialogOptionNode<T> _$DialogOptionNodeFromJson<T extends BaseNode>(
        Map<String, dynamic> json) =>
    DialogOptionNode<T>(
      text: BaseNodeConverter<T>().fromJson(json['text']),
      onSelectProg: BaseNodeConverter<T>().fromJson(json['onSelectProg']),
      props: DialogOptionNodeProps<BaseNode>.fromJson(
          json['props'] as Map<String, dynamic>),
    )..type = $enumDecode(_$ENodeTypeEnumMap, json['type']);

Map<String, dynamic> _$DialogOptionNodeToJson<T extends BaseNode>(
        DialogOptionNode<T> instance) =>
    <String, dynamic>{
      'type': _$ENodeTypeEnumMap[instance.type],
      'text': BaseNodeConverter<T>().toJson(instance.text),
      'onSelectProg': BaseNodeConverter<T>().toJson(instance.onSelectProg),
      'props': instance.props.toJson(),
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
