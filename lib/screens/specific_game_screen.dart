import 'package:flutter/material.dart';
import '../Models/Game.dart';
import 'package:intl/intl.dart';

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

Widget ListOfPlays(BuildContext context, plays){
  return ListView.builder(
    padding: const EdgeInsets.all(5),
    itemCount: plays.length,
    itemBuilder: (BuildContext context, int index) {
      return Card(
        color: Colors.green,
        child: Center(
          child: Padding(padding: EdgeInsets.all(5), 
            child:Text(
              '${index + 1}.  ${plays[index]}',
              style: TextStyle(color: Colors.white),
            )
          )
        ),
      );
    }
  );
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