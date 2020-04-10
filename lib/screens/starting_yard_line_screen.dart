import 'package:flutter/material.dart';
import 'in_game_screen.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:intl/intl.dart';

class StartingYardLineScreen extends StatefulWidget {

  List<dynamic> listOfPlays;
  DateTime contestDate;
  String opponent;

  StartingYardLineScreen({Key key, this.contestDate, this.opponent, this.listOfPlays}) : super(key: key);

  @override
  _StartingYardLineScreenState createState() => _StartingYardLineScreenState();
}

class _StartingYardLineScreenState extends State<StartingYardLineScreen> {

  int _currentValue = -20;

  void setMyPicker(newValue){
    setState(() {
      _currentValue = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${DateFormat.MEd().format(widget.contestDate)}  |  ${widget.opponent}"),
        backgroundColor: Colors.green,
        centerTitle: true,
        
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height:20),
              YardagePicker(context, _currentValue, setMyPicker),
              SizedBox(
                width: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10), 
                  child: SizedBox(
                    height: 50, width: 200,
                    child: RaisedButton(
                      child: Text("Begin Game", style: TextStyle(fontSize: 20, color: Colors.white),),
                      color: Colors.green,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => InGameScreen(contestDate: widget.contestDate, opponent: widget.opponent, listOfPlays: widget.listOfPlays, startingYardLine: _currentValue,)));
                      },
                    ), 
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget YardagePicker(BuildContext context, int _currentValue, void Function(int newValue) setMyPicker){
  return Column(
    children: <Widget> [
      Text("Starting Yard Line:", style: TextStyle(fontSize: 30),),
      Divider(height:10, thickness: 5, indent: 30, endIndent: 30),
      Text("Negative numbers indicate your side of the field."),
      Text("(Your 20 yard line would be '-20')"),
      SizedBox(height:5),
      Text("Positive numbers indicate your opponents' side."),
      Text("(Your opponents' 40 yard line would be '40')"),
      Divider(height:10, thickness: 5, indent: 30, endIndent: 30),
      Theme(
          data: Theme.of(context).copyWith(accentColor: _currentValue > 0 ? Colors.green: Colors.red),
          child: NumberPicker.integer(
            initialValue: _currentValue,
            minValue: -49,
            maxValue: 50,
            onChanged: (newValue) {
              setMyPicker(newValue);
            }
          )
        )
    ]
  );
}