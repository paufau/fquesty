import 'package:fquest_engine/cmp/ast/nodes/base/BaseNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/base/BaseNodeConverter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'AnimationNode.g.dart';

enum EAnimationName {
  FADE_IN,
  FADE_OUT,
  SCALE,
  SLIDE,
}

const Map<EAnimationName, String> AnimationNamesMap = {
  EAnimationName.FADE_IN: 'fadeIn',
  EAnimationName.FADE_OUT: 'fadeOut',
  EAnimationName.SCALE: 'scale',
  EAnimationName.SLIDE: 'slide',
};

@JsonSerializable(explicitToJson: true)
class AnimationNode<T extends BaseNode> extends BaseNode {
  AnimationNode({required this.animationName, required this.props}) : super(type: ENodeType.ANIMATION);

  String animationName;
  @BaseNodeConverter()
  Map<String, T> props;

  factory AnimationNode.fromJson(Map<String, dynamic> json) =>
      _$AnimationNodeFromJson(json);

  Map<String, dynamic> toJson() => _$AnimationNodeToJson(this);
}