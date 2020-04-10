import 'package:flutter/material.dart';
import '../Screens/type_of_play_screen.dart';
import '../Models/New_Play.dart';

class NewPlayScreen extends StatefulWidget {

  DateTime contestDate;
  String opponent;
  List<dynamic> listOfPlays = [];
  
  int previousDown;
  int previousDist;
  int previousYardLine;
  
  NewPlayScreen({Key key, this.contestDate, this.opponent, this.listOfPlays, this.previousDown, this.previousDist, this.previousYardLine}) : super(key: key);

  @override
  _NewPlayScreenState createState() => _NewPlayScreenState();
}

class _NewPlayScreenState extends State<NewPlayScreen> {

  NewPlay newPlay = NewPlay();
  
  int _radioChoice = 8;
  int _radioChoice2 = 2;
  int _radioChoice3 = 2;
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
  void setMyRadio3(value){
    setState(() {
      _radioChoice3 = value;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Add New Play"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Text("Formation:", style: TextStyle(fontSize: 30),),
            SizedBox(height:10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                RadioChoice(context, "Power I", 1, _radioChoice, setMyRadio1),
                SizedBox(width: 20),
                RadioChoice(context, "Pistol", 2, _radioChoice, setMyRadio1),
                SizedBox(width: 20),
                RadioChoice(context, "Trips", 3, _radioChoice, setMyRadio1),
                SizedBox(width: 20),
                RadioChoice(context, "Tre", 4, _radioChoice, setMyRadio1),
              ]
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                RadioChoice(context, "Pro", 5, _radioChoice, setMyRadio1),
                SizedBox(width: 20),
                RadioChoice(context, "Dbl Tight", 6, _radioChoice, setMyRadio1),
                SizedBox(width: 20),
                RadioChoice(context, "Empty", 7, _radioChoice, setMyRadio1),
                SizedBox(width: 20),
                RadioChoice(context, "Other", 8, _radioChoice, setMyRadio1),
              ]
            ),
            SizedBox(height: 10),
            _radioChoice == 8 ? SizedBox(
              height: 40, width:200,
              child:TextField(
              controller: myTextController,
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
            SizedBox(height: 50),
            Text("Strength:", style: TextStyle(fontSize: 30),),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                RadioChoice(context, "Left", 1, _radioChoice2, setMyRadio2),
                SizedBox(width: 20),
                RadioChoice(context, "Balanced", 2, _radioChoice2, setMyRadio2),
                SizedBox(width: 20),
                RadioChoice(context, "Right", 3, _radioChoice2, setMyRadio2),
              ]
            ),
            SizedBox(height: 50),
            Text("Ball Location:", style: TextStyle(fontSize: 30),),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                RadioChoice(context, "Left Hash", 1, _radioChoice3, setMyRadio3),
                SizedBox(width: 20),
                RadioChoice(context, "Middle", 2, _radioChoice3, setMyRadio3),
                SizedBox(width: 20),
                RadioChoice(context, "Right Hash", 3, _radioChoice3, setMyRadio3),
              ]
            ),
            SizedBox(height: 50),
            ClipRRect(borderRadius: BorderRadius.circular(10), child: SizedBox(
              height: 50, width: 200,
              child:
              RaisedButton(
                child: Text("Continue", style: TextStyle(fontSize: 30, color: Colors.white),),
                color: Colors.green,
                onPressed: (){
                  
                  //FORMATION
                  if (_radioChoice == 1){
                    newPlay.formation = "Power I";
                    }
                  else if (_radioChoice == 2){
                    newPlay.formation = "Pistol";
                  }
                  else if (_radioChoice == 3){
                    newPlay.formation = "Trips";
                  }
                  else if (_radioChoice == 4){
                    newPlay.formation = "Tre";
                  }
                  else if (_radioChoice == 5){
                    newPlay.formation = "Pro";
                  }
                  else if (_radioChoice == 6){
                    newPlay.formation = "Double Tight";
                  }
                  else if (_radioChoice == 7){
                    newPlay.formation = "Empty";
                  }
                  else {
                    newPlay.formation = "${myTextController.text}";
                  }
                  
                  //STRENGTH
                  if (_radioChoice2 == 1){
                    newPlay.strength = "Left";
                  }
                  else if (_radioChoice2 == 2){
                    newPlay.strength = "Balanced";
                  }
                  else if (_radioChoice2 == 3){
                    newPlay.strength = "Right";
                  }
                  
                  //BALL PLACEMENT
                  if (_radioChoice3 == 1){
                    newPlay.ballPlacement = "on the left hash";
                  }
                  else if (_radioChoice3 == 3){
                    newPlay.ballPlacement = "on the right hash";
                  }
                  else {
                    newPlay.ballPlacement = "in the middle of the field";
                  }
                  //DOWN, DISTANCE, YARDLINE, NET-YARDAGE
                  newPlay.down = widget.previousDown;
                  newPlay.dist = widget.previousDist;
                  newPlay.yardLine = widget.previousYardLine;
                  newPlay.netYardage = 0;
                  
                  //GO TO NEXT SCREEN (TYPE OF PLAY)
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TypeOfPlayScreen(contestDate: widget.contestDate, opponent: widget.opponent, listOfPlays: widget.listOfPlays, newPlay: newPlay)));

                }
              ),
            ),),
            SizedBox(height: 60),
          ]
        ),
      ),
    );
  }
}

Widget RadioChoice(BuildContext context, String title, int which, int choice, void Function(int value) setMyRadio1){
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
                setMyRadio1(value);
              },
            ),),
          ),
        ),
      ),
      Text(title),
    ],
  );
}