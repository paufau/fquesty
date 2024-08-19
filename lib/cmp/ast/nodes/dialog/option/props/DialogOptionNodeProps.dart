import 'package:fquest_engine/cmp/ast/nodes/base/BaseNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/base/BaseNodeConverter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'DialogOptionNodeProps.g.dart';

@JsonSerializable(explicitToJson: true)
class DialogOptionNodeProps<T extends BaseNode> {
  bool? onceSelectable;
  @BaseNodeConverter()
  T? condition;

  DialogOptionNodeProps();

  factory DialogOptionNodeProps.fromJson(Map<String, dynamic> json) =>
      _$DialogOptionNodePropsFromJson(json);

  Map<String, dynamic> toJson() => _$DialogOptionNodePropsToJson(this);
}