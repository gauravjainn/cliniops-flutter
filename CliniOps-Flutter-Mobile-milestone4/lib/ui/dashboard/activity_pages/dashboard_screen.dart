import 'package:clini_app/controllers/controllers.dart';
import 'package:clini_app/controllers/document/document_notifier.dart';
import 'package:clini_app/data/data.dart';
import 'package:clini_app/generated/l10n.dart';
import 'package:clini_app/routes/routes.dart';
import 'package:clini_app/services/services.dart';
import 'package:clini_app/themes/app_text.dart';
import 'package:clini_app/ui/dashboard/dashboard.dart';
import 'package:clini_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  final _bodyList = <String, Widget>{};

  final tabList = <Tab>[];

  final _selectedIndex = ValueNotifier(0);
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _initialize();
  }

  void _initialize() {
    // TODO: Temp code to fix localiztion

    tabList.addAll([
      Tab(
        text: 'List View'.toUpperCase(),
      ),
      Tab(text: 'Calendar View'.toUpperCase())
    ]);
    _bodyList.addAll({
      'List View': const ListDashboardScreen(),
      'Calendar View': const CalendarDashboardScreen(),
    });
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _getStudyFormConfiguration();
      _saveData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: AppColors.bgLightGrey,
        child: Column(
          children: [
            TabBar(
              controller: _tabController,
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
              labelPadding: EdgeInsets.symmetric(vertical: 3.h),
              indicatorWeight: 2.h,
              onTap: (index) => _selectedIndex.value = index,
              indicatorColor: AppColors.appPrimary,
              indicator: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(6.r),
                boxShadow: AppColors.normalBoxShadow,
              ),
              labelColor: AppColors.textBlack,
              overlayColor: MaterialStateProperty.all(AppColors.greyBGColor),
              labelStyle: AppText.text18w400Black.copyWith(fontSize: 16.sp),
              tabs: tabList,
              unselectedLabelColor: AppColors.blackPrimary,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: tabList.map((Tab tab) {
                  var label = tab.text.toString();
                  return label == S.of(context).listView.toUpperCase()
                      ? _bodyList.values.elementAt(0)
                      : _bodyList.values.elementAt(1);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _getStudyFormConfiguration() async {
    final notifier = context.read<StudyNotifier>();
    final notifierDocument = context.read<DocumentNotifier>();
    context.showLoadingIndicator();
    try {
      final resp = await notifier.getStudiesList();
      // context.removeLoadingIndicator();

      if (!resp.isSuccess) {
        context.showErrorSnackBar(resp.message);
        if (resp.message.contains(S.of(AppEnvironment.ctx).sessionExpired)) {
          await SecureStorage().removeAllPrefs();

          AppEnvironment.navigator.pushNamedAndRemoveUntil(
              AuthRoutes.loginScreen, (route) => false);
        }
        return;
      }
      final element = notifier.availableStudies.tryFirst;
      if (element?.id == null) {
        return;
      }
      // context.showLoadingIndicator();
      final studyResp = await Future.any([
        notifier.getStudyFormsConfiguration(studyId: element!.id!),
        notifierDocument.getDocumentList(studyId: element.id!),
      ]);
      context.removeLoadingIndicator();
      if (!studyResp.isSuccess) {
        context.showErrorSnackBar(studyResp.message, actionTitle: 'Error');
        if (resp.message.contains(S.of(AppEnvironment.ctx).sessionExpired)) {
          await SecureStorage().removeAllPrefs();

                 AppEnvironment.navigator.pushNamedAndRemoveUntil(
              AuthRoutes.loginScreen, (route) => false);
        }
      }

    } catch (e) {

      Logger.logError(this, e);
    } finally {
      context.removeLoadingIndicator();
    }
    
  }

  Future<void> _saveData() async {
    try {
      final notifier = context.read<StudyNotifier>();
      context.showLoadingIndicator();
      var model = StudyFormReqModel(
        studyId: notifier.studyFormReqModel?.studyId,
        visits: [],
      );

      if (notifier.studyFormReqModel != null) {
        for (var element
            in (notifier.studyFormReqModel?.visits ?? <VisitReqModel>[])) {
          var forms =
              element.forms.where((element) => !element.isDataUpload).toList();

          if (forms.isNotEmpty) {
            var formVist = VisitReqModel(
              visitsId: element.visitsId,
              forms: forms,
            );
            model.visits?.add(formVist);
          }
        }
      }

      Logger.logMsg(this, model.visits?.length);

      if (model.visits?.isNotEmpty ?? false) {
        final res = await notifier.saveSubjectData(studyForm: model);
        if (res.isSuccess) {
          Logger.logMsg(this, 'Offline Data Upload successfully');

          model.visits?.forEach((element) {
            for (var ele in element.forms) {
              notifier.studyFormReqModel?.visits
                  ?.tryFirstWhere((x) => x.visitsId == element.visitsId)
                  ?.forms
                  .tryFirstWhere((x) => x.formId == ele.formId)
                  ?.isDataUpload = true;
              notifier.notifyListeners();
            }
          });
          Logger.logMsg(this, notifier.studyFormReqModel);
        }
      }
    } catch (e) {
      Logger.logError(this, e);
    } finally {
      context.removeLoadingIndicator();
    }
  }
}
