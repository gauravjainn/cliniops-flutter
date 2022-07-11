import 'package:clini_app/data/data.dart';
import 'package:clini_app/utils/utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'visit_model.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class VisitModel {
  @JsonKey(name: 'visit_type_id', fromJson: parseInt)
  int? visitTypeId;

  @JsonKey(name: 'st_conf_visits_datecreated', fromJson: parseDateTime)
  DateTime? stConfVisitsDateCreated;

  @JsonKey(name: 'st_conf_visits_deleted_at', fromJson: parseInt)
  int? stConfVisitsDateDeletedAt;

  @JsonKey(name: 'oid')
  String? oId;

  @JsonKey(name: 'reference_visit_id', fromJson: parseInt)
  int? referenceVisitId;

  @JsonKey(name: 'reference_min', fromJson: parseInt)
  int? referenceMin;

  @JsonKey(name: 'reference_max', fromJson: parseInt)
  int? referenceMax;

  @JsonKey(name: 'reference_rule_id', fromJson: parseInt)
  int? referenceRuleId;

  @JsonKey(fromJson: parseInt)
  int? order;

  @JsonKey(name: 'reference_visit_id_type', fromJson: parseInt)
  int? referenceVisitIdType;

  @JsonKey(name: 'visits_id', fromJson: parseInt)
  int? visitsId;

  @JsonKey(name: 'visit_name_labels')
  List<StudyLanguageModel>? visitNameLabels;

  @JsonKey(name: 'ref_visit_date', fromJson: parseDateTime)
  DateTime? refVisitDate;

  @JsonKey(name: 'visit_date', fromJson: parseDateTime)
  DateTime? visitDate;

  VisitModel({
    this.visitTypeId,
    this.stConfVisitsDateCreated,
    this.stConfVisitsDateDeletedAt,
    this.oId,
    this.referenceVisitId,
    this.referenceMin,
    this.referenceMax,
    this.referenceRuleId,
    this.order,
    this.referenceVisitIdType,
    this.visitsId,
    this.refVisitDate,
    this.visitNameLabels,
    this.visitDate,
  });

  factory VisitModel.fromJson(Map json) => _$VisitModelFromJson(json);

  Map<String, dynamic> toJson() => _$VisitModelToJson(this);
}
