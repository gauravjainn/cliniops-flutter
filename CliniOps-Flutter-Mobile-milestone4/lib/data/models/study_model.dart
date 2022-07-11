import 'package:clini_app/utils/utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'study_model.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class StudyModel {
  @JsonKey(fromJson: parseInt)
  int? id;
  String? title;

  StudyModel({this.id, this.title});

  factory StudyModel.fromJson(Map json) => _$StudyModelFromJson(json);

  Map<String, dynamic> toJson() => _$StudyModelToJson(this);
}
