import 'package:clini_app/controllers/controllers.dart';
import 'package:clini_app/routes/routes.dart';
import 'package:clini_app/ui/dashboard/dashboard.dart';
import 'package:clini_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListDashboardScreen extends StatelessWidget {
  const ListDashboardScreen();

  @override
  Widget build(BuildContext context) {
    return Consumer<StudyNotifier>(
      builder: (_, model, __) {
        if (model.visitToFormMapping.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          reverse: true,
          shrinkWrap: true,
          itemCount: model.visitToFormMapping.length,
          itemBuilder: (context, index) {
            final form = model.visitToFormMapping[index];
            return DayBasedListItem(
              label: getStringOfDate(form.visitDate),
              list: form.forms
                      ?.map(
                        (e) => ItemsType(
                          label: model.getFormLabelName(e.formNameLabels),
                          subLabel: model
                                  .getFormLabelName(e.formNameLabels)
                                  .contains('Form')
                              ? null
                              : 'Modified : ${model.getFormTimeStamp(
                                    form.visitId!,
                                    e.formId!,
                                    defaultDate: form.visitDate!,
                                  )!.formatDate('MMM,dd yyyy, h:mm a')}',
                          data: e,
                          visitId: form.visitId!,
                          isCompleted: model.getIsFormCompleted(
                              form.visitId!, e.formId!,
                              isConsentPDf: e.formNameLabels!.tryFirst!.name!
                                  .contains('Form')),
                        ),
                      )
                      .toList() ??
                  [],
              onTap: (ItemsType value) {
                if (model.isMinMaxNotValid(value.visitId)) {
                  return;
                }

                var studyNo = context.read<StudyNotifier>();
                if (value.data.formNameLabels!.first.name!
                        .contains('Consent') &&
                    studyNo.consentFormPDf != null &&
                    studyNo.consentFormPDf!.isNotEmpty) {
                  AppEnvironment.navigator
                      .pushNamed(ConsentRoutes.consentPreviewScreen);
                  return;
                }
                if (value.data.formNameLabels!.first.name!
                    .contains('Consent')) {
                  var studyNo = context.read<StudyNotifier>();
                  if (studyNo.consentFormPDf != null &&
                      studyNo.consentFormPDf!.isNotEmpty) {
                    AppEnvironment.navigator
                        .pushNamed(ConsentRoutes.consentPreviewScreen);
                    return;
                  }
                  var args = ConsentScreenArgs(
                    studyName: model.studyFormModel?.title ?? 'NA',
                    pdfUrl:
                        '${AppEnvironment.apiUrl}${model.studyFormModel?.studyConfiguration?.informedConsent?.first.file_location.toString()}',
                    title: value.data.formNameLabels!.tryFirst!.name!
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
                  AppEnvironment.navigator
                      .pushNamed(ConsentRoutes.consentScreen, arguments: args);
                  return;
                }
                AppEnvironment.navigator.pushNamed(
                  StudyRoutes.studyScreen,
                  arguments: StudyScreenArgs(
                    studyFormModel: value.data,
                    visitId: value.visitId,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  String getStringOfDate(DateTime? dateToCheck) {
    if (dateToCheck == null) {
      return 'NA';
    }
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);

    final aDate =
        DateTime(dateToCheck.year, dateToCheck.month, dateToCheck.day);

    if (aDate == today) {
      return 'Today';
    } else if (aDate == yesterday) {
      return 'Yesterday';
    } else if (aDate == tomorrow) {
      return 'Tomorrow';
    } else {
      if (dateToCheck.year > DateTime.now().year) {
        return 'Consent Visit';
      }
      return (dateToCheck).formatDate('MMM, dd yyyy').toString();
    }
  }
}
