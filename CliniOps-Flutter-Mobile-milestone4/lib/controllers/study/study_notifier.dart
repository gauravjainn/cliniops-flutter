import 'package:clini_app/data/data.dart';
import 'package:clini_app/data/models/open_video.dart';
import 'package:clini_app/repositories/repositories.dart';
import 'package:clini_app/ui/chat/call_widget.dart';
import 'package:clini_app/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'package:json_annotation/json_annotation.dart';

part 'study_notifier.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class StudyNotifier with ChangeNotifier, CliniMixin<StudyNotifier> {
  @JsonKey(ignore: true)
  late StudyRepo studyRepo;

  String? studyCurrentVersion;
  //
  @JsonKey(defaultValue: [])
  List<StudyModel> availableStudies = [];

  StudyFormModel? studyFormModel;
  // customized class for storing the data(visit id,date, forms) from getStudyFormConfigration API in visits> formvistis>forms
  @JsonKey(defaultValue: [])
  List<VisitToFormModel> visitToFormMapping = [];

  @JsonKey(defaultValue: [])
  List<StudyConfigurationFormModel> formOnDate = [];

  @JsonKey(ignore: true)
  final eventData = <DateTime, List<CleanCalendarEvent>>{};

  @JsonKey(ignore: true)
  final eventDataWithProgress = <DateTime, EventProgressModel>{};

  StudyFormReqModel? studyFormReqModel;
  String? consentFormPDf;
  DateTime? dateField = DateTime.now();
  String? timeField = '';
  double? dichotomusField = 0.0;

  GlobalLanguageModel? currentLanguage;

  StudyNotifier();

  static Future<StudyNotifier> initialize(
    StudyRepo repo,
  ) async {
    try {
      final instance = await StudyNotifier().init();
      instance.studyRepo = repo;
      return instance;
    } catch (e) {
      final instance = StudyNotifier();
      instance.studyRepo = repo;
      return instance;
    }
  }

  void saveDate(DateTime dateTime) async {
    dateField = dateTime;
    notifyListeners();
  }

  void saveTime(String dateTime) async {
    timeField = dateTime;
    notifyListeners();
  }

  void savesliderValue(double? _val) async {
    dichotomusField = _val;
    Logger.logMsg(this, dichotomusField);
    notifyListeners();
  }

  Future<Responser> getStudiesList() async {
    final resp = await studyRepo.getStudiesList();
    if (resp.isSuccess) {
      availableStudies = resp.data ?? [];
      notifyListeners();
    }
    return resp;
  }

  Future<Responser> getStudyVersion({required String studyId}) async {
    final resp = await studyRepo.getStudyVersion(studyId: studyId);
    // TODO: call get studies if version changed
    if (resp.isSuccess) {
      studyCurrentVersion = resp.data;
      notifyListeners();
    }
    return resp;
  }

  // get study form data
  Future<Responser<StudyFormModel>> getStudyFormsConfiguration({
    required int studyId,
  }) async {
    // already data is available in storage
    if (studyFormModel != null) {
      return Responser(message: '', isSuccess: true, data: studyFormModel);
    }

    final resp = await studyRepo.getStudyFormsConfiguration(studyId: studyId);
    if (resp.isSuccess) {
      formOnDate.clear();
      visitToFormMapping.clear();
      eventData.clear();
      eventDataWithProgress.clear();

      currentLanguage = resp.data?.studyConfiguration?.languages?.tryFirst;
      currentLanguage ??= GlobalLanguageModel(
        locale: 'en',
        languageId: 1,
        languagename: 'English',
      );

      studyFormModel = resp.data ?? StudyFormModel();
      final a = <VisitModel, List<int>>{};
      // Parsing the data according to form data according to visitId and formId
      for (var item
          in studyFormModel?.studyConfiguration?.visits ?? <VisitModel>[]) {
        final x = studyFormModel?.studyConfiguration?.visitForm
                ?.map((element) {
                  if (element.visitId == item.visitsId) {
                    return element.formId;
                  }
                })
                .whereNotNull()
                .toList() ??
            [];
        a[item] = [...x];
      }

      for (var item in a.entries) {
        final toFormModel = VisitToFormModel();
        toFormModel.visitId = item.key.visitsId;
        toFormModel.visitDate = item.key.visitDate;
        toFormModel.referenceMax = item.key.referenceMax;
        toFormModel.referenceMin = item.key.referenceMin;

        for (var id in item.value) {
          final form = studyFormModel?.studyConfiguration?.forms
              ?.firstWhere((form) => form.formId == id);
          if (form != null) {
            if (toFormModel.forms?.isEmpty ?? true) {
              toFormModel.forms = [];
            }
            toFormModel.forms!.add(form);
          }
        }
        visitToFormMapping.add(toFormModel);
      }
      // change the date for consent form to tomorrow at, so that it will appear on top

      // sort according to dates
      visitToFormMapping.sort((a, b) => a.visitDate!.compareTo(b.visitDate!));
      // Logger.logMsg(this, visitToFormMapping.toString());

      notifyListeners();
    }
    return resp;
  }

  List<CodedValue> getCodeList(int codeId) {
    return studyFormModel?.studyConfiguration?.codeList?[codeId]?.values
            .toList() ??
        [];
  }

  // get Forms based on date for calender widget usage
  List<StudyConfigurationFormModel> getDataBasedOnDate(DateTime day) {
    final list = visitToFormMapping.tryFirstWhere(
      (element) {
        return element.visitDate?.isSameDate(day) ?? false;
      },
    );
    formOnDate = list?.forms ?? [];
    notifyListeners();
    return formOnDate;
  }

  // return the list of event used in calender based on date
  Map<DateTime, List<CleanCalendarEvent>> getEventDataBasedOnDate({
    bool forceUpdate = false,
  }) {
    // if (!forceUpdate && eventData.isNotEmpty) {
    //   return eventData;
    // }
    final now = DateTime.now().onlyDate;
    for (var e in visitToFormMapping) {
      var date = e.visitDate?.onlyDate ?? now;
      var list = eventData[date] ?? [];
      list.add(
        CleanCalendarEvent(
          e.visitId.toString(),
          startTime: date,
          endTime: date,
        ),
      );

      var listOfForms = studyFormReqModel?.visits
          ?.tryFirstWhere((element) => element.visitsId == e.visitId)
          ?.forms;

      var completedFormCount = 0;

      listOfForms?.forEach((element) {
        completedFormCount =
            element.isCompleted ? completedFormCount + 1 : completedFormCount;
      });
      if ((e.forms?.first.formNameLabels?.first.getLabel.contains('Consent') ??
              false) &&
          (consentFormPDf != null && consentFormPDf!.isNotEmpty)) {
        eventDataWithProgress[date] = EventProgressModel(
          referenceMax: 1,
          referenceMin: 1,
        );
      } else {
        eventDataWithProgress[date] = EventProgressModel(
          referenceMax: e.forms?.length ?? 0,
          referenceMin: completedFormCount,
        );
      }
      eventData[date] = list;
    }
    return eventData;
  }

  Future<Responser> saveSubjectData({
    required StudyFormReqModel studyForm,
  }) async {
    final resp = await studyRepo.saveSubjectData(studyForm: studyForm);
    return resp;
  }

  // get progress of particular date
  EventProgressModel getEventProgressOnDay(DateTime date) {
    getEventDataBasedOnDate();
    return eventDataWithProgress[date] ??
        EventProgressModel(
          referenceMin: 0,
          referenceMax: 1,
        );
  }

  void clearData() {
    studyFormModel = null;
    consentFormPDf = null;
    studyRepo = StudyRepo();
    studyCurrentVersion = null;
    studyFormReqModel = null;
    availableStudies = [];
    visitToFormMapping = [];
    formOnDate = [];
    notifyListeners();
  }

  bool getIsFormCompleted(int visitId, int formId,
      {bool isConsentPDf = false}) {
    if (isConsentPDf) {
      if (consentFormPDf != null && consentFormPDf!.isNotEmpty) {
        return true;
      }
    }
    final formList = studyFormReqModel?.visits
        ?.tryFirstWhere((e) => e.visitsId == visitId)
        ?.forms;
    return formList?.tryFirstWhere((e) => e.formId == formId)?.isCompleted ??
        false;
  }

  DateTime? getFormTimeStamp(
    int visitId,
    int formId, {
    required DateTime defaultDate,
  }) {
    final formList = studyFormReqModel?.visits
        ?.tryFirstWhere((e) => e.visitsId == visitId)
        ?.forms;
    final form = formList?.tryFirstWhere((e) => e.formId == formId);
    if (form?.isCompleted ?? false) {
      return form?.itemGroups.tryLast?.variables.tryLast?.date ?? defaultDate;
    } else {
      return defaultDate;
    }
  }

  bool isMinMaxNotValid(int visitId) {
    final visit = visitToFormMapping
        .tryFirstWhere((element) => element.visitId == visitId);
      

    if (visit?.referenceMax == null || visit?.referenceMin == null) {
      return false;
    }

    final date = visit?.visitDate ?? DateTime.now().onlyDate;
    final date1 = date.add(Duration(days: visit?.referenceMax ?? 0));
    final date2 = date.subtract(Duration(days: visit?.referenceMin ?? 0));
    if (date2.isBefore(DateTime.now().onlyDate) &&
        date1.isAfter(
            DateTime.now().onlyDate)) {
      return false;
    }
    return true;
  }

  Future<Responser<OpenTokConfig>> getOpenTekConfig(
      {required String userId, required String entityId}) async {
    return await studyRepo.getOpenTekConfig(userId: userId, entityId: entityId);
  }

  List<GlobalLanguageModel> getLanguageList() {
    return (studyFormModel?.studyConfiguration?.languages ??
        [
          GlobalLanguageModel(
            locale: 'en',
            languageId: 1,
            languagename: 'English',
          )
        ]);
  }

  void setCurrentLanguage(GlobalLanguageModel language) {
    currentLanguage = language;
    notifyListeners();
  }

  int getCurrentLanguageIndex() {
    return getLanguageList().indexOf(currentLanguage ??
        GlobalLanguageModel(
          locale: 'en',
          languageId: 1,
          languagename: 'English',
        ));
  }

  String getFormLabelName(List<StudyLanguageModel>? langModel) {
    return (langModel?.isEmpty ?? true)
        ? 'NA'
        : langModel!.tryElementAt(getCurrentLanguageIndex())?.getLabel ??
            langModel.tryFirst?.getLabel ??
            'NA';
  }

  String getNameFromCodedValue(CodedValue codedValue) {
    if (codedValue.lang.isEmpty) {
      return 'NA';
    }
    if (!codedValue.lang.keys.contains(currentLanguage?.languageId)) {
      return 'NA';
    }
    return codedValue.lang.entries
        .firstWhere((element) => element.key == currentLanguage?.languageId,
            orElse: () => const MapEntry(1, 'NA'))
        .value;
  }

  @override
  StudyNotifier fromJson(Map json) => _$StudyNotifierFromJson(json);

  @override
  Map<String, dynamic> toJson(StudyNotifier notifier) =>
      _$StudyNotifierToJson(notifier);
}
