import 'package:fquest_engine/cmp/ast/nodes/base/BaseNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/base/BaseNodeConverter.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../animation/AnimationNode.dart';

part 'HideNodeProps.g.dart';

@JsonSerializable(explicitToJson: true)
class HideNodeProps<T extends BaseNode> {
  HideNodeProps();

  @BaseNodeConverter()
  T? animation;

  factory HideNodeProps.fromJson(Map<String, dynamic> json) =>
      _$HideNodePropsFromJson(json);

  Map<String, dynamic> toJson() => _$HideNodePropsToJson(this);
}
