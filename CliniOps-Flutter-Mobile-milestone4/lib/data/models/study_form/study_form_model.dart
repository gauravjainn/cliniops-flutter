import 'package:clini_app/data/data.dart';
import 'package:clini_app/utils/utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'study_form_model.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class StudyFormModel {
  String? title;
  @JsonKey(name: 'study_id', fromJson: parseInt)
  int? studyId;
  @JsonKey(name: 'studydescription')
  String? studyDescription;
  String? contact;
  @JsonKey(name: 'Status', fromJson: parseInt)
  int? status;
  StudyConfigurationModel? studyConfiguration;

  StudyFormModel({
    this.title,
    this.studyId,
    this.studyDescription,
    this.contact,
    this.status,
    this.studyConfiguration,
  });

  factory StudyFormModel.fromJson(Map json) => _$StudyFormModelFromJson(json);

  Map<String, dynamic> toJson() => _$StudyFormModelToJson(this);
}
