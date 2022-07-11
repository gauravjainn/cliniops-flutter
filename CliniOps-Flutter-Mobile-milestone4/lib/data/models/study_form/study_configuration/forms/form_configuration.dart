import 'package:clini_app/data/data.dart';
import 'package:clini_app/utils/utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'form_configuration.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class StudyConfigurationFormModel {
  @JsonKey(name: 'form_id', fromJson: parseInt)
  int? formId;

  @JsonKey(name: 'form_type_id', fromJson: parseInt)
  int? formTypeId;

  @JsonKey(name: 'st_conf_forms_deleted_at', fromJson: parseInt)
  int? confFormsDeletedAt;

  // TODO: this can be enum need to check with BE
  @JsonKey(name: 'oid')
  String? oId;

  @JsonKey(name: 'item_groups')
  List<FormItemGroupModel>? itemGroups;

  @JsonKey(name: 'form_name_labels')
  List<StudyLanguageModel>? formNameLabels;

  StudyConfigurationFormModel({
    this.formId,
    this.formTypeId,
    this.confFormsDeletedAt,
    this.oId,
    this.itemGroups,
  });

  factory StudyConfigurationFormModel.fromJson(Map json) =>
      _$StudyConfigurationFormModelFromJson(json);

  Map<String, dynamic> toJson() => _$StudyConfigurationFormModelToJson(this);
}
