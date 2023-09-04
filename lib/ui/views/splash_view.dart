import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/core/constants/app_contstants.dart';
import 'package:flutter_base/core/viewmodels/views/splash_view_model.dart';
import 'package:flutter_base/ui/views/base/base_widget.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  static const platform = const MethodChannel('example.com/flutterbase');

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      model: SplashViewModel(),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/splash-back.png'),
              alignment: Alignment.topCenter,
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).orientation == Orientation.portrait ? double.infinity: 384,
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
                      Image.asset('assets/splash-logo.png', fit: BoxFit.fitWidth,),
                      Padding(
                        padding: EdgeInsets.only(top: 0, left: 17, bottom: 20, right: 17),
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Digital solutions to drive brand relevance and product awareness',
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFF707070),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 50),
                              child: Text(
                                'STRATACACHE marketing technology delivers an informative, personalized in-branch experience.',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF030303),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text(
                                'Please enjoy this demo of how our analytics platform, Walkbase, can be leveraged in your branch.',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF030303),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      onModelReady: (SplashViewModel splashViewModel) async {
        String userId = await _getDeviceId();
        WebSocketChannel _webSocketChannel = IOWebSocketChannel.connect('wss://wai.walkbase.com/api/v2/subscribe/device');
        _webSocketChannel.sink.add('{"user_id": "$userId", "api_key": "VZHkscRFhAjkScc"}');

        bool isNavigated = false;
        int times = 0;
        String siteId = '';
        // StreamSubscription subscription;
        // subscription = _webSocketChannel.stream.listen((data) {
        //   print('data received: $data');
        //   if ((data is Map) && (data['site_id'] != null || (data['data'] != null && data['data']['site_id'] != null))) {
        //     siteId = data['site_id'] != null ? data['site_id'].toString() : data['data']['site_id'].toString();
        //     // subscription.cancel();
        //     times ++;
        //     print('receiving site_id $times times, site_id: $siteId');
        //     if (!isNavigated && times > 4) {
        //       isNavigated = true;
              
              Timer(Duration(seconds: 1), () {
                Navigator.of(context)
                  .pushNamedAndRemoveUntil(RoutePath.BankAffair, (_) => false, arguments: {'socket': _webSocketChannel});
              });
        //     }
        //   }
        //   else {
        //     times = 0;
        //     // if (times >= 5) {
        //     //   _webSocketChannel.sink.close();
        //     //   if (!isNavigated) {
        //     //     isNavigated = true;
        //     //     Navigator.of(context)
        //     //       .pushNamedAndRemoveUntil(RoutePath.BeginSurvey, (_) => false,);
        //     //   }
        //     // }
        //   }
        // }, onError: (e, s) {
        //   print('websocket connection error: $e, $s');
        //   // if (!isNavigated) {
        //   //   isNavigated = true;
        //   //   Timer(Duration(seconds: 5), () {
        //   //     Navigator.of(context)
        //   //       .pushNamedAndRemoveUntil(RoutePath.BeginSurvey, (_) => false);
        //   //   });
        //   // }
        // }, onDone: () {
        //   print('socket was closed');
        //   // if (!isNavigated) {
        //   //   isNavigated = true;
        //   //   Timer(Duration(seconds: 5), () {
        //   //     Navigator.of(context)
        //   //       .pushNamedAndRemoveUntil(RoutePath.BeginSurvey, (_) => false);
        //   //   });
        //   // }
        // });
      },
      builder: (context, model, child) => child,
    );
  }

  Future<String> _getDeviceId() async {
    String userDeviceId;
    try {
      userDeviceId = await platform.invokeMethod('getDeviceId');
    } on PlatformException catch (_) {
      userDeviceId = "userId";
    }

    return userDeviceId;
  }
}
