import 'package:flutter/material.dart';
import '../Screens/confirm_save_exit_screen.dart';
import '../Screens/new_play_screen.dart';
import '../Models/Game.dart';
import 'package:intl/intl.dart';

class InGameScreen extends StatefulWidget {

  List<dynamic> listOfPlays = [];
  Game game = Game();
  
  InGameScreen({Key key, this.game}) : super(key: key);

  @override
  _InGameScreenState createState() => _InGameScreenState();
}

class _InGameScreenState extends State<InGameScreen> {

  String currentDownAndDist;
  String previousPlay;
  
  initState(){
    super.initState();
    currentDownAndDist = "1st & 10";
    previousPlay = "Fake 23 Blast";
  }

  @override
  Widget build(BuildContext context) {
    widget.game.allPlays = widget.listOfPlays;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("${DateFormat.MEd().format(widget.game.date)}  |  ${widget.game.opponent}"),
          backgroundColor: Colors.green,
          centerTitle: true,
          
        ),
        drawer: MyDrawer(context, widget.game),
        body: TabBarView(
          children: <Widget>[
            CurrentSituation(context, currentDownAndDist, previousPlay),
            Text("World"),
            Text("Jake")
          ],
        ),
        bottomSheet: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            FloatingActionButton(
              child: Icon(Icons.add),
              backgroundColor: Colors.green,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => NewPlayScreen(game: widget.game)));
              },
            ),
          ]
        ),
        bottomNavigationBar: BottomTabBarOfThree(context),
      ),
    );
  }
}

Widget BottomTabBarOfThree(BuildContext context){
  return TabBar(
    unselectedLabelColor: Colors.grey,
    labelColor: Colors.green,
    tabs: [
      Tab(
        text: "Current",
        icon: Icon(Icons.description),
      ),
      Tab(
        text: "All Plays",
        icon: Icon(Icons.list),
      ),
      Tab(
        text: "Analytics",
        icon: Icon(Icons.scatter_plot),
      ),
    ],
  );
}

Widget MyDrawer(BuildContext context, Game game){
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        SizedBox(height: 25),
        MyDrawerHeader(context),
        MenuTileWidget(context, Icons.save, " Save Game & Exit ", game)
      ],
    ),
  );
}
Widget MyDrawerHeader(BuildContext context){
  return SizedBox(
      height: 55,
      child: Container(
        padding: EdgeInsets.all(10),
        color: Colors.green,
        child: Text(
          'Menu', 
          style: TextStyle(color: Colors.white, fontSize: 30,), 
          textAlign: TextAlign.center,
        ),
      ),
    );
}

Widget MenuTileWidget(BuildContext context, iconName, name, Game game){
  return ListTile(
    leading: Icon(iconName),
    title: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 30,
          color: Colors.green,
          child: FittedBox( 
            child: Text(name, style: TextStyle(color: Colors.white, fontSize: 20),),
          ),
        ),
    ),
    onTap: () {
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => ConfirmSaveExitScreen(game: game)));
    },
  );
}

Widget CurrentSituation(BuildContext context, String currentDownAndDist, String previousPlay){
  return Scaffold(
    body: Column(
      children: <Widget> [
        SizedBox(
          height: 20,
        ),
        DownAndDistanceBox(context, currentDownAndDist),
        SizedBox(
          height: 20,
        ),
        PreviousPlayBox(context, previousPlay)
      ]
    ),
  );
}

Widget DownAndDistanceBox(BuildContext context, String currentDownAndDist){
  return Center(
    child: ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child:SizedBox(
        height: 200,
        width: 350,
        child: Container(
          color: Color.fromRGBO(217, 217, 217, 100),
          child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10),
                  Text(
                    "Current Down and Distance:",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  SizedBox(height:60),
                  Text(
                    currentDownAndDist,
                    style: TextStyle(color: Colors.green, fontSize: 75),
                  )
                ]
              ),
            ),
        ),
      ),
    ),
  );
}

Widget PreviousPlayBox(BuildContext context, String previousPlay){
  return Center(
    child: ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: SizedBox(
        height: 150,
        width: 350,
        child: Container(
          color: Color.fromRGBO(217, 217, 217, 100),
          child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10),
                  Text(
                    "Previous Play:",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  SizedBox(height:20),
                  Text(
                    previousPlay,
                    style: TextStyle(color: Colors.green, fontSize: 30),
                  )
                ]
              ),
            ),
        ),
      ),
    ),
  );
}