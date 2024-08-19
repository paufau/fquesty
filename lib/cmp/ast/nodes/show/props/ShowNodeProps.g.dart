// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ShowNodeProps.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShowNodeProps<T> _$ShowNodePropsFromJson<T extends BaseNode>(
        Map<String, dynamic> json) =>
    ShowNodeProps<T>()
      ..position = json['position'] == null
          ? null
          : Position.fromJson(json['position'] as Map<String, dynamic>)
      ..animation = BaseNodeConverter<T?>().fromJson(json['animation'])
      ..opacity = BaseNodeConverter<T?>().fromJson(json['opacity'])
      ..scale = BaseNodeConverter<T?>().fromJson(json['scale'])
      ..slideX = BaseNodeConverter<T?>().fromJson(json['slideX'])
      ..slideY = BaseNodeConverter<T?>().fromJson(json['slideY']);

Map<String, dynamic> _$ShowNodePropsToJson<T extends BaseNode>(
        ShowNodeProps<T> instance) =>
    <String, dynamic>{
      'position': instance.position?.toJson(),
      'animation': BaseNodeConverter<T?>().toJson(instance.animation),
      'opacity': BaseNodeConverter<T?>().toJson(instance.opacity),
      'scale': BaseNodeConverter<T?>().toJson(instance.scale),
      'slideX': BaseNodeConverter<T?>().toJson(instance.slideX),
      'slideY': BaseNodeConverter<T?>().toJson(instance.slideY),
    };
