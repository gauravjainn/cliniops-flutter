import 'package:clini_app/data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'study_configuration_model.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class StudyConfigurationModel {
  List<StudyConfigurationFormModel>? forms;

  List<VisitFormModel>? visitForm;

  List<VisitModel>? visits;

  Map<int, Map<int, CodedValue>>? codeList;

  List<GlobalLanguageModel>? languages;

  @JsonKey(name: 'studyparams')
  List<StudyParamModel>? studyParams;

  @JsonKey(name: 'informedConsent')
  List<InformedConsentModel>? informedConsent;

  StudyConfigurationModel({
    this.forms,
    this.visitForm,
    this.visits,
    this.codeList,
    this.languages,
    this.studyParams,
    this.informedConsent,
  });

  factory StudyConfigurationModel.fromJson(Map json) =>
      _$StudyConfigurationModelFromJson(json);

  Map<String, dynamic> toJson() => _$StudyConfigurationModelToJson(this);
}
