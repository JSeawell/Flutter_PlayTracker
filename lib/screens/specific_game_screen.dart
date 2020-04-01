import 'package:flutter/material.dart';
import '../Models/Game.dart';
import 'package:intl/intl.dart';
import '../Screens/in_game_screen.dart';

class SpecificGameScreen extends StatefulWidget {
  
  final Game game;

  SpecificGameScreen({Key key, this.game}) : super(key: key);
  
  @override
  _SpecificGameScreenState createState() => _SpecificGameScreenState();
}

class _SpecificGameScreenState extends State<SpecificGameScreen> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController( 
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "${DateFormat.MEd().format(widget.game.date)}  |  vs. ${widget.game.opponent}", 
            style: TextStyle(
              color: Colors.white, 
            ),
          ), 
          backgroundColor: Colors.green,
          centerTitle: true,
        ),
        body: TabBarView(
          children: <Widget>[
            ListOfPlays(context, widget.game.allPlays),
            GameAnalytics(context)
          ],
        ),
        bottomNavigationBar: 
          BottomTabBar(context)
      ),
      length: 2,
    );
  }
}

Widget ListOfPlays(BuildContext context, List<dynamic> plays){
  if (plays.length < 1){
    return Center(child: Text("No recorded plays", style: TextStyle(fontSize: 30)));
  }
  else{
    plays = plays.reversed.toList();
    return ListView.builder(
      padding: const EdgeInsets.all(5),
      itemCount: plays.length,
      itemBuilder: (BuildContext context, int index) {
        return PlayListItem(context, plays[index], plays.length - index);
      }
    );
  }
}

Widget GameAnalytics(BuildContext context){
  return Center(
    child: Text(
      "Analytics"
    ),
  );
}

Widget BottomTabBar(BuildContext context){
  return TabBar(
    unselectedLabelColor: Colors.grey,
    labelColor: Colors.green,
    tabs: [
      Tab(
        text: "Plays",
        icon: Icon(Icons.list),
      ),
      Tab(
        text: "Analytics",
        icon: Icon(Icons.scatter_plot),
      ),
    ],
  );
}