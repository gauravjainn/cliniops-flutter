import 'package:json_annotation/json_annotation.dart';

import 'package:clini_app/data/data.dart';

part 'visit_to_form_model.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class VisitToFormModel {
  int? visitId;
  List<StudyConfigurationFormModel>? forms = [];
  DateTime? visitDate;
  int? referenceMin;
  int? referenceMax;

  VisitToFormModel({
    this.visitId,
    this.forms,
    this.visitDate,
    this.referenceMax,
    this.referenceMin,
  });

  factory VisitToFormModel.fromJson(Map json) =>
      _$VisitToFormModelFromJson(json);

  Map<String, dynamic> toJson() => _$VisitToFormModelToJson(this);

  @override
  String toString() =>
      'VisitToFormModel(visitId: $visitId, forms: $forms, visitDate: $visitDate)';
}
