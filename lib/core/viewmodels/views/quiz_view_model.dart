import 'package:flutter_base/core/apis/interfaces/survey_api.dart';
import 'package:flutter_base/core/models/question.dart';
import 'package:flutter_base/core/models/reply.dart';
import 'package:flutter_base/core/viewmodels/base_model.dart';

class QuizViewModel extends BaseModel {
  SurveyApi _surveyApi;

  QuizViewModel(this._surveyApi);

  Future<List<Question>> getQuestions() async {
    setBusy(true);
    List<Question> questions = await _surveyApi.getRandomQuestions(4);
    setBusy(false);
    return questions;
  }

  Future<void> uploadSurveyData(List<Reply> replies) async {
    setBusy(true);
    try {
      await _surveyApi.uploadSurveyData(replies);
    } catch(e, s) {
      print('uploadSurveyData error: $e, $s');
      return Future.error(e);
    }
  }
}
