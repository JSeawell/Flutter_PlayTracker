import 'package:flutter/material.dart';
import '../Screens/in_game_screen.dart';
import '../Models/New_Play.dart';
import 'package:numberpicker/numberpicker.dart';

class TurnoverScreen extends StatefulWidget {

  DateTime contestDate;
  String opponent;
  List<dynamic> listOfPlays;
  NewPlay newPlay = NewPlay();

  TurnoverScreen({Key key, this.contestDate, this.opponent, this.listOfPlays, this.newPlay}) : super(key: key);

  @override
  _TurnoverScreenState createState() => _TurnoverScreenState();
}

class _TurnoverScreenState extends State<TurnoverScreen> {

  var _radioChoice = 1;
  int _currentValue = 10;

  void setMyPicker(newValue){
    setState(() {
      _currentValue = newValue;
    });
  }

  void setMyRadio(value){
    setState(() {
      _radioChoice = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Turnover"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Center(child:Text("Type of Turnover:", style: TextStyle(fontSize: 30),),),
            SizedBox(height:10),
            RadioChoice(context, "Interception", 1, _radioChoice, setMyRadio),
            SizedBox(height: 10,),
            RadioChoice(context, "Fumble", 2, _radioChoice, setMyRadio),
            SizedBox(height: 10,),
            RadioChoice(context, "Turnover on Downs", 3, _radioChoice, setMyRadio),
            SizedBox(height: 20,),
            _radioChoice == 3 ?
            YardagePicker(context, widget.newPlay.yardLine, _currentValue, setMyPicker)
            : SizedBox(height: 150), 
            SizedBox(height: 20,),
            ClipRRect(
              borderRadius: BorderRadius.circular(10), 
              child: SizedBox(
                height: 50, width: 200,
                child: RaisedButton(
                  child: Text("Add Play", style: TextStyle(fontSize: 30, color: Colors.white),),
                  color: Colors.green,
                  onPressed: (){
                    
                    if (_radioChoice == 1){
                      widget.newPlay.typeOfTurnover = "Interception";
                    }
                    else if (_radioChoice == 2){
                      widget.newPlay.typeOfTurnover = "Fumble";
                    }
                    else{
                      widget.newPlay.typeOfTurnover = "Tunover on downs";
                      widget.newPlay.netYardage = _currentValue;
                    }
                    
                    //add play to game
                    //widget.listOfPlays.add("${widget.newPlay.formation} ${widget.newPlay.strength} ${widget.newPlay.ballPlacement} ${widget.newPlay.typeOfPlay} ${widget.newPlay.specificType} ${widget.newPlay.netYardage.toString()}");
                    widget.listOfPlays.add(widget.newPlay.toJson());

                    Navigator.push(context, MaterialPageRoute(builder: (context) => InGameScreen(contestDate: widget.contestDate, opponent: widget.opponent, listOfPlays: widget.listOfPlays)));
                  }
                ),
              ),
            ),
            SizedBox(height: 50,),    
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
        height: 60,
        width: 300,
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
      Text(title, style: TextStyle(fontSize: 20, color: choice == which ? Colors.green : Colors.black),),
    ],
  );
}

Widget YardagePicker(BuildContext context, int ydline, int _currentValue, void Function(int newValue) setMyPicker){
  return Column(
    children: <Widget> [
      Text("Net Yardage:", style: TextStyle(fontSize: 30),),
      Theme(
          data: Theme.of(context).copyWith(accentColor: _currentValue > 0 ? Colors.green : Colors.red),
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