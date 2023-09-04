import 'package:flutter/material.dart';
import 'package:flutter_base/core/apis/interfaces/survey_api.dart';
import 'package:flutter_base/core/constants/app_contstants.dart';
import 'package:flutter_base/core/models/question.dart';
import 'package:flutter_base/core/models/reply.dart';
import 'package:flutter_base/core/viewmodels/views/quiz_view_model.dart';
import 'package:flutter_base/ui/views/base/base_widget.dart';
import 'package:flutter_base/ui/widgets/custom_card.dart';
import 'package:flutter_base/ui/widgets/custom_radio.dart';
import 'package:provider/provider.dart';

class QuizView extends StatefulWidget {
  @override
  _QuizViewState createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  List<Question> questions;
  int currentIndex;
  String currentAnswer;
  List<Reply> replies;
  QuizViewModel viewModel;
  bool uploading;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    questions = List<Question>();
    currentIndex = -1;
    currentAnswer = '';
    replies = List<Reply>();
    uploading = false;
  }

  void onValueChanged(String value) {
    currentAnswer = value;
  }

  @override
  Widget build(BuildContext context) {
    viewModel = QuizViewModel(Provider.of<SurveyApi>(context));
    return BaseWidget(
      model: viewModel,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color(0xFFDDDBDB),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 22, horizontal: 15),
                width: MediaQuery.of(context).orientation == Orientation.portrait ? double.infinity: 384,
                child: CustomCard(
                  imageAsset: 'assets/bank.png',
                  body: Padding(
                    padding: EdgeInsets.fromLTRB(27, 15, 27, 47),
                    child: (questions != null && questions.isNotEmpty && !uploading) ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          questions[currentIndex].question,
                          style: TextStyle(
                            color: Color(0xFF030303),
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: CustomRadio(
                            answers: questions[currentIndex].answers,
                            onValueChanged: this.onValueChanged,
                          ),
                        )
                      ],
                    ) : Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  buttonText: (questions != null && questions.isNotEmpty)
                    ? (uploading ? 'Uploading answers ...' : 'Next Question')
                    : 'Loading...',
                  onPressed: () {
                    handleNextButtonClicked(context);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
      onModelReady: (QuizViewModel quizViewModel) async {
        // splashViewModel.isLoginInSaved().then((saved) => Navigator.of(context)
        //     .pushNamedAndRemoveUntil(
        //         saved ? RoutePath.Home : RoutePath.CategoryList,
        //         (Route<dynamic> route) => false))
        var randomQuestions = await quizViewModel.getQuestions();
        setState(() {
          questions = randomQuestions;
          currentIndex = 0;
          currentAnswer = null;
          replies = List<Reply>();
        });
        print('questions: $randomQuestions');
      },
      builder: (context, model, child) => child,
    );
  }

  void handleNextButtonClicked(BuildContext context) async {
    if (questions == null || questions.isEmpty) {
      return;
    }
    if (currentAnswer == null || currentAnswer.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Please select a answer'),));
      return;
    }
    replies.add(Reply(
      replier: 'tester',
      repliedAt: DateTime.now().toUtc(),
      repliedAtStr: DateTime.now().toUtc().toString(),
      questionId: questions[currentIndex].id,
      answer: currentAnswer,
    ));
    if (currentIndex == questions.length - 1) {
      if (viewModel != null) {
        setState(() {
          uploading = true;
        });
        await viewModel.uploadSurveyData(replies);
      }
      Navigator.of(context)
        .pushNamedAndRemoveUntil(RoutePath.SurveyExit, (_) => false);
    }
    else {
      setState(() {
        currentAnswer = '';
        currentIndex ++;
      });
    }
  }
}
