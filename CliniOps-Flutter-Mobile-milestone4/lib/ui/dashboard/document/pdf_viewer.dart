import 'dart:io';

import 'package:clini_app/routes/routes.dart';
import 'package:clini_app/ui/common/common.dart';
import 'package:clini_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewer extends StatefulWidget {
  final PdfViewerArgs? url;
  const PdfViewer(
    this.url,
  );
  @override
  _PdfViewerState createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CliniAppBar(
        title: '${widget.url!.title}',
        endWidget: IconButton(
          onPressed: _handleSaveFile,
          icon: const Icon(Icons.download),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            Expanded(
              child: widget.url!.url!.contains('https')
                  ? SfPdfViewer.network(
                      widget.url?.url ?? '',
                      onDocumentLoadFailed: (_) {
                        context.showSnackBar(
                          'PDF loading is failed .Please try again',
                          actionTitle: 'Error',
                        );
                      },
                    )
                  : SfPdfViewer.file(
                      File(widget.url?.url ?? ''),
                      onDocumentLoadFailed: (_) {
                        context.showSnackBar(
                          'PDF loading is failed .Please try again',
                          actionTitle: 'Error',
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSaveFile() async {
    context.showLoadingIndicator();

    if (widget.url != null) {
      if (!widget.url!.url!.contains('https')) {
        context.removeLoadingIndicator();
        await context.savePdfDocumentToDocumentFolder(
          File(widget.url!.url!).readAsBytesSync(),
          'Consent_form',
        );
        return;
      }
      var file = await _downloadFile(
          widget.url!.url!, widget.url!.url!.split('/').last.split('.').first);
      await context.savePdfDocumentToDocumentFolder(
        file.readAsBytesSync(),
        widget.url?.title??"NA",
      );
    }
    context.removeLoadingIndicator();
  }

  Future<File> _downloadFile(String url, String filename) async {
    var client = http.Client();
    var req = await client.get(Uri.parse(url));
    var bytes = req.bodyBytes;
    var dir = (await getApplicationDocumentsDirectory()).path;
    var file = File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }
}
