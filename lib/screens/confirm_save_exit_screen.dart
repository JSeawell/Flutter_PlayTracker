import 'package:flutter/material.dart';
import '../Screens/home_page_screen.dart';
import '../Models/Game.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConfirmSaveExitScreen extends StatelessWidget {
  
  Game game = Game();
  
  ConfirmSaveExitScreen({Key key, this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // Top spacer
              SizedBox(height: 50,),
              Text(
                'Save & Exit?',
                style: TextStyle(fontSize: 75, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              // After title spacer
              SizedBox(height: 50,),
              //               Label, width, height, textSize, radius, screen
              SaveExitButton(context,  "Yes", game),
              // Between button spacer
              SizedBox(height: 30,),
              //               Label, width, height, textSize, radius, screen
              CancelButton(context, "No, cancel"),
            ],
          ),
        ),
      ),
    );
  }
}

Widget SaveExitButton(BuildContext context, String label, Game game){
  return SizedBox(
    height: 80,
    width: 200,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: RaisedButton(
        child: Text(
          label,
          style: TextStyle(color: Colors.black, fontSize: 25),
          textAlign: TextAlign.center,
          ),
        onPressed: (){
          //save journal entry fields to firestore DB   
          Firestore.instance.collection('previousGames').add({
            'Date': game.date,
            'Opponent': game.opponent,
            'Final Score': game.finalScore,
            'Plays': game.allPlays
          });
          //Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePageScreen()));
        },
        splashColor: Colors.green,
      ),
    ),
  );
}

Widget CancelButton(BuildContext context, String label){
  return SizedBox(
    height: 80,
    width: 200,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: RaisedButton(
        child: Text(
          label,
          style: TextStyle(color: Colors.black, fontSize: 25),
          textAlign: TextAlign.center,
          ),
        onPressed: (){
          Navigator.pop(context);
        },
        splashColor: Colors.green,
      ),
    ),
  );
}