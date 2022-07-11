import 'package:clini_app/utils/custom_json_parser.dart';
import 'package:json_annotation/json_annotation.dart';

part 'annotations_model.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class Annotations {
  @JsonKey(name: 'x_loc', fromJson: parseDouble)
  double? xLoc;
  @JsonKey(name: 'y_loc', fromJson: parseDouble)
  double? yLoc;
  String? annotation;
  double scaling;

  Annotations({this.xLoc, this.yLoc, this.annotation, this.scaling = 0});

  factory Annotations.fromJson(Map json) => _$AnnotationsFromJson(json);

  Map<String, dynamic> toJson() => _$AnnotationsToJson(this);
}
