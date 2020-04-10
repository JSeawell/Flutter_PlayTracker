import 'package:flutter/material.dart';
import '../Screens/in_game_screen.dart';
import '../Screens/turnover_screen.dart';
import '../Models/New_Play.dart';
import 'package:numberpicker/numberpicker.dart';

class PassPlayScreen extends StatefulWidget {

  DateTime contestDate;
  String opponent;
  List<dynamic> listOfPlays;
  NewPlay newPlay = NewPlay();
  
  PassPlayScreen({Key key, this.contestDate, this.opponent, this.listOfPlays, this.newPlay}) : super(key: key);

  @override
  _PassPlayScreenState createState() => _PassPlayScreenState();
}

class _PassPlayScreenState extends State<PassPlayScreen> {

  int _currentValue = 0;
  int _radioChoice = 1;
  int _radioChoice2 = 1;
  final myTextController = TextEditingController();

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
        title: Text("Pass Play"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Text("Length of Pass:", style: TextStyle(fontSize: 30),),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                RadioChoice(context, "Short/Screen", 1, _radioChoice, setMyRadio1),
                SizedBox(width: 20),
                RadioChoice(context, "Mid Range", 2, _radioChoice, setMyRadio1),
                SizedBox(width: 20),
                RadioChoice(context, "Deep", 3, _radioChoice, setMyRadio1),
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
            YardagePicker(context, widget.newPlay.yardLine, _currentValue, setMyPicker),
            SizedBox(height: 10),
            ClipRRect(borderRadius: BorderRadius.circular(10), child: SizedBox(
              height: 50, width: 200,
              child:
              RaisedButton(
                child: Text(_radioChoice2 == 2 ? "Continue" : "Add Pass", style: TextStyle(fontSize: 30, color: Colors.white),),
                color: Colors.green,
                onPressed: (){
                  if (_radioChoice == 1){
                    widget.newPlay.specificType = "Short/Screen";
                  }
                  else if (_radioChoice == 2){
                    widget.newPlay.specificType = "Mid Range";
                  }
                  else if (_radioChoice == 3){
                    widget.newPlay.specificType = "Deep";
                  }

                  if (_radioChoice2 == 2){
                    widget.newPlay.endResult = "Turnover";
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TurnoverScreen(contestDate: widget.contestDate, opponent: widget.opponent, listOfPlays: widget.listOfPlays, newPlay: widget.newPlay)));
                  }
                  else{
                    if (_radioChoice2 == 1){
                      widget.newPlay.endResult = "Yardage";
                    }
                    else if (_radioChoice2 == 3){
                      widget.newPlay.endResult = "TD";
                      widget.newPlay.points = 6;
                    }
                    widget.newPlay.netYardage = _currentValue;
                    //add play to game
                    //widget.listOfPlays.add("${widget.newPlay.formation} ${widget.newPlay.strength} ${widget.newPlay.ballPlacement} ${widget.newPlay.typeOfPlay} ${widget.newPlay.specificType} ${widget.newPlay.netYardage.toString()}");
                    widget.listOfPlays.add(widget.newPlay.toJson());

                    Navigator.push(context, MaterialPageRoute(builder: (context) => InGameScreen(contestDate: widget.contestDate, opponent: widget.opponent, listOfPlays: widget.listOfPlays)));
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

Widget YardagePicker(BuildContext context, int ydline, int _currentValue, void Function(int newValue) setMyPicker){
  return Column(
    children: <Widget> [
      Text("Net Yardage:", style: TextStyle(fontSize: 30),),
      Theme(
          data: Theme.of(context).copyWith(accentColor: _currentValue > 0 ? Colors.green: Colors.red),
          child: NumberPicker.integer(
            initialValue: _currentValue,
            minValue: ydline < 0 ? ydline : -1*(100 - ydline),
            maxValue: ydline < 0 ? 100 + ydline : ydline,
            onChanged: (newValue) {
              setMyPicker(newValue);
            }
          )
        )
    ]
  );
}