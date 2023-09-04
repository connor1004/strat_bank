import 'package:flutter/material.dart';
import 'package:flutter_base/core/constants/app_contstants.dart';
import 'package:flutter_base/core/viewmodels/views/begin_survey_view_model.dart';
import 'package:flutter_base/ui/views/base/base_widget.dart';
import 'package:flutter_base/ui/widgets/custom_card.dart';
import 'package:provider/provider.dart';

class BeginSurveyView extends StatefulWidget {
  @override
  _BeginSurveyViewState createState() => _BeginSurveyViewState();
}

class _BeginSurveyViewState extends State<BeginSurveyView> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      model: BeginSurveyViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/wood-background.png'),
              alignment: Alignment.topCenter,
              fit: BoxFit.cover,
            ),
          ),
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.white,
                  title: Padding(
                    padding: EdgeInsets.only(bottom: 7),
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          'assets/appbar-logo.png',
                          fit: BoxFit.cover,
                          width: 65,
                          height: 65,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 7),
                          child: Text(
                            'Evolvebank',
                            style: TextStyle(
                              color: Color(0xFF253D99),
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: getNestedScrollViewBody(context),
            ),
          ),
        ),
      ),
      onModelReady: (BeginSurveyViewModel beginSurveyViewModel) => {
        // splashViewModel.isLoginInSaved().then((saved) => Navigator.of(context)
        //     .pushNamedAndRemoveUntil(
        //         saved ? RoutePath.Home : RoutePath.CategoryList,
        //         (Route<dynamic> route) => false))
      },
      builder: (context, model, child) => child,
    );
  }

  Widget getNestedScrollViewBody(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 47.5, horizontal: 15.5),
          decoration: BoxDecoration(
            color: Color(0xFF253D99),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Color(0x29000000),
                offset: Offset(0, 3),
                blurRadius: 6,
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            bottom: false,
            right: false,
            child: Text(
              'Thank you for visiting our branch!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          child: MediaQuery.of(context).orientation == Orientation.portrait
            ? Image.asset(
              'assets/thankyou-portrait.png',
              fit: BoxFit.fitWidth,
            )
            : Image.asset(
              'assets/thankyou-landscape.png',
              height: 288,
            )
        ),
        getBody(context),
      ],
    );
  }

  Widget getBody(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 22),
      width: double.infinity,
      child: MediaQuery.of(context).orientation == Orientation.portrait ? Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          getCard(),
        ],
      ) : getCard(),
    );
  }

  Widget getCard() {
    return SafeArea(
      top: false,
      bottom: false,
      child: CustomCard(
        body: Padding(
          padding: EdgeInsets.fromLTRB(20, 25, 20, 75),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Please take a moment to tell us about your experience today.',
                style: TextStyle(
                  color: Color(0xFF253D99),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Text(
                  'We appreciate your feedback! As a token of our appreciation, please accept our offer of a \$10 Amazon gift card upon survey completion.',
                  style: TextStyle(
                    color: Color(0xFF070707),
                    fontSize: 20,
                  ),
                ),
              )
            ],
          ),
        ),
        buttonText: 'Begin Survey',
        buttonImageAsset: 'assets/send-btn.png',
        onPressed: () {
          Navigator.of(context)
            .pushNamedAndRemoveUntil(RoutePath.Quiz, (_) => false);
        },
      ),
    );
  }
}
