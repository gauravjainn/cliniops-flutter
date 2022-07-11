import 'package:clini_app/controllers/controllers.dart';
import 'package:clini_app/data/data.dart';
import 'package:clini_app/routes/routes.dart';
import 'package:clini_app/themes/app_text.dart';
import 'package:clini_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DocumentView extends StatefulWidget {
  const DocumentView();

  @override
  State<DocumentView> createState() => _DocumentViewState();
}

class _DocumentViewState extends State<DocumentView> {
  @override
  void initState() {
    super.initState();
    final _notifer = context.read<StudyNotifier>();
    if (_notifer.consentFormPDf != null) {
      final notifer = context.read<DocumentNotifier>();
      var item = notifer.documetList
          .tryFirstWhere((element) => element.origFileName == 'Consent Form');
      if (item == null) {
        notifer.documetList.add(Document(
            date: '',
            fileLocation: _notifer.consentFormPDf,
            origFileName: 'Consent Form'));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DocumentNotifier>(
      builder: (_, model, __) {
        Widget child = const Center(child: Text(' No Document Found'));
        if (model.documetList.isNotEmpty) {
          return ListView.builder(
            reverse: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => {
                  AppEnvironment.navigator.pushNamed(GeneralRoutes.pdfViewer,
                      arguments: PdfViewerArgs(
                        title:   model.documetList[index].origFileName!
                                  .split('.')
                                  .first,
                          url: model.documetList[index].fileLocation))
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  margin: EdgeInsets.symmetric(vertical: 16.h),
                  height: 92.h,
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.all(16.r),
                        margin: EdgeInsets.only(right: 16.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.25),
                              spreadRadius: 3,
                              blurRadius: 2,
                              offset: const Offset(
                                0,
                                3,
                              ), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              model.documetList[index].origFileName!
                                  .split('.')
                                  .first,
                              style: AppText.text18w400Grey,
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CircleAvatar(
                          backgroundImage:
                              const AssetImage(Images.arrowFillRight),
                          radius: 17.r,
                          backgroundColor: AppColors.white,
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
            itemCount: model.documetList.length,
          );
        }
        // if (model.consentFormPDf?.isNotEmpty ?? false) {
        //   child = GestureDetector(
        //     onTap: () => AppEnvironment.navigator
        //         .pushNamed(ConsentRoutes.consentPreviewScreen),
        //     child: Container(
        //       padding: EdgeInsets.symmetric(horizontal: 32.w),
        //       margin: EdgeInsets.symmetric(vertical: 16.h),
        //       height: 92.h,
        //       child: Stack(
        //         children: [
        //           Container(
        //             padding: EdgeInsets.all(16.r),
        //             margin: EdgeInsets.only(right: 16.w),
        //             decoration: BoxDecoration(
        //               color: Colors.white,
        //               borderRadius: BorderRadius.circular(8.r),
        //               boxShadow: [
        //                 BoxShadow(
        //                   color: Colors.grey.withOpacity(0.25),
        //                   spreadRadius: 3,
        //                   blurRadius: 2,
        //                   offset: const Offset(
        //                     0,
        //                     3,
        //                   ), // changes position of shadow
        //                 ),
        //               ],
        //             ),
        //             child: Column(
        //               crossAxisAlignment: CrossAxisAlignment.stretch,
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 Text(
        //                   'Consent Form',
        //                   style: AppText.text18w400Grey,
        //                 ),
        //               ],
        //             ),
        //           ),
        //           Align(
        //             alignment: Alignment.centerRight,
        //             child: CircleAvatar(
        //               backgroundImage: const AssetImage(Images.arrowFillRight),
        //               radius: 17.r,
        //               backgroundColor: AppColors.white,
        //             ),
        //           )
        //         ],
        //       ),
        //     ),
        //   );
        // }
        return child;
      },
    );
  }
}
