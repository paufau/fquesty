// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DialogOptionNodeProps.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DialogOptionNodeProps<T> _$DialogOptionNodePropsFromJson<T extends BaseNode>(
        Map<String, dynamic> json) =>
    DialogOptionNodeProps<T>()
      ..onceSelectable = json['onceSelectable'] as bool?
      ..condition = BaseNodeConverter<T?>().fromJson(json['condition']);

Map<String, dynamic> _$DialogOptionNodePropsToJson<T extends BaseNode>(
        DialogOptionNodeProps<T> instance) =>
    <String, dynamic>{
      'onceSelectable': instance.onceSelectable,
      'condition': BaseNodeConverter<T?>().toJson(instance.condition),
    };
