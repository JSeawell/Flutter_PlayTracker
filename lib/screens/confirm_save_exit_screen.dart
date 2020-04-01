import 'package:flutter/material.dart';
import '../Screens/home_page_screen.dart';
import '../Models/Game.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConfirmSaveExitScreen extends StatefulWidget {
  
  Game game = Game();
  
  ConfirmSaveExitScreen({Key key, this.game}) : super(key: key);
  
  @override
  _ConfirmSaveExitScreenState createState() => _ConfirmSaveExitScreenState();
}

class _ConfirmSaveExitScreenState extends State<ConfirmSaveExitScreen> {

  final formKey = GlobalKey<FormState>();

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
              Text("You have recorded ${widget.game.allPlays.length} play(s)", style: TextStyle(fontSize: 15)),
              Divider(height: 10, thickness: 5, indent: 80, endIndent: 80,),
              Text(
                'Save game & exit?',
                style: TextStyle(fontSize: 75, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              // After title spacer
              SizedBox(height: 50,),         
              FinalScoreForm(context, formKey, widget.game),
              // Between form spacer
              SizedBox(height: 20,),            
              CancelButton(context, "Cancel"),
            ],
          ),
        ),
      ),
    );
  }
}



Widget FinalScoreForm(BuildContext context, formKey, Game game){
  return Padding(
    padding: EdgeInsets.all(10),
      child: Form( 
        key: formKey,
        child: SingleChildScrollView( 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OpponentInputBox(context, game),
              Divider(height: 30, thickness: 5,),
              SaveExitButton(context, "Save & Exit", game, formKey)
            ]
          ),
        ),
      ),
  );
}

Widget OpponentInputBox(BuildContext context, Game game){
  return TextFormField(
    autofocus: true,
    style: TextStyle(fontSize: 20),
    decoration: InputDecoration(
      hintText: 'Our Score - Their Score (W/L))',
      labelText: 'Final Score', 
      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white),),
    ),
    onSaved: (value) {
      //save final score
      game.finalScore = value;
    },
    validator: (value) {
      if (value.isEmpty) {
        return 'Please enter a final score';
      }
      else {
        return null;
      }
    },
  );
}


Widget SaveExitButton(BuildContext context, String label, Game game, formKey){
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
        onPressed: () async {
          if (formKey.currentState.validate()){
            formKey.currentState.save();
            //save journal entry fields to firestore DB   
            Firestore.instance.collection('previousGames').add({
              'Date': game.date,
              'Opponent': game.opponent,
              'Final Score': game.finalScore,
              'Plays': game.allPlays
            });
            //Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePageScreen()));
          }
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