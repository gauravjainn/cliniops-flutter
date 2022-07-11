import 'package:clini_app/routes/routes.dart';
import 'package:clini_app/themes/app_text.dart';
import 'package:clini_app/ui/common/common.dart';
import 'package:clini_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ConsentPdfScreen extends StatefulWidget {
  final VoidCallback? onTap;
  final Function()? onrest;
  final ConsentScreenArgs args;

  const ConsentPdfScreen({
    required this.onTap,
    required this.args,
    this.onrest,
  });

  @override
  _ConsentPdfScreenState createState() => _ConsentPdfScreenState();
}

class _ConsentPdfScreenState extends State<ConsentPdfScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          sizedBoxWithHeight(32),
          Text('Study Name', style: AppText.text22w700Black),
          sizedBoxWithHeight(8),
          Text(widget.args.studyName ?? 'NA', style: AppText.text16w400Grey),
          sizedBoxWithHeight(16),
          // TextButton(
          //   onPressed: widget.onrest,
          //   child: const Text('Resignature the form'),
          // ),
          // IconButton(onPressed:widget.onrest, icon: const Icon(Icons.restore_page)),
          Expanded(
            child: SfPdfViewer.file(
              widget.args.pdfFile!,
              onDocumentLoadFailed: (_) {
                context.showSnackBar('PDF creation is failed .Please try again',
                    actionTitle: 'Error');
                widget.onrest;
              },
            ),
          ),
        ],
      ),
    );
  }
}
