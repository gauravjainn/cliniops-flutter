// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_notifier.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentNotifier _$DocumentNotifierFromJson(Map json) => DocumentNotifier()
  ..documetList = (json['documetList'] as List<dynamic>?)
          ?.map((e) => Document.fromJson(e as Map))
          .toList() ??
      [];

Map<String, dynamic> _$DocumentNotifierToJson(DocumentNotifier instance) =>
    <String, dynamic>{
      'documetList': instance.documetList.map((e) => e.toJson()).toList(),
    };
