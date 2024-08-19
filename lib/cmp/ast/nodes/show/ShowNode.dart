import 'package:fquest_engine/cmp/ast/nodes/base/BaseNodeConverter.dart';
import 'package:fquest_engine/cmp/ast/nodes/show/props/ShowNodeProps.dart';
import 'package:json_annotation/json_annotation.dart';

import '../base/BaseNode.dart';

part 'ShowNode.g.dart';

@JsonSerializable(explicitToJson: true)
class ShowNode<T extends BaseNode> extends BaseNode {
  @BaseNodeConverter()
  T surface;

  @BaseNodeConverter()
  T sprite;

  ShowNodeProps props;

  ShowNode({required this.sprite, required this.surface, required this.props}) : super(type: ENodeType.SHOW);

  factory ShowNode.fromJson(Map<String, dynamic> json) =>
      _$ShowNodeFromJson(json);

  Map<String, dynamic> toJson() => _$ShowNodeToJson(this);
}