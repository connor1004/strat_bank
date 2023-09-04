import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base/core/constants/app_contstants.dart';
import 'package:flutter_base/ui/route_effects/fade_route.dart';
import 'package:flutter_base/ui/views/bank_affair_view.dart';
import 'package:flutter_base/ui/views/begin_survey_view.dart';
import 'package:flutter_base/ui/views/quiz_view.dart';
import 'package:flutter_base/ui/views/splash_view.dart';
import 'package:flutter_base/ui/views/survey_exit_view.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
// import 'package:flutter_base/ui/views/category_list_view.dart';
// import 'package:flutter_base/ui/views/home_view.dart';
// import 'package:flutter_base/ui/views/item_detail_view.dart';
// import 'package:flutter_base/ui/views/item_list_view.dart';
// import 'package:flutter_base/ui/views/login_view.dart';
// import 'package:flutter_base/ui/views/news_view.dart';
// import 'package:flutter_base/ui/views/patio_view.dart';
// import 'package:flutter_base/ui/views/wellness_view.dart';
// import 'package:flutter_base/ui/widgets/share_dialog.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case RoutePath.Home:
      //   return MaterialPageRoute(builder: (_) => HomeView());
      case RoutePath.Splash:
        return FadeRoute(page: SplashView());
      case RoutePath.BankAffair:
        final Map<String, WebSocketChannel> argMap = settings.arguments;
        return MaterialPageRoute(builder: (_) => BankAffairView(argMap['socket']));
      case RoutePath.BeginSurvey:
        return FadeRoute(page: BeginSurveyView());
      case RoutePath.Quiz:
        return FadeRoute(page: QuizView());
      case RoutePath.SurveyExit:
        return MaterialPageRoute(builder: (_) => SurveyExitView());
      // case RoutePath.Login:
      //   return MaterialPageRoute(builder: (_) => LoginView());
      // case RoutePath.CategoryList:
      //   return MaterialPageRoute(builder: (_) => CategoryListView());
      // case RoutePath.ItemList:
      //   return MaterialPageRoute(builder: (_) => ItemListView());
      // case RoutePath.ItemDetail:
      //   return MaterialPageRoute(builder: (_) => ItemDetailView());
      // case RoutePath.ShareDialog:
      //   return MaterialPageRoute(builder: (_) => ShareDialog());
      // case RoutePath.Wellness:
      //   return MaterialPageRoute(builder: (_) => WellnessView());
      // case RoutePath.News:
      //   return PageRouteBuilder(pageBuilder: (_, __, ___) => NewsView());
      // case RoutePath.Patio:
      //   return MaterialPageRoute(builder: (_) => PatioView());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}

