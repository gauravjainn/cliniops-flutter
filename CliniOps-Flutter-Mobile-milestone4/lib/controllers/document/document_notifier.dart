import 'package:clini_app/data/data.dart';
import 'package:clini_app/repositories/study_repo.dart';
import 'package:clini_app/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'document_notifier.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class DocumentNotifier with ChangeNotifier, CliniMixin<DocumentNotifier> {
  @JsonKey(ignore: true)
  late StudyRepo studyRepo;
  @JsonKey(defaultValue: [])
  List<Document> documetList = [];

  DocumentNotifier();
  static Future<DocumentNotifier> initialize(
    StudyRepo repo,
  ) async {
    try {
      final instance = await DocumentNotifier().init();
      instance.studyRepo = repo;
      return instance;
    } catch (e) {
      final instance = DocumentNotifier();
      instance.studyRepo = repo;
      return instance;
    }
  }

  Future<Responser<List<Document>>> getDocumentList({
    required int studyId,
  }) async {
    // already data is available in storage
    if (documetList.isNotEmpty) {
      return Responser(message: '', isSuccess: true, data: documetList);
    }
    final resp = await studyRepo.getDocumentList(studyId);
    if (resp.isSuccess) {
      documetList = resp.data ?? [];
    }

    return resp;
  }

  @override
  DocumentNotifier fromJson(Map json) => _$DocumentNotifierFromJson(json);

  @override
  Map<String, dynamic> toJson(DocumentNotifier notifier) =>
      _$DocumentNotifierToJson(notifier);
}
