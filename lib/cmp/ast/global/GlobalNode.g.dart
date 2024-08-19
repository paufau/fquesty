// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GlobalNode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GlobalNode<T> _$GlobalNodeFromJson<T extends BaseNode>(
        Map<String, dynamic> json) =>
    GlobalNode<T>(
      scenes: (json['scenes'] as List<dynamic>).map((e) => e as String).toSet(),
      topLevelNode: BaseNodeConverter<T>().fromJson(json['topLevelNode']),
    );

Map<String, dynamic> _$GlobalNodeToJson<T extends BaseNode>(
        GlobalNode<T> instance) =>
    <String, dynamic>{
      'scenes': instance.scenes.toList(),
      'topLevelNode': BaseNodeConverter<T>().toJson(instance.topLevelNode),
    };
