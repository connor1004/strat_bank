import 'package:flutter/material.dart';

class CustomRadio extends StatefulWidget {
  final List<String> answers;
  final void Function(String value) onValueChanged;

  CustomRadio({this.answers, this.onValueChanged}) : super();

  @override
  createState() {
    return new CustomRadioState();
  }
}

class CustomRadioState extends State<CustomRadio> {
  List<RadioModel> sampleData = new List<RadioModel>();

  @override
  void initState() {
    super.initState();
    widget.answers.forEach((value) {
      sampleData.add(RadioModel(false, value));
    });
  }

  @override
  void didUpdateWidget(CustomRadio oldWidget) {
    super.didUpdateWidget(oldWidget);
    sampleData.clear();
    widget.answers.forEach((value) {
      sampleData.add(RadioModel(false, value));
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: sampleData.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return new InkWell(
          //highlightColor: Colors.red,
          splashColor: Colors.blueAccent,
          onTap: () {
            setState(() {
              sampleData.forEach((element) => element.isSelected = false);
              sampleData[index].isSelected = true;
              widget.onValueChanged(sampleData[index].text);
            });
          },
          child: new RadioItem(sampleData[index]),
        );
      },
    );
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;

  RadioItem(this._item);

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.symmetric(vertical: 12.5),
      child: new Row(
        children: <Widget>[
          Container(
            height: 30.0,
            width: 30.0,
            child: Center(
              child: _item.isSelected ? CircleAvatar(
                backgroundColor: Color(0xFF2699FB),
                radius: 8,
              ) : Text(''),
            ),
            decoration: BoxDecoration(
              border: Border.all(
                  width: 3.0,
                  color: Color(0xFF7FC4FD),
              ),
              borderRadius: const BorderRadius.all(const Radius.circular(20.0)),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 17.0),
              child: Text(
                _item.text,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF030303),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final String text;

  RadioModel(this.isSelected, this.text);
}