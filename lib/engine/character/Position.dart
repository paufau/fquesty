
import 'package:json_annotation/json_annotation.dart';

part 'Position.g.dart';

@JsonSerializable(explicitToJson: true)
class Position {
  double? left;
  double? top;
  double? bottom;
  double? right;

  Position merge (Position position) {
    if (position.left != null) left = position.left;
    if (position.right != null) right = position.right;
    if (position.top != null) top = position.top;
    if (position.bottom != null) bottom = position.bottom;

    if (position.top != null) bottom = null;
    if (position.right != null) left = null;

    return this;
  }

  Position({this.left, this.top, this.bottom, this.right});

  factory Position.fromJson(Map<String, dynamic> json) =>
      _$PositionFromJson(json);

  Map<String, dynamic> toJson() => _$PositionToJson(this);
}