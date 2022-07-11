part of 'routes.dart';

// Routes Args using for passing the value from one screen to other screen
class WebViewArgs {
  String url;
  String? title;

  WebViewArgs({required this.url, this.title});
}

class PainEvaluationArgs {
  String id;

  PainEvaluationArgs({required this.id});
}

class PdfViewerArgs {
  String? url;
  String? title;

  PdfViewerArgs({required this.url, required this.title});
}

class ConsentScreenArgs {
  String? videoUrl;
  String? pdfUrl;
  String? studyName;
  String? title;
  File? pdfFile;
  InformedConsentModel? model;

  ConsentScreenArgs({
    this.videoUrl,
    this.pdfUrl,
    this.studyName,
    this.title,
    this.model,
    this.pdfFile,
  });
}

class StudyScreenArgs {
  StudyConfigurationFormModel studyFormModel;
  int visitId;

  StudyScreenArgs({
    required this.studyFormModel,
    required this.visitId,
  });
}
