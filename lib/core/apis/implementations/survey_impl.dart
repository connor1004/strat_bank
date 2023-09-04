import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_base/core/apis/interfaces/survey_api.dart';
import 'package:flutter_base/core/models/question.dart';
import 'package:flutter_base/core/models/reply.dart';

class SurveyImpl extends SurveyApi {
  @override
  Future<List<Question>> getRandomQuestions(int count) async {
    List<Question> questions = await Firestore.instance
      .collection('questions')
      .getDocuments()
      .then((QuerySnapshot snapshot) {
        return snapshot.documents.map((DocumentSnapshot docSnapshot) {
          Question question = Question.fromMap(docSnapshot.data);
          question.id = docSnapshot.documentID;
          return question;
        }).toList();
      });
    if (questions.length <= count) {
      return questions;
    }
    List<Question> realQuestions = List<Question>();
    for (int i = 0; i < count; i++) {
      var rng = Random();
      int index = rng.nextInt(questions.length);
      realQuestions.add(questions[index]);
      questions.removeAt(index);
    }
    return realQuestions;
  }

  @override
  Future<void> uploadSurveyData(List<Reply> data) async {
    try {
      data.forEach((reply) async {
        await Firestore.instance
          .collection('questions/' + reply.questionId + '/replies')
          .add(reply.toMap());
      });
    } catch (e, s) {
      print('uploadSurveyData error: $e, $s');
      return Future.error(e);
    }
  }
}