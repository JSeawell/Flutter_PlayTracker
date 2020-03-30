import 'package:flutter/material.dart';
import '../Screens/home_page_screen.dart';
import '../Screens/turnover_screen.dart';
import '../Models/Game.dart';
import '../Models/New_Play.dart';
import 'package:numberpicker/numberpicker.dart';

class RunPlayScreen extends StatefulWidget {

  Game game = Game();
  NewPlay newPlay = NewPlay();

  RunPlayScreen({Key key, this.game, this.newPlay}) : super(key: key);

  @override
  _RunPlayScreenState createState() => _RunPlayScreenState();
}

class _RunPlayScreenState extends State<RunPlayScreen> {

  int _currentValue = 0;
  int _radioChoice = 1;
  int _radioChoice2 = 1;

  void setMyRadio1(value){
    setState(() {
      _radioChoice = value;
    });
  }
  void setMyRadio2(value){
    setState(() {
      _radioChoice2 = value;
    });
  }

  void setMyPicker(newValue){
    setState(() {
      _currentValue = newValue;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Run Play"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Text("Type of Run:", style: TextStyle(fontSize: 30),),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                RadioChoice(context, "Inside", 1, _radioChoice, setMyRadio1),
                SizedBox(width: 20),
                RadioChoice(context, "Outside", 2, _radioChoice, setMyRadio1),
                SizedBox(width: 20),
                RadioChoice(context, "Off-Tackle", 3, _radioChoice, setMyRadio1),
              ]
            ),
            SizedBox(height: 20),
            Text("End Result:", style: TextStyle(fontSize: 30),),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                RadioChoice(context, "Yardage", 1, _radioChoice2, setMyRadio2),
                SizedBox(width: 20),
                RadioChoice(context, "Turnover", 2, _radioChoice2, setMyRadio2),
                SizedBox(width: 20),
                RadioChoice(context, "TD", 3, _radioChoice2, setMyRadio2),
              ]
            ),
            SizedBox(height: 10),
            _radioChoice2 == 2 ? SizedBox(height:185) : 
            YardagePicker(context, _currentValue, setMyPicker),
            SizedBox(height: 10),
            ClipRRect(borderRadius: BorderRadius.circular(10), child: SizedBox(
              height: 50, width: 200,
              child:
              RaisedButton(
                child: Text(_radioChoice2 == 2 ? "Continue" : "Add Play", style: TextStyle(fontSize: 30, color: Colors.white),),
                color: Colors.green,
                onPressed: (){
                  if (_radioChoice == 1){
                    widget.newPlay.specificType = "Inside";
                  }
                  else if (_radioChoice == 2){
                    widget.newPlay.specificType = "Outside";
                  }
                  else if (_radioChoice == 3){
                    widget.newPlay.specificType = "Off-Tackle";
                  }

                  if (_radioChoice2 == 2){
                    widget.newPlay.endResult = "Turnover";
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TurnoverScreen(newPlay: widget.newPlay,)));
                  }
                  else{
                    if (_radioChoice2 == 1){
                      widget.newPlay.endResult = "Yardage";
                    }
                    else if (_radioChoice2 == 3){
                      widget.newPlay.endResult = "TD";
                    }
                    widget.newPlay.netYardage = _currentValue;
                    //save play

                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePageScreen()));
                  }

                }
              ),
            ),),
            SizedBox(height: 20),
          ]
        ),
      ),
    );
  }
}

Widget RadioChoice(BuildContext context, String title, int which, int choice, void Function(int value) setMyRadio){
  return Column(
    children: <Widget>[
      SizedBox(
        height: 80,
        width: 80,
        child: InkWell(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border(
                top: BorderSide(width: 2.0, color: Colors.black),
                left: BorderSide(width: 2.0, color: Colors.black),
                right: BorderSide(width: 2.0, color: Colors.black),
                bottom: BorderSide(width: 2.0, color: Colors.black), 
              ),
              color: choice == which ? Colors.green : Colors.white,
            ),
            child: Opacity(opacity: 0.0, child:RadioListTile(
              activeColor: Colors.green,
              value: which,
              groupValue: choice,
              onChanged: (value) {
                setMyRadio(value);
              },
            ),),
          ),
        ),
      ),
      Text(title),
    ],
  );
}

Widget YardagePicker(BuildContext context, int _currentValue, void Function(int newValue) setMyPicker){
  return Column(
    children: <Widget> [
      Text("Net Yardage:", style: TextStyle(fontSize: 30),),
      Theme(
          data: Theme.of(context).copyWith(accentColor: _currentValue > 0 ? Colors.green: Colors.red),
          child: NumberPicker.integer(
            initialValue: _currentValue,
            minValue: -100,
            maxValue: 100,
            onChanged: (newValue) {
              setMyPicker(newValue);
            }
          )
        )
    ]
  );
}