// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Position.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Position _$PositionFromJson(Map<String, dynamic> json) => Position(
      left: (json['left'] as num?)?.toDouble(),
      top: (json['top'] as num?)?.toDouble(),
      bottom: (json['bottom'] as num?)?.toDouble(),
      right: (json['right'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PositionToJson(Position instance) => <String, dynamic>{
      'left': instance.left,
      'top': instance.top,
      'bottom': instance.bottom,
      'right': instance.right,
    };
