import 'package:fquest_engine/cmp/ast/nodes/base/BaseNode.dart';
import 'package:json_annotation/json_annotation.dart';

part 'SurfaceNode.g.dart';

@JsonSerializable(explicitToJson: true)
class SurfaceNode extends BaseNode {
  String label;
  double zIndex;
  bool? singleSprite;

  SurfaceNode({required this.label, required this.zIndex, this.singleSprite}) : super(type: ENodeType.SURFACE);

  factory SurfaceNode.fromJson(Map<String, dynamic> json) =>
      _$SurfaceNodeFromJson(json);

  Map<String, dynamic> toJson() => _$SurfaceNodeToJson(this);
}