// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HideNodeProps.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HideNodeProps<T> _$HideNodePropsFromJson<T extends BaseNode>(
        Map<String, dynamic> json) =>
    HideNodeProps<T>()
      ..animation = BaseNodeConverter<T?>().fromJson(json['animation']);

Map<String, dynamic> _$HideNodePropsToJson<T extends BaseNode>(
        HideNodeProps<T> instance) =>
    <String, dynamic>{
      'animation': BaseNodeConverter<T?>().toJson(instance.animation),
    };
