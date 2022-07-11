// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisitModel _$VisitModelFromJson(Map json) => VisitModel(
      visitTypeId: parseInt(json['visit_type_id']),
      stConfVisitsDateCreated:
          parseDateTime(json['st_conf_visits_datecreated'] as String?),
      stConfVisitsDateDeletedAt: parseInt(json['st_conf_visits_deleted_at']),
      oId: json['oid'] as String?,
      referenceVisitId: parseInt(json['reference_visit_id']),
      referenceMin: parseInt(json['reference_min']),
      referenceMax: parseInt(json['reference_max']),
      referenceRuleId: parseInt(json['reference_rule_id']),
      order: parseInt(json['order']),
      referenceVisitIdType: parseInt(json['reference_visit_id_type']),
      visitsId: parseInt(json['visits_id']),
      refVisitDate: parseDateTime(json['ref_visit_date'] as String?),
      visitNameLabels: (json['visit_name_labels'] as List<dynamic>?)
          ?.map((e) => StudyLanguageModel.fromJson(e as Map))
          .toList(),
      visitDate: parseDateTime(json['visit_date'] as String?),
    );

Map<String, dynamic> _$VisitModelToJson(VisitModel instance) =>
    <String, dynamic>{
      'visit_type_id': instance.visitTypeId,
      'st_conf_visits_datecreated':
          instance.stConfVisitsDateCreated?.toIso8601String(),
      'st_conf_visits_deleted_at': instance.stConfVisitsDateDeletedAt,
      'oid': instance.oId,
      'reference_visit_id': instance.referenceVisitId,
      'reference_min': instance.referenceMin,
      'reference_max': instance.referenceMax,
      'reference_rule_id': instance.referenceRuleId,
      'order': instance.order,
      'reference_visit_id_type': instance.referenceVisitIdType,
      'visits_id': instance.visitsId,
      'visit_name_labels':
          instance.visitNameLabels?.map((e) => e.toJson()).toList(),
      'ref_visit_date': instance.refVisitDate?.toIso8601String(),
      'visit_date': instance.visitDate?.toIso8601String(),
    };
