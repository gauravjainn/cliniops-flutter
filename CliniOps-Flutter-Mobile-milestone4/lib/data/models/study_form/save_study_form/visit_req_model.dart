import 'package:clini_app/data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'visit_req_model.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class VisitReqModel {
  @JsonKey(name: 'visits_id')
  int visitsId;
  List<FormReqModel> forms;

  VisitReqModel({
    required this.visitsId,
    required this.forms,
  });

  factory VisitReqModel.fromJson(Map json) => _$VisitReqModelFromJson(json);

  Map<String, dynamic> toJson() => _$VisitReqModelToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VisitReqModel && other.visitsId == visitsId;
  }

  @override
  int get hashCode => visitsId.hashCode ^ forms.hashCode;
}
