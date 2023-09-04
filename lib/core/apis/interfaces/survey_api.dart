import 'package:flutter_base/core/models/question.dart';
import 'package:flutter_base/core/models/reply.dart';

abstract class SurveyApi {
  Future<List<Question>> getRandomQuestions(int count);

  Future<void> uploadSurveyData(List<Reply> data);
}