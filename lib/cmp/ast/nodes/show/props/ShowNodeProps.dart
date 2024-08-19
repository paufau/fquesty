
import 'package:fquest_engine/cmp/ast/nodes/animation/AnimationNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/base/BaseNodeConverter.dart';
import 'package:fquest_engine/engine/character/Position.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../base/BaseNode.dart';

part 'ShowNodeProps.g.dart';

@JsonSerializable(explicitToJson: true)
class ShowNodeProps<T extends BaseNode> {
  Position? position;
  @BaseNodeConverter()
  T? animation;
  @BaseNodeConverter()
  T? opacity;
  @BaseNodeConverter()
  T? scale;
  @BaseNodeConverter()
  T? slideX;
  @BaseNodeConverter()
  T? slideY;

  ShowNodeProps();

  factory ShowNodeProps.fromJson(Map<String, dynamic> json) =>
      _$ShowNodePropsFromJson(json);

  Map<String, dynamic> toJson() => _$ShowNodePropsToJson(this);
}