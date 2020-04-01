import 'package:flutter/material.dart';
import '../Models/New_Play.dart';
import '../Models/Game.dart';
import '../Screens/pre_play_penalty_screen.dart';
import '../Screens/post_play_penalty_screen.dart';
import '../Screens/pass_play_screen.dart';
import '../Screens/run_play_screen.dart';
import '../Screens/kick_play_screen.dart';

class TypeOfPlayScreen extends StatefulWidget {

  DateTime contestDate;
  String opponent;
  List<dynamic> listOfPlays = [];
  NewPlay newPlay = NewPlay();
  
  TypeOfPlayScreen({Key key, this.contestDate, this.opponent, this.listOfPlays, this.newPlay}) : super(key: key);

  @override
  _TypeOfPlayScreenState createState() => _TypeOfPlayScreenState();
}

class _TypeOfPlayScreenState extends State<TypeOfPlayScreen> {

  var _radioChoice = 1;

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
            Center(child:Text("Type of Play:", style: TextStyle(fontSize: 30),),),
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
            Text("Pre-Play Penalty", style: TextStyle(color: _radioChoice == 1 ? Colors.green : Colors.black),),
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
            Text("Run", style: TextStyle(color: _radioChoice == 2 ? Colors.green : Colors.black),),
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
            Text("Pass", style: TextStyle(color: _radioChoice == 3 ? Colors.green : Colors.black),),
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
                    color: _radioChoice == 4 ? Colors.green : Colors.white,
                  ),
                  child: Opacity(opacity: 0.0, child:RadioListTile(
                    activeColor: Colors.green,
                    value: 4,
                    groupValue: _radioChoice,
                    onChanged: (value) {
                      setState(() { _radioChoice = value; });
                    },
                  ),),
                ),
              ),
            ),
            Text("Kick", style: TextStyle(color: _radioChoice == 4 ? Colors.green : Colors.black),),
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
                    color: _radioChoice == 5 ? Colors.green : Colors.white,
                  ),
                  child: Opacity(opacity: 0.0, child:RadioListTile(
                    activeColor: Colors.green,
                    value: 5,
                    groupValue: _radioChoice,
                    onChanged: (value) {
                      setState(() { _radioChoice = value; });
                    },
                  ),),
                ),
              ),
            ),
            Text("Post-Play Penalty", style: TextStyle(color: _radioChoice == 5 ? Colors.green : Colors.black),),
            SizedBox(height: 10,),
            ClipRRect(
              borderRadius: BorderRadius.circular(10), 
              child: SizedBox(
                height: 50, width: 200,
                child: RaisedButton(
                  child: Text("Continue", style: TextStyle(fontSize: 30, color: Colors.white),),
                    color: Colors.green,
                    onPressed: (){
                    if (_radioChoice == 1){
                      widget.newPlay.typeOfPlay = "Pre-Play Penalty";
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PrePenaltyScreen(contestDate: widget.contestDate, opponent: widget.opponent, listOfPlays: widget.listOfPlays, newPlay: widget.newPlay)));
                    }
                    else if (_radioChoice == 2){
                      widget.newPlay.typeOfPlay = "Run";
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RunPlayScreen(contestDate: widget.contestDate, opponent: widget.opponent, listOfPlays: widget.listOfPlays, newPlay: widget.newPlay)));
                    }
                    else if (_radioChoice == 3){
                      widget.newPlay.typeOfPlay = "Pass";
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PassPlayScreen(contestDate: widget.contestDate, opponent: widget.opponent, listOfPlays: widget.listOfPlays, newPlay: widget.newPlay)));
                    }
                    else if (_radioChoice == 4){
                      widget.newPlay.typeOfPlay = "Kick";
                      Navigator.push(context, MaterialPageRoute(builder: (context) => KickPlayScreen(contestDate: widget.contestDate, opponent: widget.opponent, listOfPlays: widget.listOfPlays, newPlay: widget.newPlay)));
                    }
                    else{
                      widget.newPlay.typeOfPlay = "Pre-Play Penalty";
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PostPenaltyScreen(contestDate: widget.contestDate, opponent: widget.opponent, listOfPlays: widget.listOfPlays, newPlay: widget.newPlay)));
                    }
                  }
                ),
              ),
            ),    
          ]
        ),
      ),
    );
  }
}

