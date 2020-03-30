import 'package:flutter/material.dart';
import '../Models/New_Play.dart';
import '../Models/Game.dart';
import '../Screens/home_page_screen.dart';
import 'package:numberpicker/numberpicker.dart';

class KickPlayScreen extends StatefulWidget {

  Game game = Game();
  NewPlay newPlay = NewPlay();
  
  KickPlayScreen({Key key, this.game, this.newPlay}) : super(key: key);

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
            _radioChoice == 3 ? LengthOfFieldGoalPicker(context, _currentValue, setMyPicker)
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
                        widget.newPlay.kick = "Punt";
                        widget.newPlay.points = 0;
                      }
                      else if (_radioChoice == 2){
                        widget.newPlay.kick = "PAT";
                        if (isSwitched == false){
                          widget.newPlay.points = 1;
                        }
                        else{
                          widget.newPlay.points = 0;
                        }
                      }
                      else if (_radioChoice == 3){
                        widget.newPlay.kick = "Field Goal";
                        if (isSwitched == false){
                          widget.newPlay.points = 3;
                        }
                        else{
                          widget.newPlay.points = 0;
                        }
                      }
                      //print("Kick Added");
                      
                      //add play to db

                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePageScreen()));
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

Widget LengthOfFieldGoalPicker(BuildContext context, int _currentValue, void Function(int newValue) setMyPicker){
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
            minValue: 5,
            maxValue: 70,
            onChanged: (newValue) {
              setMyPicker(newValue);
            }
          )
        )
      ))
    ]
  );
}