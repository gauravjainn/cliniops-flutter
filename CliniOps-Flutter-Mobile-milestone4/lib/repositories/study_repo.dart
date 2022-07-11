import 'package:clini_app/data/data.dart';
import 'package:clini_app/data/models/document.dart';
import 'package:clini_app/data/models/open_video.dart';
import 'package:clini_app/services/services.dart';
import 'package:clini_app/ui/chat/call_widget.dart';
import 'package:clini_app/utils/utils.dart';

// study related
class StudyRepo {
  final _httpService = HttpService();

  static const _baseStudyUrl = '/subject/eprowebservice';

  Future<Responser<List<StudyModel>>> getStudiesList() async {
    try {
      final resp = await _httpService.makePostRequest(
        _baseStudyUrl + '/getstudies',
        {},
      ) as List;

      final res = resp
          .map((e) => StudyModel.fromJson(e as Map<String, dynamic>))
          .toList();

      return Responser<List<StudyModel>>(
        message: 'Fetch success',
        isSuccess: true,
        data: res,
      );
    } catch (e) {
      return ErrorHandler.error<List<StudyModel>>(e);
    }
  }

  Future<Responser<List<Document>>> getDocumentList(int studyId) async {
    try {
      final payload = {'studyId': studyId.toString()};
      final resp = await _httpService.makePostRequest(
        _baseStudyUrl + '/getdocuments',
        payload,
      );
      Logger.logMsg(this, resp);
      if (resp != null) {
        var list = resp['documents'] as List;
        var listDoc = list
            .map((e) => Document.fromJson(e as Map<String, dynamic>))
            .toList();

        return Responser<List<Document>>(
          message: 'Fetch success',
          isSuccess: true,
          data: listDoc,
        );
      }

      return Responser<List<Document>>(
        message: 'Fetch success',
        isSuccess: true,
        data: [],
      );
    } catch (e) {
      return ErrorHandler.error<List<Document>>(e);
    }
  }

  Future<Responser<String>> getStudyVersion({required String studyId}) async {
    final payload = {'studyId': studyId};

    try {
      final resp = await _httpService.makePostRequest(
        _baseStudyUrl + '/getstudyversion',
        payload,
      );

      return Responser<String>(
        message: resp['message'].toString(),
        isSuccess: true,
        data: resp['version'].toString(),
      );
    } catch (e) {
      return ErrorHandler.error<String>(e);
    }
  }

  Future<Responser<OpenTokConfig>> getOpenTekConfig(
      {required String userId, required String entityId}) async {
    final payload = {
      'entityId': entityId,
      'userId': userId,
    };

    try {
      final resp = await _httpService.makePostRequest(
        _baseStudyUrl + '/get-televisit-session-details',
        payload,
      );
      Logger.logMsg(this, '${resp}');
      return Responser<OpenTokConfig>(
        message: '',
        isSuccess: true,
        data: OpenTokConfig(
            API_KEY: resp['api_key'].toString(),
            SESSION_ID: resp['session'].toString(),
            TOKEN: resp['token'].toString()),
      );
    } catch (e) {
      return ErrorHandler.error<OpenTokConfig>(e);
    }
  }

  Future<Responser<StudyFormModel>> getStudyFormsConfiguration({
    required int studyId,
  }) async {
    final payload = {'studyId': studyId};

    try {
      final resp = await _httpService.makePostRequest(
        _baseStudyUrl + '/getStudyFormsConfiguration',
        payload,
      );
      Logger.logMsg(this, resp['studyConfiguration']['visits']);
      final res = StudyFormModel.fromJson(resp as Map);

      return Responser<StudyFormModel>(
        message: resp['message'].toString(),
        isSuccess: true,
        data: res,
      );
    } catch (e) {
      return ErrorHandler.error<StudyFormModel>(e);
    }
  }

  Future<Responser> saveSubjectData({
    required StudyFormReqModel studyForm,
  }) async {
    final payload = {'data': studyForm.toJson()};

    try {
      final resp = await _httpService.makePostRequest(
        _baseStudyUrl + '/savesubjectdata',
        payload,
      );

      Logger.logMsg(this, resp.toString());

      return Responser(
        message: resp['message'].toString(),
        isSuccess: true,
      );
    } catch (e) {
      return ErrorHandler.error(e);
    }
  }
}
