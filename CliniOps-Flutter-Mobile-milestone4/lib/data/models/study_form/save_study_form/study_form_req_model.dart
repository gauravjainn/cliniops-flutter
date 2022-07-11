import 'package:json_annotation/json_annotation.dart';

import 'package:clini_app/data/data.dart';

part 'study_form_req_model.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class StudyFormReqModel {
  int? studyId;
  List<VisitReqModel>? visits;

  StudyFormReqModel({
    this.studyId,
    this.visits,
  });

  factory StudyFormReqModel.fromJson(Map json) =>
      _$StudyFormReqModelFromJson(json);

  Map<String, dynamic> toJson() => _$StudyFormReqModelToJson(this);
}
