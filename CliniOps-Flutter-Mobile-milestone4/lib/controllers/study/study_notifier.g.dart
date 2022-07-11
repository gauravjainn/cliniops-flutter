// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_notifier.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudyNotifier _$StudyNotifierFromJson(Map json) => StudyNotifier()
  ..studyCurrentVersion = json['studyCurrentVersion'] as String?
  ..availableStudies = (json['availableStudies'] as List<dynamic>?)
          ?.map((e) => StudyModel.fromJson(e as Map))
          .toList() ??
      []
  ..studyFormModel = json['studyFormModel'] == null
      ? null
      : StudyFormModel.fromJson(json['studyFormModel'] as Map)
  ..visitToFormMapping = (json['visitToFormMapping'] as List<dynamic>?)
          ?.map((e) => VisitToFormModel.fromJson(e as Map))
          .toList() ??
      []
  ..formOnDate = (json['formOnDate'] as List<dynamic>?)
          ?.map((e) => StudyConfigurationFormModel.fromJson(e as Map))
          .toList() ??
      []
  ..studyFormReqModel = json['studyFormReqModel'] == null
      ? null
      : StudyFormReqModel.fromJson(json['studyFormReqModel'] as Map)
  ..consentFormPDf = json['consentFormPDf'] as String?
  ..dateField = json['dateField'] == null
      ? null
      : DateTime.parse(json['dateField'] as String)
  ..timeField = json['timeField'] as String?
  ..dichotomusField = (json['dichotomusField'] as num?)?.toDouble()
  ..currentLanguage = json['currentLanguage'] == null
      ? null
      : GlobalLanguageModel.fromJson(json['currentLanguage'] as Map);

Map<String, dynamic> _$StudyNotifierToJson(StudyNotifier instance) =>
    <String, dynamic>{
      'studyCurrentVersion': instance.studyCurrentVersion,
      'availableStudies':
          instance.availableStudies.map((e) => e.toJson()).toList(),
      'studyFormModel': instance.studyFormModel?.toJson(),
      'visitToFormMapping':
          instance.visitToFormMapping.map((e) => e.toJson()).toList(),
      'formOnDate': instance.formOnDate.map((e) => e.toJson()).toList(),
      'studyFormReqModel': instance.studyFormReqModel?.toJson(),
      'consentFormPDf': instance.consentFormPDf,
      'dateField': instance.dateField?.toIso8601String(),
      'timeField': instance.timeField,
      'dichotomusField': instance.dichotomusField,
      'currentLanguage': instance.currentLanguage?.toJson(),
    };
