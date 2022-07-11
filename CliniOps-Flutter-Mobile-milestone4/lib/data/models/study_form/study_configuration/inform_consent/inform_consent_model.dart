import 'package:clini_app/data/models/study_form/study_configuration/annotations/annotations_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'inform_consent_model.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class InformedConsentModel {
  String? doc_title_id;
  String? doc_studyphase_id;
  String? doc_type;
  String? id;
  String? orig_filename;
  String? entity_id;
  String? status;
  String? version;
  String? languageId;
  String? file_location;
  String? displayVersion;
  Map<int, List<Annotations>>? annotations;

  InformedConsentModel({
    this.doc_title_id,
    this.doc_studyphase_id,
    this.doc_type,
    this.id,
    this.orig_filename,
    this.entity_id,
    this.status,
    this.version,
    this.languageId,
    this.file_location,
    this.displayVersion,
    this.annotations,
  });

  factory InformedConsentModel.fromJson(Map json) =>
      _$InformedConsentModelFromJson(json);

  Map<String, dynamic> toJson() => _$InformedConsentModelToJson(this);
}
