import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_base/core/constants/app_contstants.dart';
import 'package:flutter_base/core/viewmodels/views/bank_affair_view_model.dart';
import 'package:flutter_base/ui/views/base/base_widget.dart';
import 'package:flutter_base/ui/widgets/custom_card.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class BankAffairView extends StatefulWidget {
  final WebSocketChannel socketChannel;

  BankAffairView(this.socketChannel) : super();

  @override
  _BankAffairViewState createState() => _BankAffairViewState();
}

class _BankAffairViewState extends State<BankAffairView> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      model: BankAffairViewModel(),
      child: Scaffold(
        backgroundColor: Color(0xFFDDDBDB),
        body: NestedScrollView(
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
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(35, 27, 35, 40),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Welcome to Evolvebank.',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(22, 20, 0, 0),
                          child: Text(
                            'How can we help you today?',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFFCCCCCC),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 22, horizontal: 15),
                  width: MediaQuery.of(context).orientation == Orientation.portrait ? double.infinity : 500,
                  child: SafeArea(
                    top: false,
                    bottom: false,
                    child: Column(
                      children: <Widget>[
                        CustomCard(
                          imageAsset: 'assets/meet.png',
                          body: Padding(
                            padding: EdgeInsets.fromLTRB(20, 20, 20, 47),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Need to meet with us?',
                                  style: TextStyle(
                                    color: Color(0xFF253D99),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        'Current Wait Time: ',
                                        style: TextStyle(
                                          color: Color(0xFF070707),
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(
                                        '5',
                                        style: TextStyle(
                                          color: Color(0xFF253D99),
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        ' min',
                                        style: TextStyle(
                                          color: Color(0xFF070707),
                                          fontSize: 20,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          buttonText: 'Reserve Your Spot',
                          buttonImageAsset: 'assets/meet-btn.png',
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.57),
                          child: CustomCard(
                            imageAsset: 'assets/loans.png',
                            body: Padding(
                              padding: EdgeInsets.fromLTRB(20, 17, 20, 50),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Applying for a Loan?',
                                    style: TextStyle(
                                      color: Color(0xFF253D99),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Text(
                                      'Fill out your paperwork while you wait.',
                                      style: TextStyle(
                                        color: Color(0xFF070707),
                                        fontSize: 20,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            buttonText: 'Get Started',
                            buttonImageAsset: 'assets/pen-btn.png',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      onModelReady: (BankAffairViewModel bankAffairViewModel) {
        StreamSubscription subscription;
        String siteId = '';
        bool isNavigated = false;
        int times = 0;
        subscription = widget.socketChannel.stream.listen((data) {
          print('data received in Bank Affair: $data');
          if ((data is Map) && (data['site_id'] != null || (data['data'] != null && data['data']['site_id'] != null))) {
            siteId = data['site_id'] != null ? data['site_id'].toString() : data['data']['site_id'].toString();
            print('getting site_id: $siteId');
            times = 0;
          }
          else {
            times++;
            print('not getting site_id $times times, received data: $data');
            if (times >= 5) {
              subscription.cancel();
              widget.socketChannel.sink.close();
              if (!isNavigated) {
                isNavigated = true;
                Navigator.of(context)
                  .pushNamedAndRemoveUntil(RoutePath.BeginSurvey, (_) => false,);
              }
            }
          }
        }, onError: (e, s) {
          print('websocket connection error: $e, $s');
          subscription.cancel();
          if (!isNavigated) {
            isNavigated = true;
            Timer(Duration(seconds: 5), () {
              Navigator.of(context)
                .pushNamedAndRemoveUntil(RoutePath.BeginSurvey, (_) => false);
            });
          }
        }, onDone: () {
          print('socket was closed');
          subscription.cancel();
          if (!isNavigated) {
            isNavigated = true;
            Timer(Duration(seconds: 5), () {
              Navigator.of(context)
                .pushNamedAndRemoveUntil(RoutePath.BeginSurvey, (_) => false);
            });
          }
        });
      },
      builder: (context, model, child) => child,
    );
  }
}
