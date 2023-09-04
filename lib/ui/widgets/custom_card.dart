import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget body;
  final String imageAsset;
  final String buttonText;
  final String buttonImageAsset;
  final void Function() onPressed;

  CustomCard({
    @required this.body,
    @required this.buttonText,
    this.imageAsset,
    this.buttonImageAsset,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> bodyWidget = List<Widget>();
    if (imageAsset != null && imageAsset.isNotEmpty) {
      bodyWidget.add(Image.asset(
        imageAsset,
        width: double.infinity,
        fit: BoxFit.contain,
      ));
    }
    bodyWidget.add(body);

    List<Widget> buttonContent = List<Widget>();
    buttonContent.add(Padding(
      padding: EdgeInsets.only(right: 10),
      child: Text(
        buttonText,
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    ));
    if (buttonImageAsset != null && buttonImageAsset.isNotEmpty) {
      buttonContent.add(Image.asset(
        buttonImageAsset,
        height: 20,
        fit: BoxFit.cover,
      ));
    }

    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 30),
          width: double.infinity,
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
            children: bodyWidget,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 17),
            decoration: BoxDecoration(
              boxShadow:  <BoxShadow>[
                BoxShadow(
                  color: Color(0x29000000),
                  offset: Offset(0, 3),
                  blurRadius: 6,
                ),
              ],
            ),
            child: FlatButton(
              padding: EdgeInsets.fromLTRB(10, 17, 10, 20),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              color: Color(0xFF253D99),
              onPressed: onPressed == null ? () {} : onPressed,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: buttonContent,
              ),
            ),
          ),
        )
      ],
    );
  }
}
