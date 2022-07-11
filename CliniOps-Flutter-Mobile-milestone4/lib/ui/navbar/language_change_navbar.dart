import 'package:clini_app/controllers/controllers.dart';
import 'package:clini_app/themes/app_text.dart';
import 'package:clini_app/ui/common/common.dart';
import 'package:clini_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageChangeNavBar extends StatelessWidget {
  const LanguageChangeNavBar();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _handleOnLanguageTap(context),
      child: Row(
        children: [
          const Icon(Icons.language),
          sizedBoxWithWidth(4),
          Text(
            context
                    .watch<StudyNotifier>()
                    .currentLanguage
                    ?.locale
                    ?.toUpperCase() ??
                '',
          ),
          sizedBoxWithWidth(8),
        ],
      ),
    );
  }

  void _handleOnLanguageTap(BuildContext context) {
    final _notifier = context.read<StudyNotifier>();
    final list = _notifier.studyFormModel?.studyConfiguration?.languages ?? [];
    context.showWidgetDialog(
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select Language',
              style: AppText.text20w400Black,
            ),
            sizedBoxWithHeight(8),
            Divider(thickness: 2.h),
            sizedBoxWithHeight(8),
            ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: list.length,
              itemBuilder: (_, index) => ListTile(
                contentPadding: EdgeInsets.zero,
                trailing: _notifier.currentLanguage == list[index]
                    ? const Icon(Icons.check)
                    : null,
                onTap: () {
                  _notifier.setCurrentLanguage(list.elementAt(index));
                  AppEnvironment.navigator.pop();
                },
                title: Text(
                  list.tryElementAt(index)?.languagename ?? 'NA',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
