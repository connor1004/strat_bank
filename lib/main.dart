import 'package:flutter/material.dart';
import 'package:flutter_base/provider_setup.dart';
import 'package:flutter_base/ui/router.dart';
import 'package:provider/provider.dart';

import 'core/constants/app_contstants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Tahoma',
          appBarTheme: AppBarTheme().copyWith(
            iconTheme: IconThemeData().copyWith(
              color: Colors.black
            )
          )
        ),
        initialRoute: RoutePath.Splash,
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
