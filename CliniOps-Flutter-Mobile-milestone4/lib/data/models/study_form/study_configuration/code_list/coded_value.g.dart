// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coded_value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CodedValue _$CodedValueFromJson(Map json) => CodedValue(
      codedValue: parseInt(json['codedValue']),
      lang: (json['lang'] as Map).map(
        (k, e) => MapEntry(int.parse(k as String), e as String),
      ),
    );

Map<String, dynamic> _$CodedValueToJson(CodedValue instance) =>
    <String, dynamic>{
      'codedValue': instance.codedValue,
      'lang': instance.lang.map((k, e) => MapEntry(k.toString(), e)),
    };
