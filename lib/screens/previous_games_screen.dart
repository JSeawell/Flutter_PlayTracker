import 'package:flutter/material.dart';
import '../Models/Game.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../Screens/specific_game_screen.dart';

class PreviousGamesScreen extends StatefulWidget {
  PreviousGamesScreen({Key key}) : super(key: key);
  
  @override
  _PreviousGamesScreenState createState() => _PreviousGamesScreenState();
}

class _PreviousGamesScreenState extends State<PreviousGamesScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Previous Games"),
        centerTitle: true,
      ),
      body: FirebasePostStream(context)
    );
  }
}

//WIDGETS:

  Widget _buildListItem(BuildContext context, DocumentSnapshot document){
    final newPreviousGame = Game(date: document['Date'].toDate(), opponent: document['Opponent'], finalScore: document['Final Score'], allPlays: document['Plays']);
    return Semantics(
      label: "Previous Game",
      child: ListTile(
        title: Card( 
          color: Colors.green,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Semantics(
                    label: "Date of Game",
                    child: Text(
                      "${DateFormat.MMMMEEEEd().format(newPreviousGame.date)}",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text("|"),
                  SizedBox(width: 10),
                  Semantics(
                    label: "Opponent",
                    child: Text(
                      "${newPreviousGame.opponent}",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text("|"),
                  SizedBox(width: 10),
                  Semantics(
                    label: "Final Score",
                    child: Text(
                      "${newPreviousGame.finalScore}",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => SpecificGameScreen(game: newPreviousGame)));
        },
      ),
    );
  }

  Widget FirebasePostStream(BuildContext context){
    return StreamBuilder(
      stream: Firestore.instance.collection('previousGames').orderBy('Date', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data.documents.length < 1){
          return Center(child: CircularProgressIndicator());
        }
        else{
          return ListView.builder(
            itemExtent: 50.0,
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              return _buildListItem(context, snapshot.data.documents[index]);
            }
          );
        }
      },
    );
  }

