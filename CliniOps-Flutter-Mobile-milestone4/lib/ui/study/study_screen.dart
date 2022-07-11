import 'package:cached_network_image/cached_network_image.dart';
import 'package:clini_app/controllers/controllers.dart';
import 'package:clini_app/data/data.dart';
import 'package:clini_app/routes/routes.dart';
import 'package:clini_app/ui/common/common.dart';
import 'package:clini_app/ui/study/study.dart';
import 'package:clini_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudyScreen extends StatefulWidget {
  final StudyScreenArgs args;

  const StudyScreen(this.args);

  @override
  _StudyScreenState createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> {
  final _pageCtrl = PageController();

  late StudyNotifier _notifier;

  @override
  void initState() {
    super.initState();
    _notifier = context.read<StudyNotifier>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CliniAppBar(
        title: widget.args.studyFormModel.formNameLabels?.tryFirst?.getLabel ??
            'NA',
      ),
      body: GestureDetector(
        onTap: ()=> FocusScope.of(context).requestFocus(FocusNode()),
        child: PageView.builder(
          controller: _pageCtrl,
          itemCount: widget.args.studyFormModel.itemGroups?.length ?? 0,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, index) {
            final data = widget.args.studyFormModel.itemGroups![index];
      
            return ListView(
              children: [
                if (data.blobDetails != null) ...{
                  CachedNetworkImage(
                    imageUrl: AppEnvironment.apiUrl +
                        data.blobDetails!.fileLocation.toString(),
                    height: 280.h,
                    placeholder: (context, url) => const Center(
                      child: SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator()),
                    ),
                    errorWidget: (context, url, error) =>
                        const Text('Invalid Image'),
                  ),
                },
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
                  child: StudyFormBuilder(
                    data: data,
                    initialData: _notifier.studyFormReqModel?.visits
                        ?.tryFirstWhere(
                            (element) => element.visitsId == widget.args.visitId)
                        ?.forms
                        .tryFirstWhere((element) =>
                            element.formId == widget.args.studyFormModel.formId!)
                        ?.itemGroups
                        .tryElementAt(index),
                    indexPage: index,
                    formId: widget.args.studyFormModel.formId!,
                    visitId: widget.args.visitId,
                    ctaLabel:
                        (widget.args.studyFormModel.itemGroups!.length - 1) !=
                                index
                            ? 'Next'
                            : 'Submit',
                    onNextTap: () => _handleNextCta(index),
                    onPrevTap: _handlePrevtCta,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _handleNextCta(int index) async {
    if (_pageCtrl.page == widget.args.studyFormModel.itemGroups!.length - 1) {
      // TODO: call api to save data if internet
      context.showLoadingIndicator();
      final visitIndex = _notifier.studyFormReqModel?.visits?.indexOf(
              VisitReqModel(visitsId: widget.args.visitId, forms: [])) ??
          -1;

      if (visitIndex == -1) {
        return;
      }

      final formIndex =
          _notifier.studyFormReqModel?.visits![visitIndex].forms.indexOf(
                FormReqModel(
                  formId: widget.args.studyFormModel.formId!,
                  itemGroups: [],
                ),
              ) ??
              -1;
      if (formIndex == -1) {
        return;
      }
      _notifier.studyFormReqModel?.visits![visitIndex].forms[formIndex]
          .isCompleted = true;
      _notifier.notifyListeners();

      context.showSnackBar('Data saved successfully', actionTitle: 'Success');

      if (_notifier.studyFormReqModel != null) {
        try {
          final res = await _notifier.saveSubjectData(
              studyForm: _notifier.studyFormReqModel!);
          if (res.isSuccess) {
            _notifier.studyFormReqModel?.visits![visitIndex].forms[formIndex]
                .isDataUpload = true;
            _notifier.notifyListeners();
          }
        } catch (e) {
          Logger.logError(this, e);
        }
      }
      context.removeLoadingIndicator();
      AppEnvironment.navigator.pop();
    } else {
      _pageCtrl.nextPage(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeIn,
      );
    }
  }

  void _handlePrevtCta() {
    _pageCtrl.previousPage(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeIn,
    );
  }
}
