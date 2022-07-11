import 'dart:convert';

import 'package:another_xlider/another_xlider.dart';
import 'package:clini_app/controllers/controllers.dart';
import 'package:clini_app/data/data.dart';
import 'package:clini_app/themes/app_text.dart';
import 'package:clini_app/ui/common/common.dart';
import 'package:clini_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class StudyFormBuilder extends StatefulWidget {
  final FormItemGroupModel data;
  final VoidCallback? onNextTap;
  final VoidCallback? onPrevTap;
  final int visitId;
  final int formId;
  final String ctaLabel;
  final bool isLastPage;
  final int? indexPage;
  final FormItemGroupReqModel? initialData;

  const StudyFormBuilder({
    required this.data,
    required this.visitId,
    required this.formId,
    this.onNextTap,
    this.onPrevTap,
    this.ctaLabel = 'Next',
    this.isLastPage = false,
    required this.indexPage,
    this.initialData,
  });

  @override
  _StudyFormBuilderState createState() => _StudyFormBuilderState();
}

class _StudyFormBuilderState extends State<StudyFormBuilder>
    with AutomaticKeepAliveClientMixin<StudyFormBuilder> {
  final _formKey = GlobalKey<FormBuilderState>();
  late StudyNotifier _notifier;

  @override
  void initState() {
    super.initState();
    _notifier = context.read<StudyNotifier>();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      setState(() {
        
      });
    });
    
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: ()=> FocusScope.of(context).requestFocus(FocusNode()),
      child: FormBuilder(
        key: _formKey,
        child: Column(
          children: [
            if (widget.data.variables?.isNotEmpty ?? false) ...{
              for (var i = 0;
                  i <= (widget.data.variables?.length ?? 1) - 1;
                  i++) ...{
                _getWidget(
                  widget.data.variables![i],
                  oldValue: (i == 0) ? null : widget.data.variables![i - 1],
                  variable: widget.initialData?.variables.tryFirstWhere(
                    (element) =>
                        element.variableId ==
                        widget.data.variables![i].variableId,
                  ),
                )
              },
            },
            sizedBoxWithHeight(32),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                  visible: widget.indexPage != 0,
                  child: Expanded(
                    child: AppButton(
                      onClick: _handlePrevCta,
                      label: 'Previous',
                    ),
                  ),
                ),
                sizedBoxWithWidth(16),
                Expanded(
                  child: AppButton(
                    onClick: _handleNextCta,
                    label: widget.ctaLabel,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _getWidget(
    FormItemGroupVariableModel e, {
    VariableReqModel? variable,
    FormItemGroupVariableModel? oldValue,
  }) {
    Logger.logMsg(this, e.variableDataType);
    Logger.logMsg(this, variable?.variableValue.toString());
    Logger.logMsg(this, 'Rule Id ' + e.ruleId.toString());

    if ((e.ruleId == '394' || e.ruleId == '395' || e.ruleId == '396')) {
      final codeList = _notifier.getCodeList(oldValue!.codeListId!);

      var prevItem = _formKey
          .currentState?.fields[(oldValue.variableId.toString())]?.value;

      prevItem ??= codeList.tryFirst.toString();

      if (prevItem.toString().toUpperCase() ==
          codeList.tryFirst.toString().toUpperCase()) {
        return const SizedBox();
      }
    }

    switch (e.variableDataType) {
      case 'number':
        return AppTextFormField(
          label: _notifier.getFormLabelName(e.itemGroupVariableLabel),
          name: e.variableId?.toString() ?? 'NA',
          autofocus: false,
          initialValue: variable?.variableValue,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(context),
          ]),
          keyboardType: TextInputType.number,
        );
      case 'string':
      case 'text':
        return AppTextFormField(
          autofocus: false,
          label: _notifier.getFormLabelName(e.itemGroupVariableLabel),
          name: e.variableId?.toString() ?? 'NA',
          initialValue: variable?.variableValue,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(context),
          ]),
        );
      case 'date':
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _notifier.getFormLabelName(e.itemGroupVariableLabel),
                style: AppText.text18w400Black,
              ),
              sizedBoxWithHeight(8),
              FormBuilderDateTimePicker(
                name: e.variableId?.toString() ?? 'NA',
                inputType: InputType.date,
                initialValue: parseDateFromCustomString(
                  variable?.variableValue,
                  'yyyy-MM-dd',
                ),
                initialDate: parseDateFromCustomString(
                  variable?.variableValue,
                  'yyyy-MM-dd',
                ),
                format: DateFormat('dd/MM/yyyy'),
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0.r),
                    borderSide:
                        BorderSide(color: AppColors.blueDark, width: 1.r),
                  ),
                  errorStyle:
                      AppText.text12w400Grey.copyWith(color: Colors.red),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0.r),
                    borderSide:
                        BorderSide(color: AppColors.blueDark, width: 1.r),
                  ),
                  suffixIcon: const Icon(Icons.calendar_today),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context),
                ]),
              ),
            ],
          ),
        );
      case 'time':
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _notifier.getFormLabelName(e.itemGroupVariableLabel),
                style: AppText.text18w400Black,
              ),
              sizedBoxWithHeight(8),
              FormBuilderDateTimePicker(
                name: e.variableId?.toString() ?? 'NA',
                inputType: InputType.time,
                firstDate: DateTime.now(),
                format: DateFormat('hh:mm a'),
                initialTime: TimeOfDay.fromDateTime(
                  parseDateFromCustomString(
                        variable?.variableValue,
                        'yyyy-MM-dd hh:mm',
                      ) ??
                      DateTime.now(),
                ),
                initialValue: parseDateFromCustomString(
                  variable?.variableValue,
                  'yyyy-MM-dd hh:mm',
                ),
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0.r),
                    borderSide:
                        BorderSide(color: AppColors.blueDark, width: 1.r),
                  ),
                  errorStyle:
                      AppText.text12w400Grey.copyWith(color: Colors.red),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0.r),
                    borderSide:
                        BorderSide(color: AppColors.blueDark, width: 1.r),
                  ),
                  suffixIcon: const Icon(Icons.calendar_today),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context),
                ]),
              ),
            ],
          ),
        );

      case 'ordinal':
        final codeList = _notifier.getCodeList(e.codeListId!);
        final initialVal = parseList(variable?.variableValue);

        final codedIntialValue =
            initialVal.map((e) => CodedValue.fromJson(e as Map)).toList();

        final initialCodedList = <CodedValue>[];

        for (var item in codeList) {
          if (codedIntialValue.contains(item)) {
            initialCodedList.add(item);
          }
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sizedBoxWithHeight(8),
              Text(
                _notifier.getFormLabelName(e.itemGroupVariableLabel),
                style: AppText.text18w400Black,
              ),
              sizedBoxWithHeight(8),
              FormBuilderChipsInput<CodedValue>(
                findSuggestions: (query) => codeList
                    .where((e) =>
                        (_notifier.getNameFromCodedValue(e).toLowerCase())
                            .contains(query.toLowerCase()))
                    .toList(),
                name: e.variableId?.toString() ?? 'NA',
                initialValue: initialCodedList,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0.r),
                    borderSide:
                        BorderSide(color: AppColors.blueDark, width: 1.r),
                  ),
                  errorStyle:
                      AppText.text12w400Grey.copyWith(color: Colors.red),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0.r),
                    borderSide:
                        BorderSide(color: AppColors.blueDark, width: 1.r),
                  ),
                ),
                chipBuilder: (context, state, profile) {
                  return InputChip(
                    key: ObjectKey(profile),
                    label: Text(_notifier.getNameFromCodedValue(profile)),
                    onDeleted: () => state.deleteChip(profile),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  );
                },
                suggestionBuilder: (context, state, profile) {
                  return ListTile(
                    title: Text(_notifier.getNameFromCodedValue(profile)),
                    onTap: () => state.selectSuggestion(profile),
                  );
                },
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context),
                ]),
              )
            ],
          ),
        );
      case 'longtext':
      case 'image':
      case 'barcode':
        return Container();
      case 'descriptivetext':
        return Html(
          style: {
            'p': Style(fontSize: FontSize(16.sp)),
          },
          data:
              '''<p>${_notifier.getFormLabelName(e.itemGroupVariableLabel)}</p>''',
        );
      case 'dichotomus':
        var initialValue = parseDouble(variable?.variableValue);
        _notifier.dichotomusField = initialValue ?? 0;
        return Consumer<StudyNotifier>(
          builder: (context, notifier, _) {
            return Padding(
              padding: EdgeInsets.all(8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _notifier.getFormLabelName(e.itemGroupVariableLabel),
                    style: AppText.text18w400Black,
                  ),
                  e.variableItemId == 'SCALE'
                      ? Center(
                          child: SizedBox(
                            height: 320.h,
                            width: 80.w,
                            child: FormBuilder(
                                child: FlutterSlider(
                              values: [notifier.dichotomusField ?? 0],
                              rtl: true,
                              axis: Axis.vertical,
                              max: 100.h,
                              min: 0,
                              hatchMark: FlutterSliderHatchMark(
                                labelsDistanceFromTrackBar: 30.w,
                                labelBox: FlutterSliderSizedBox(
                                    height: 20.h, width: 30),
                                linesAlignment:
                                    FlutterSliderHatchMarkAlignment.left,
                                displayLines: true,
                                density:
                                    0.2, // means 50 lines, from 0 to 100 percent
                                labels: List.generate(
                                  21,
                                  (index) => FlutterSliderHatchMarkLabel(
                                      percent: index * 5,
                                      label: Text(
                                        '${index * 5} ',
                                        style: AppText.text14w400Black,
                                      )),
                                ).toList(),
                              ),
                              onDragCompleted: (_, __, ___) {
                                notifier.savesliderValue(
                                    double.tryParse(__.toString()));
                              },
                            )),
                          ),
                        )
                      : Column(
                          children: [
                            FormBuilderSlider(
                              name: e.variableId.toString(),

                              initialValue:
                                  parseDouble(variable?.variableValue) ?? 0,
                              min: 0,

                              max: 100,
                              autofocus: false,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                              ]),
                              displayValues: DisplayValues.current,

                              // displayValues: DisplayValues.current,
                              label: _notifier
                                  .getFormLabelName(e.itemGroupVariableLabel),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: _notifier
                                  .getCodeList(e.codeListId!)
                                  .map((e) => Text(
                                        _notifier.getNameFromCodedValue(e),
                                        style: AppText.text14w400Black,
                                      ))
                                  .toList(),
                            )
                          ],
                        ),
                ],
              ),
            );
          },
        );
      case 'singleselect':
        if (e.codeListId == null) {
          return const SizedBox();
        }

        final codeList = _notifier.getCodeList(e.codeListId!);
        final initialCodedValue = codeList.tryFirstWhere((element) =>
            _notifier.getNameFromCodedValue(element) ==
            variable?.variableValue);

        return AppDropDownFormField(
          label: _notifier.getFormLabelName(e.itemGroupVariableLabel),
          name: e.variableId?.toString() ?? 'NA',
          initalValue: initialCodedValue ?? codeList.tryFirst,
          dropdownList: codeList
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(_notifier.getNameFromCodedValue(e)),
                  ))
              .toList(),
          onChanged: (_) {
            setState(() {});
          },
        );
      case 'radiobutton':
        if (e.codeListId == null) {
          return const SizedBox();
        }

        return AppRadioFormField(
          label: _notifier.getFormLabelName(e.itemGroupVariableLabel),
          name: e.variableId?.toString() ?? 'NA',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(context),
          ]),
          initalValue: variable?.variableValue,
          options: _notifier
              .getCodeList(e.codeListId!)
              .map((e) => FormBuilderFieldOption(
                    value: _notifier.getNameFromCodedValue(e),
                  ))
              .toList(),
        );
      default:
        return const SizedBox();
    }
  }

  void _handleNextCta() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      _notifier.studyFormReqModel ??= StudyFormReqModel(visits: []);

      _notifier.studyFormReqModel?.studyId = _notifier.studyFormModel!.studyId!;

      var visitIndex = _notifier.studyFormReqModel?.visits
              ?.indexOf(VisitReqModel(visitsId: widget.visitId, forms: [])) ??
          -1;

      if (visitIndex == -1) {
        _notifier.studyFormReqModel?.visits
            ?.add(VisitReqModel(visitsId: widget.visitId, forms: []));
        visitIndex = _notifier.studyFormReqModel?.visits
                ?.indexOf(VisitReqModel(visitsId: widget.visitId, forms: [])) ??
            0;
      }

      final formList =
          _notifier.studyFormReqModel?.visits?.tryElementAt(visitIndex)?.forms;

      var formIndex = formList?.indexOf(
            FormReqModel(
              formId: widget.formId,
              itemGroups: [],
            ),
          ) ??
          -1;

      if (formIndex == -1) {
        formList?.add(
          FormReqModel(
            formId: widget.formId,
            itemGroups: [],
          ),
        );
        formIndex = formList?.indexOf(
              FormReqModel(
                formId: widget.formId,
                itemGroups: [],
              ),
            ) ??
            0;
      }
      final formGroupList = formList?.tryElementAt(formIndex)?.itemGroups;

      var formItemGroupIndex = formGroupList?.indexOf(
            FormItemGroupReqModel(
              itemGroupId: widget.data.itemGroupId ?? 0,
              variables: [],
            ),
          ) ??
          -1;

      if (formItemGroupIndex == -1) {
        formGroupList?.add(
          FormItemGroupReqModel(
            itemGroupId: widget.data.itemGroupId ?? 0,
            variables: [],
          ),
        );
        formItemGroupIndex = formGroupList?.indexOf(
              FormItemGroupReqModel(
                itemGroupId: widget.data.itemGroupId ?? 0,
                variables: [],
              ),
            ) ??
            0;
      }
      formGroupList?.tryElementAt(formItemGroupIndex)?.variables.clear();
      widget.data.variables?.forEach(
        (element) {
          switch (element.variableDataType) {
            // TODO: handle multi select
            case 'ordinal':
              formGroupList?.tryElementAt(formItemGroupIndex)?.variables.add(
                    VariableReqModel(
                      variableId: element.variableId!,
                      variableValue: jsonEncode(
                        _formKey
                            .currentState
                            ?.fields[(element.variableId?.toString() ?? 'NA')]
                            ?.value,
                      ),
                      date: DateTime.now(),
                      type: element.variableDataType.toString(),
                    ),
                  );
              break;
            case 'number':
            case 'string':
            case 'text':
            case 'singleselect':
            case 'radiobutton':
            case 'date':
            case 'time':
              formGroupList?.tryElementAt(formItemGroupIndex)?.variables.add(
                    VariableReqModel(
                      variableId: element.variableId!,
                      variableValue: _formKey
                              .currentState
                              ?.fields[(element.variableId?.toString() ?? 'NA')]
                              ?.value
                              .toString() ??
                          'NA',
                      date: DateTime.now(),
                      type: element.variableDataType.toString(),
                    ),
                  );
              break;
            case 'dichotomus':
              if (element.variableItemId == 'SCALE') {
                formGroupList?.tryElementAt(formItemGroupIndex)?.variables.add(
                      VariableReqModel(
                        variableId: element.variableId!,
                        variableValue: _notifier.dichotomusField.toString(),
                        date: DateTime.now(),
                        type: element.variableDataType.toString(),
                      ),
                    );
              } else {
                formGroupList?.tryElementAt(formItemGroupIndex)?.variables.add(
                      VariableReqModel(
                        variableId: element.variableId!,
                        variableValue: _formKey
                                .currentState
                                ?.fields[
                                    (element.variableId?.toString() ?? 'NA')]
                                ?.value
                                .toString() ??
                            'NA',
                        date: DateTime.now(),
                        type: element.variableDataType.toString(),
                      ),
                    );
              }
              break;
            default:
          }
        },
      );
      _notifier.getEventDataBasedOnDate(forceUpdate: true);
      _notifier.notifyListeners();
      Logger.logMsg(this, _notifier.studyFormReqModel?.toJson());
      widget.onNextTap?.call();
    } else {
      // context.showErrorSnackBar('You missed some field in form');
      Logger.logMsg(this, 'help');
    }
  }

  void _handlePrevCta() {
    widget.onPrevTap?.call();
  }

  @override
  bool get wantKeepAlive => true;
}
