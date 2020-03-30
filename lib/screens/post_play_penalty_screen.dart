import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import '../Screens/home_page_screen.dart';
import '../Models/New_Play.dart';
import '../Models/Game.dart';

class PostPenaltyScreen extends StatefulWidget {

  Game game = Game();
  NewPlay newPlay = NewPlay();
  
  PostPenaltyScreen({Key key, this.game, this.newPlay}) : super(key: key);

  @override
  _PostPenaltyScreenState createState() => _PostPenaltyScreenState();
}

class _PostPenaltyScreenState extends State<PostPenaltyScreen> {

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
        title: Text("Post-Play Penalty"),
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
                items: <String>['Choose Penalty', 'Holding', 'Block in the back', 'Clipping', 'Illegal player downfield', 'Pass Interference', 'Targeting', 'Facemask', 'Horse-Collar Tackle', 'Hands to the Face', 'Personal Foul', 'Unneccesary Roughness', 'Unsportsmanlike Conduct', 'Tripping', 'Illegal Touching', 'Ilegal Forward Pass', 'Intentional Grounding', 'Roughing the Passer', 'Roughing the Kicker', 'Running into the Kicker', 'Other']
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
                    color: Colors.green,
                    onPressed: (){
                      if (dropdownValue != "Choose Penalty"){
                        
                        widget.newPlay.penalty = "$dropdownValue";
                        widget.newPlay.netYardage = _currentValue;
                        
                        print(widget.newPlay.formation);
                        print(widget.newPlay.strength); 
                        print(widget.newPlay.ballPlacement);
                        print(widget.newPlay.typeOfPlay);
                        print(widget.newPlay.penalty);
                        print(widget.newPlay.netYardage);

                        //add play to db

                        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePageScreen()));
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