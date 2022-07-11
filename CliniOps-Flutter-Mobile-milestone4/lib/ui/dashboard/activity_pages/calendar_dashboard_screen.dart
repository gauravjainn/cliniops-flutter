import 'package:clini_app/controllers/controllers.dart';
import 'package:clini_app/data/data.dart';
import 'package:clini_app/routes/routes.dart';
import 'package:clini_app/themes/app_text.dart';
import 'package:clini_app/ui/common/common.dart';
import 'package:clini_app/ui/dashboard/dashboard.dart';
import 'package:clini_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/calendar_tile.dart';
import 'package:provider/provider.dart';

class CalendarDashboardScreen extends StatefulWidget {
  const CalendarDashboardScreen();

  @override
  State<CalendarDashboardScreen> createState() =>
      _CalendarDashboardScreenState();
}

class _CalendarDashboardScreenState extends State<CalendarDashboardScreen> {
  final _focusDate = ValueNotifier(DateTime.now().onlyDate);
  late StudyNotifier _notifier;

  @override
  void initState() {
    super.initState();
    _notifier = context.read<StudyNotifier>();

    WidgetsBinding.instance!.addPostFrameCallback(
      (_) => _notifier.getDataBasedOnDate(DateTime.now()),
    );
  }

  @override
  Widget build(BuildContext context) {
    var calendarWidget = ValueListenableBuilder(
      valueListenable: _focusDate,
      builder: (_, DateTime val, __) {
        return Consumer<StudyNotifier>(
          builder: (_, __, ___) {
            return Calendar(
              // locale: 'en_US',
              isExpanded: true,

              weekDays: const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],

              selectedColor:
                  _notifier.getEventDataBasedOnDate().containsKey(val.onlyDate)
                      ? Colors.blue
                      : Colors.grey,

              todayColor: Colors.red,

              startOnMonday: true,
              hideBottomBar: true,

              dayOfWeekStyle: AppText.text14w400Black
                  .copyWith(color: AppColors.bluePrimary),
              events: _notifier.getEventDataBasedOnDate(),
              eventColor: Colors.blue,
              dayBuilder: (_, date) {
                final valPercentage =
                    (_notifier.eventDataWithProgress[date]?.referenceMin ?? 0) /
                        (_notifier.eventDataWithProgress[date]?.referenceMax ??
                            1);

                return CalendarTile(
                  date: date,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (_notifier
                          .getEventDataBasedOnDate()
                          .containsKey(date)) ...{
                        CircularProgressIndicator(
                          value: valPercentage,
                          color:
                              valPercentage >= 1 ? Colors.green : Colors.grey,
                          strokeWidth: 2.r,
                          backgroundColor: Colors.grey.shade300,
                        ),
                      },
                      if (date == val) ...{
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          margin: EdgeInsets.all(4.r),
                        ),
                      },
                      Text(
                        date.day.toString(),
                        style: AppText.text14w400Black.copyWith(
                          color: date == val
                              ? AppColors.white
                              : AppColors.textBlack,
                        ),
                      ),
                    ],
                  ),
                );
              },
              eventListBuilder: (_, __) => const SizedBox(),
              hideTodayIcon: true,

              onDateSelected: (DateTime next) {
                _focusDate.value = next;
                if (next.isBefore(DateTime.now().onlyDate) ||
                    next.isSameDate(DateTime.now())) {
                  _notifier.getDataBasedOnDate(next);
                }
              },
            );
          },
        );
      },
    );
    var calendarListWidget = Consumer<StudyNotifier>(
      builder: (_, model, __) {
        if (model.visitToFormMapping.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          // shrinkWrap: true,

          itemCount: model.formOnDate.length,
          itemBuilder: (context, index) {
            final visitId = int.tryParse(
                  model
                          .getEventDataBasedOnDate()[_focusDate.value]
                          ?.tryElementAt(index)
                          ?.summary ??
                      '',
                ) ??
                0;
            final formId = model.formOnDate[index].formId!;
            return ActivityListViewItem(
              title: model.getFormLabelName(
                model.formOnDate[index].formNameLabels,
              ),
              subtitle: model.getFormTimeStamp(
                        visitId,
                        formId,
                        defaultDate: _focusDate.value,
                      ) ==
                      null
                  ? 'NA'
                  : model
                      .getFormTimeStamp(
                        visitId,
                        formId,
                        defaultDate: _focusDate.value,
                      )!
                      .formatDate('MMM,dd yyyy, h:mm a'),
              image: model.getIsFormCompleted(visitId, formId,
                      isConsentPDf: model.formOnDate[index].formNameLabels
                              ?.tryFirst?.getLabel
                              .contains('Consent') ??
                          false)
                  ? Images.successIcon
                  : Images.uncheckGreyIconPath,
              onPressed: () {
                if (model.isMinMaxNotValid(visitId)) {
                  return;
                }
                if (model.formOnDate[index].formNameLabels!.first.name!
                    .contains('Consent')) {
                  if (_notifier.consentFormPDf != null &&
                      _notifier.consentFormPDf!.isNotEmpty) {
                    AppEnvironment.navigator
                        .pushNamed(ConsentRoutes.consentPreviewScreen);
                    return;
                  }
                  var args = ConsentScreenArgs(
                    studyName: model.studyFormModel?.title ?? 'NA',
                    pdfUrl:
                        '${AppEnvironment.apiUrl}${model.studyFormModel?.studyConfiguration?.informedConsent?.first.file_location.toString()}',
                    title: model
                        .formOnDate[index].formNameLabels!.tryFirst!.name!
                        .replaceAll('Form', 'Visit')
                        .toString(),
                    model: model.studyFormModel?.studyConfiguration
                        ?.informedConsent?.first,
                    videoUrl: model
                        .studyFormModel?.studyConfiguration?.studyParams
                        ?.firstWhere(
                            (element) => element.paramKey == 'icfVideoUrl')
                        .paramValue
                        .toString(),
                  );
                  AppEnvironment.navigator.pushNamed(
                    ConsentRoutes.consentScreen,
                    arguments: args,
                  );
                  return;
                }

                AppEnvironment.navigator.pushNamed(
                  StudyRoutes.studyScreen,
                  arguments: StudyScreenArgs(
                    studyFormModel: model.formOnDate[index],
                    visitId: visitId,
                  ),
                );
              },
            );
          },
        );
      },
    );

    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.landscape) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 1,
                child: ListView(
                  children: [
                    calendarWidget,
                  ],
                ),
              ),
              Expanded(flex: 1, child: calendarListWidget),
            ],
          );
        }
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(flex: 3, child: calendarWidget),
            Expanded(flex: 2, child: calendarListWidget),
          ],
        );
      },
    );
  }
}
