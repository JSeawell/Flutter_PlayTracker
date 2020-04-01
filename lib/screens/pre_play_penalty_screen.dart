import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:play_tracker/Models/New_Play.dart';
import '../Models/Game.dart';
import 'in_game_screen.dart';

class PrePenaltyScreen extends StatefulWidget {

  DateTime contestDate;
  String opponent;
  List<dynamic> listOfPlays  = [];
  NewPlay newPlay = NewPlay();
  
  PrePenaltyScreen({Key key, this.contestDate, this.opponent, this.listOfPlays, this.newPlay}) : super(key: key);

  @override
  _PrePenaltyScreenState createState() => _PrePenaltyScreenState();
}

class _PrePenaltyScreenState extends State<PrePenaltyScreen> {

  String dropdownValue = "Choose Penalty";
  bool isSwitched = false;
  int _currentValue = -5;
  final _myTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screen_width = MediaQuery.of(context).size.width;
    final screen_height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Pre-Play Penalty"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter, 
          child: Column(
            children: <Widget> [
              SizedBox(height: screen_height*0.05),
              isSwitched == false ? Text("Against Us", style: TextStyle(fontSize: 20, color: Colors.red)) : Text("Against Opponent", style: TextStyle(fontSize: 20, color: Colors.green),),
              Center(
                child: Switch(
                  value: isSwitched,
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: Colors.red,
                  activeTrackColor: Colors.green,
                  activeColor: Colors.white,
                  onChanged: (value) {
                    isSwitched == false ? _currentValue = 5 : _currentValue = -5;
                    setState(() {
                      isSwitched = value;
                    });
                  },
                ),
              ),
              DropdownButton<String>(
                value: dropdownValue,
                icon: Icon(Icons.arrow_drop_down_circle),
                iconSize: 30,
                elevation: 16,
                style: TextStyle(
                  color: Colors.black,
                ),
                underline: Container(
                  height: 2,
                  color: Colors.green,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                  });
                },
                items: <String>['Choose Penalty', 'Encroachment', 'Offsides', 'Neutral Zone Infraction', 'False Start', 'Illegal Formation', 'Illegal Motion/Shift', 'Delay of Game', 'Illegal Substitution', 'Too many players on/in the field/huddle', 'Other']
                  .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Container(
                        child: Center(child:Text(
                          value,
                          style: value == 'Choose Penalty' ? TextStyle(fontSize: 30, color: Colors.green, fontWeight: FontWeight.bold) : TextStyle(fontSize: 20, color: Colors.black)
                        ),),
                      ),
                    );
                  })
                  .toList(),
              ),
              SizedBox(height: screen_height*0.025),
              dropdownValue == "Other" ? SizedBox(
                height: screen_height*0.1, width:screen_width*0.5,
                child:TextField(
                controller: _myTextController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                  hintText: 'Enter other here',),
                ),
              ) : SizedBox(height: 0, width: 0),
              SizedBox(height: screen_height*0.05),
              Text("Net Yardage:", style: TextStyle(fontSize: 20),),
              Theme(
                data: Theme.of(context).copyWith(
                  accentColor: _currentValue < 0 ? Colors.red: Colors.green,
                ),
                child: 
                  isSwitched == false ? 
                    NumberPicker.integer(
                    initialValue: _currentValue,
                    minValue: -100,
                    maxValue: -1,
                    onChanged: (newValue) =>
                        setState(() => _currentValue = newValue)
                  ) : 
                  NumberPicker.integer(
                  initialValue: _currentValue,
                  minValue: 1,
                  maxValue: 100,
                  onChanged: (newValue) =>
                      setState(() => _currentValue = newValue)
                ),
              ),
              SizedBox(height: screen_height*0.1),
              ClipRRect(borderRadius: BorderRadius.circular(10), 
                child: SizedBox(
                  height: screen_height*0.10, width: screen_width*0.50,
                  child: dropdownValue != "Choose Penalty" ?
                  RaisedButton(
                    child: Text("Add Penalty", style: TextStyle(fontSize: 20, color: Colors.white),),
                    color: dropdownValue != "Choose Penalty" ? Colors.green : Colors.white,
                    onPressed: (){
                      if (dropdownValue != "Choose Penalty"){
                        
                        widget.newPlay.specificType = "$dropdownValue";
                        widget.newPlay.netYardage = _currentValue;
                        
                        //add play to game
                        //widget.listOfPlays.add("${widget.newPlay.formation} ${widget.newPlay.strength} ${widget.newPlay.ballPlacement} ${widget.newPlay.typeOfPlay} ${widget.newPlay.penalty} ${widget.newPlay.netYardage.toString()}");

                        widget.listOfPlays.add(widget.newPlay.toJson());

                        Navigator.push(context, MaterialPageRoute(builder: (context) => InGameScreen(contestDate: widget.contestDate, opponent: widget.opponent, listOfPlays: widget.listOfPlays)));
                      }
                    }
                  ) : Center(child: Text("Please choose a penalty", style: TextStyle(fontSize: 15, color: Colors.red)),),
                ),
              ),
              SizedBox(height: screen_height*0.1),
            ],
          ), 
        ),
      ),
    );
  }
}
