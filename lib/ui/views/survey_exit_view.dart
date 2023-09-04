import 'package:flutter/material.dart';
import 'package:flutter_base/core/viewmodels/views/survey_exit_view_model.dart';
import 'package:flutter_base/ui/views/base/base_widget.dart';
import 'package:flutter_base/ui/widgets/custom_card.dart';
import 'package:provider/provider.dart';

class SurveyExitView extends StatefulWidget {
  @override
  _SurveyExitViewState createState() => _SurveyExitViewState();
}

class _SurveyExitViewState extends State<SurveyExitView> {

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      model: SurveyExitViewModel(),
      child: Scaffold(
        backgroundColor: Color(0xFFDDDBDB),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 17, horizontal: 15),
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 21.36),
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 24),
                    decoration: BoxDecoration(
                      color: Color(0xFFFCFCFF),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Color(0x29000000),
                          offset: Offset(0, 3),
                          blurRadius: 6,
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Thank you for your valuable feedback',
                          style: TextStyle(
                            color: Color(0xFF253D99),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 29),
                          child: Text(
                            'Please enjoy a \$10 Amazon Gift Card from us!',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF030303),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  CustomCard(
                    body: Padding(
                      padding: EdgeInsets.fromLTRB(28, 28, 28, 55),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Image.asset('assets/gift-card.png', fit: BoxFit.cover),
                      )
                    ),
                    buttonText: 'Email Gift Card',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      onModelReady: (SurveyExitViewModel surveyExitViewModel) => {
        // splashViewModel.isLoginInSaved().then((saved) => Navigator.of(context)
        //     .pushNamedAndRemoveUntil(
        //         saved ? RoutePath.Home : RoutePath.CategoryList,
        //         (Route<dynamic> route) => false))
      },
      builder: (context, model, child) => child,
    );
  }
}
