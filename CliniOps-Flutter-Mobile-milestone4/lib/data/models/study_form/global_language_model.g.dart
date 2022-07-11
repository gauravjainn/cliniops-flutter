// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_language_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GlobalLanguageModel _$GlobalLanguageModelFromJson(Map json) =>
    GlobalLanguageModel(
      languageId: parseInt(json['lang_id']),
      languagename: json['languagename'] as String?,
      locale: json['locale'] as String?,
    );

Map<String, dynamic> _$GlobalLanguageModelToJson(
        GlobalLanguageModel instance) =>
    <String, dynamic>{
      'lang_id': instance.languageId,
      'languagename': instance.languagename,
      'locale': instance.locale,
    };
