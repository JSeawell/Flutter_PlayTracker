import 'package:flutter/material.dart';
import '../Models/New_Play.dart';
import '../Screens/in_game_screen.dart';
import 'package:numberpicker/numberpicker.dart';

class KickPlayScreen extends StatefulWidget {

  DateTime contestDate;
  String opponent;
  List<dynamic> listOfPlays;
  NewPlay newPlay = NewPlay();
  
  KickPlayScreen({Key key, this.contestDate, this.opponent, this.listOfPlays, this.newPlay}) : super(key: key);

  @override
  _KickPlayScreenState createState() => _KickPlayScreenState();
}

class _KickPlayScreenState extends State<KickPlayScreen> {

  var _radioChoice = 1;
  int _currentValue = 10;
  bool isSwitched = false;

  void setMySwitch(value){
    setState(() {
      isSwitched = value;
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
        title: Text("Kick"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Center(child:Text("Type of Kick:", style: TextStyle(fontSize: 30),),),
            SizedBox(height:10),
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
                    color: _radioChoice == 1 ? Colors.green : Colors.white,
                  ),
                  child: Opacity(opacity: 0.0, child:RadioListTile(
                    activeColor: Colors.green,
                    value: 1,
                    groupValue: _radioChoice,
                    onChanged: (value) {
                      setState(() { _radioChoice = value; });
                    },
                  ),),
                ),
              ),
            ),
            Text("Punt", style: TextStyle(fontSize: 20, color: _radioChoice == 1 ? Colors.green : Colors.black),),
            SizedBox(height: 20,),
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
                    color: _radioChoice == 2 ? Colors.green : Colors.white,
                  ),
                  child: Opacity(opacity: 0.0, child:RadioListTile(
                    activeColor: Colors.green,
                    value: 2,
                    groupValue: _radioChoice,
                    onChanged: (value) {
                      setState(() { _radioChoice = value; });
                    },
                  ),),
                ),
              ),
            ),
            Text("PAT", style: TextStyle(fontSize: 20, color: _radioChoice == 2 ? Colors.green : Colors.black),),
            SizedBox(height: 10,),
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
                    color: _radioChoice == 3 ? Colors.green : Colors.white,
                  ),
                  child: Opacity(opacity: 0.0, child:RadioListTile(
                    activeColor: Colors.green,
                    value: 3,
                    groupValue: _radioChoice,
                    onChanged: (value) {
                      setState(() { _radioChoice = value; });
                    },
                  ),),
                ),
              ),
            ),
            Text("Field Goal", style: TextStyle(fontSize: 20, color: _radioChoice == 3 ? Colors.green : Colors.black),),
            SizedBox(height: 10,),
            _radioChoice == 2 || _radioChoice == 3 ?
            MadeOrMissedSwitch(context, isSwitched, setMySwitch) 
            : SizedBox(height: 0),
            SizedBox(height: 20),
            _radioChoice == 3 ? LengthOfFieldGoalPicker(context, widget.newPlay.yardLine, _currentValue, setMyPicker)
            : SizedBox(height: 0),
            SizedBox(height: 50,),
            ClipRRect(
              borderRadius: BorderRadius.circular(10), 
              child: SizedBox(
                height: 50, width: 200,
                child: RaisedButton(
                  child: Text("Add Kick", style: TextStyle(fontSize: 30, color: Colors.white),),
                    color: Colors.green,
                    onPressed: (){
                      if (_radioChoice == 1){
                        widget.newPlay.specificType = "Punt";
                        widget.newPlay.points = 0;
                      }
                      else if (_radioChoice == 2){
                        if (isSwitched == false){
                          widget.newPlay.specificType = "PAT (made)";
                          widget.newPlay.points = 1;
                        }
                        else{
                          widget.newPlay.specificType = "PAT (missed)";
                          widget.newPlay.points = 0;
                        }
                      }
                      else if (_radioChoice == 3){
                        if (isSwitched == false){
                          widget.newPlay.specificType = "Field Goal (made)";
                          widget.newPlay.points = 3;
                        }
                        else{
                          widget.newPlay.specificType = "Field Goal (missed)";
                          widget.newPlay.points = 0;
                        }
                        widget.newPlay.netYardage = _currentValue;
                      }
                      
                      //add play to game
                      //widget.listOfPlays.add("${widget.newPlay.typeOfPlay} ${widget.newPlay.netYardage.toString()}");
                      widget.listOfPlays.add(widget.newPlay.toJson());

                      Navigator.push(context, MaterialPageRoute(builder: (context) => InGameScreen(contestDate: widget.contestDate, opponent: widget.opponent, listOfPlays: widget.listOfPlays)));
                  }
                ),
              ),
            ),
            SizedBox(height: 10,),    
          ]
        ),
      ),
    );
  }
}

Widget MadeOrMissedSwitch(BuildContext context, bool isSwitched, void Function(bool value) setMySwitch){
  return Column(
    children: <Widget> [
      Center(
        child: Switch(
          value: isSwitched,
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: Colors.green,
          activeTrackColor: Colors.red,
          activeColor: Colors.white,
          onChanged: (value) {
            setMySwitch(value);
          },
        ),
      ),
      isSwitched == false ? Text("Made", style: TextStyle(color: Colors.green),) : Text("Missed", style: TextStyle(color: Colors.red),)
    ]
  );
}

Widget LengthOfFieldGoalPicker(BuildContext context, int ydline, int _currentValue, void Function(int newValue) setMyPicker){
  return Column(
    children: <Widget> [
      Text("Distance:", style: TextStyle(fontSize: 30),),
      ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child:Container(
        color: Colors.grey,
        child: Theme(
          data: Theme.of(context).copyWith(accentColor: Colors.white),
          child: NumberPicker.integer(
            initialValue: _currentValue,
            minValue: ydline < 0 ? ydline : -1*(100 - ydline),
            maxValue: ydline < 0 ? 100 + ydline : ydline,
            onChanged: (newValue) {
              setMyPicker(newValue);
            }
          )
        )
      ))
    ]
  );
}