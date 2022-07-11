import 'package:clini_app/utils/utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'language_model.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class StudyLanguageModel {
  @JsonKey(name: 'language_id', fromJson: parseInt)
  int? languageId;
  String? label;
  String? name;
  @JsonKey(name: 'visit_name')
  String? visitName;

  StudyLanguageModel({
    this.languageId,
    this.label,
    this.name,
    this.visitName,
  });

  factory StudyLanguageModel.fromJson(Map json) =>
      _$StudyLanguageModelFromJson(json);

  Map<String, dynamic> toJson() => _$StudyLanguageModelToJson(this);

  String get getLabel => label ?? name ?? visitName ?? 'NA';
}
