import 'package:clini_app/utils/utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'visit_form_model.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class VisitFormModel {
  @JsonKey(name: 'visit_id', fromJson: parseInt)
  int? visitId;

  @JsonKey(name: 'form_id', fromJson: parseInt)
  int? formId;

  @JsonKey(name: 'form_order')
  String? formOrder;

  @JsonKey(name: 'visit_type_id', fromJson: parseInt)
  int? visitTypeId;

  VisitFormModel({
    this.visitId,
    this.formId,
    this.formOrder,
    this.visitTypeId,
  });

  factory VisitFormModel.fromJson(Map json) => _$VisitFormModelFromJson(json);

  Map<String, dynamic> toJson() => _$VisitFormModelToJson(this);
}
