import 'package:flutter/material.dart';
import 'starting_yard_line_screen.dart';
import 'package:flutter_datetime_formfield/flutter_datetime_formfield.dart';
import '../Models/Game.dart';

class NewGameScreen extends StatelessWidget {
  
  NewGameScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("New Game"),
          backgroundColor: Colors.green,
          centerTitle: true,
        ),
        body: NewGameForm(),
      );
  }
}

class NewGameForm extends StatefulWidget {
  
  NewGameForm();
  
  @override
  _NewGameFormState createState() => _NewGameFormState();
}

class _NewGameFormState extends State<NewGameForm> {

  Game newGame;
  final formKey = GlobalKey<FormState>();

  initState(){
    super.initState();
    newGame = Game(allPlays: []);
  }

  DateTime getDate(){
    return newGame.date;
  }

  String getOpponent(){
    return newGame.opponent;
  }

  @override
  Widget build(BuildContext context) {
    return GameForm(context, formKey, newGame, getDate, getOpponent);
  }
}

Widget GameForm(BuildContext context, formKey, Game newGame, DateTime Function() getDate, String Function() getOpponent){
  return Padding(
    padding: EdgeInsets.all(10),
      child: Form( 
        key: formKey,
        child: SingleChildScrollView( 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DatePicker(context, newGame),
              SizedBox(height: 10),
              OpponentInputBox(context, newGame),
              SizedBox(height: 20),
              SaveEntryButton(context, formKey, getDate, getOpponent)
            ]
          ),
        ),
      ),
  );
}

Widget OpponentInputBox(BuildContext context, Game newGame){
  return TextFormField(
    autofocus: true,
    style: TextStyle(fontSize: 20),
    decoration: InputDecoration(
      hintText: 'Who did you play against?',
      labelText: 'Opponent', 
      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white),),
    ),
    onSaved: (value) {
      //save opponent
      newGame.opponent = value;
    },
    validator: (value) {
      if (value.isEmpty) {
        return 'Please enter an opponent';
      }
      else {
        return null;
      }
    },
  );
}

Widget DatePicker(BuildContext context, Game newGame){
  return Column(
        children: [
          SizedBox(
            height: 70,
            child: DateTimeFormField(
              firstDate: DateTime(2020),
              lastDate: DateTime(2021),
              initialValue: DateTime.now(),
              label: "Date of Contest",
              validator: (DateTime dateTime) {
                if (dateTime == null) {
                  return "Please add the date of the contest";
                }
                return null;
              },
              onSaved: (DateTime dateTime) {
                //save date
                newGame.setDate(dateTime);
              }
            ),
          ),
        ],
      );
}

Widget SaveEntryButton(BuildContext context, formKey, DateTime Function() getDate, String Function() getOpponent){
  return SizedBox(
    width: 200,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10), 
      child: SizedBox(
        height: 50, width: 200,
        child: RaisedButton(
          child: Text("Add New Game", style: TextStyle(fontSize: 20, color: Colors.white),),
          color: Colors.green,
          onPressed: () async {
            if (formKey.currentState.validate()){
              formKey.currentState.save();
              DateTime contestDate = await getDate();
              String opponent = await getOpponent();
              List<dynamic> listOfPlays = [];
              Navigator.push(context, MaterialPageRoute(builder: (context) => StartingYardLineScreen(contestDate: contestDate, opponent: opponent, listOfPlays: listOfPlays)));
            }
          },
        ), 
      ),
    )
  );
}