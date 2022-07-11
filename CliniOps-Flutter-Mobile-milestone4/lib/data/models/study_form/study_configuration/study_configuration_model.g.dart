// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_configuration_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudyConfigurationModel _$StudyConfigurationModelFromJson(Map json) =>
    StudyConfigurationModel(
      forms: (json['forms'] as List<dynamic>?)
          ?.map((e) => StudyConfigurationFormModel.fromJson(e as Map))
          .toList(),
      visitForm: (json['visitForm'] as List<dynamic>?)
          ?.map((e) => VisitFormModel.fromJson(e as Map))
          .toList(),
      visits: (json['visits'] as List<dynamic>?)
          ?.map((e) => VisitModel.fromJson(e as Map))
          .toList(),
      codeList: (json['codeList'] as Map?)?.map(
        (k, e) => MapEntry(
            int.parse(k as String),
            (e as Map).map(
              (k, e) => MapEntry(
                  int.parse(k as String), CodedValue.fromJson(e as Map)),
            )),
      ),
      languages: (json['languages'] as List<dynamic>?)
          ?.map((e) => GlobalLanguageModel.fromJson(e as Map))
          .toList(),
      studyParams: (json['studyparams'] as List<dynamic>?)
          ?.map((e) => StudyParamModel.fromJson(e as Map))
          .toList(),
      informedConsent: (json['informedConsent'] as List<dynamic>?)
          ?.map((e) => InformedConsentModel.fromJson(e as Map))
          .toList(),
    );

Map<String, dynamic> _$StudyConfigurationModelToJson(
        StudyConfigurationModel instance) =>
    <String, dynamic>{
      'forms': instance.forms?.map((e) => e.toJson()).toList(),
      'visitForm': instance.visitForm?.map((e) => e.toJson()).toList(),
      'visits': instance.visits?.map((e) => e.toJson()).toList(),
      'codeList': instance.codeList?.map((k, e) => MapEntry(
          k.toString(), e.map((k, e) => MapEntry(k.toString(), e.toJson())))),
      'languages': instance.languages?.map((e) => e.toJson()).toList(),
      'studyparams': instance.studyParams?.map((e) => e.toJson()).toList(),
      'informedConsent':
          instance.informedConsent?.map((e) => e.toJson()).toList(),
    };
