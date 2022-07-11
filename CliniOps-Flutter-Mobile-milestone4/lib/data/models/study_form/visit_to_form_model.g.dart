// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visit_to_form_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisitToFormModel _$VisitToFormModelFromJson(Map json) => VisitToFormModel(
      visitId: json['visitId'] as int?,
      forms: (json['forms'] as List<dynamic>?)
          ?.map((e) => StudyConfigurationFormModel.fromJson(e as Map))
          .toList(),
      visitDate: json['visitDate'] == null
          ? null
          : DateTime.parse(json['visitDate'] as String),
      referenceMax: json['referenceMax'] as int?,
      referenceMin: json['referenceMin'] as int?,
    );

Map<String, dynamic> _$VisitToFormModelToJson(VisitToFormModel instance) =>
    <String, dynamic>{
      'visitId': instance.visitId,
      'forms': instance.forms?.map((e) => e.toJson()).toList(),
      'visitDate': instance.visitDate?.toIso8601String(),
      'referenceMin': instance.referenceMin,
      'referenceMax': instance.referenceMax,
    };
