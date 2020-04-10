import 'package:flutter/material.dart';
import 'package:play_tracker/Models/New_Play.dart';
import '../Screens/confirm_save_exit_screen.dart';
import '../Screens/new_play_screen.dart';
import '../Models/Game.dart';
import 'package:intl/intl.dart';

class InGameScreen extends StatefulWidget {

  List<dynamic> listOfPlays;
  DateTime contestDate;
  String opponent;
  String finalScore;
  int startingYardLine;
  
  InGameScreen({Key key, this.contestDate, this.opponent, this.listOfPlays, this.startingYardLine}) : super(key: key);

  @override
  _InGameScreenState createState() => _InGameScreenState();
}

class _InGameScreenState extends State<InGameScreen> {

  int prevDown;
  int prevDist;
  int prevYardLine;

  int currentYardLine;
  int currentDown;
  int currentDist;

  NewPlay previousPlay;

  
  initState(){
    super.initState();
    prevYardLine = -20;
    if (widget.listOfPlays.length > 0){
      previousPlay = NewPlay.fromJson(widget.listOfPlays[widget.listOfPlays.length - 1]);
    }

    if (previousPlay != null){
      //calculate yard line
      if (previousPlay.yardLine < 0){
        if (previousPlay.yardLine - previousPlay.netYardage > -50){
          currentYardLine = previousPlay.yardLine - previousPlay.netYardage;
        }
        else{
          currentYardLine = 100 - previousPlay.netYardage + previousPlay.yardLine;
        }
      }
      else{
        currentYardLine = previousPlay.yardLine - previousPlay.netYardage;
      }
      //calculate dist
      if (previousPlay.netYardage < previousPlay.dist){
        if (previousPlay.down == 4){
          currentDist = 10;
        }
        else{
          currentDist = previousPlay.dist - previousPlay.netYardage;
        }
      }
      else{
        currentDist = 10;
      }
      //calculate down
      
      //if accepted penalty, replay down
      if (previousPlay.typeOfPlay == 'Pre-Play Penalty' || previousPlay.typeOfPlay == 'Post-Play Penalty'){
        //if loss of down
        if (previousPlay.specificType == 'Intentional Grounding'){
          currentDown = previousPlay.down + 1;
        }
        //if no loss of down
        else{
          currentDown = previousPlay.down;
        }
      }
      //if kick, end of drive
      else if (previousPlay.typeOfPlay == 'Kick'){
        currentDown = 1;
      }
      //if not 4th down, increment down
      else if (previousPlay.down < 4){
        print(previousPlay.down);
        if (previousPlay.netYardage < previousPlay.dist){
          currentDown = previousPlay.down + 1;
        }
        else{
          currentDown = 1;
        }
      }
      //if 4th down, increment to 1st down
      else{
        currentDown = 1;
      }
    }
    //if there is no previous play
    else{
      currentDown = 1;
      currentDist = 10;
      currentYardLine = widget.startingYardLine;
    }

  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("${DateFormat.MEd().format(widget.contestDate)}  |  ${widget.opponent}"),
          backgroundColor: Colors.green,
          centerTitle: true,
          
        ),
        drawer: MyDrawer(context, widget.contestDate, widget.opponent, widget.listOfPlays, widget.finalScore),
        body: TabBarView(
          children: <Widget>[
            CurrentSituation(context, currentDown, currentDist, currentYardLine, previousPlay),
            AllPlaysListView(context, widget.listOfPlays),
            Center(child: Text("Analytics"))
          ],
        ),
        bottomSheet: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            FloatingActionButton(
              child: Icon(Icons.add),
              backgroundColor: Colors.green,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => NewPlayScreen(contestDate: widget.contestDate, opponent: widget.opponent, listOfPlays: widget.listOfPlays, previousDown: currentDown, previousDist: currentDist, previousYardLine: currentYardLine)));
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

Widget MyDrawer(BuildContext context, DateTime contestDate, String opponent, List<dynamic> listOfPlays, String finalScore){
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        SizedBox(height: 25),
        MyDrawerHeader(context),
        MenuTileWidget(context, Icons.save, " Save Game & Exit ", contestDate, opponent, listOfPlays, finalScore)
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

Widget MenuTileWidget(BuildContext context, iconName, name, DateTime contestDate, String opponent, List<dynamic> listOfPlays, String finalScore){
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
      Game gameToSave = Game(date: contestDate, opponent: opponent, allPlays: listOfPlays, finalScore: finalScore);
      Navigator.push(context, MaterialPageRoute(builder: (context) => ConfirmSaveExitScreen(game: gameToSave)));
    },
  );
}

Widget CurrentSituation(BuildContext context, int currentDown, int currentDist, int currentYardLine, NewPlay previousPlay){
  return Scaffold(
    body: Column(
      children: <Widget> [
        SizedBox(
          height: 20,
        ),
        DownAndDistanceBox(context, currentDown, currentDist, currentYardLine, previousPlay),
        SizedBox(
          height: 20,
        ),
        previousPlay != null ? PreviousPlayBox(context, previousPlay) : SizedBox(height:0),
      ]
    ),
  );
}

Widget DownAndDistanceBox(BuildContext context, int currentDown, int currentDist, int currentYardLine, NewPlay previousPlay){
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
                  Divider(height:30, thickness: 5, indent: 60, endIndent: 60,),
                  currentDown == 1 ? Text("1st & $currentDist", style: TextStyle(color: Colors.green, fontSize: 75),) 
                  : currentDown == 2 ? Text("2nd & $currentDist", style: TextStyle(color: Colors.green, fontSize: 75),) 
                  : currentDown == 3 ? Text("3rd & $currentDist", style: TextStyle(color: Colors.green, fontSize: 75),) 
                  : Text("4th & $currentDist", style: TextStyle(color: Colors.green, fontSize: 75),),
                  currentYardLine < 0 ? Text("on our own ${-1*currentYardLine} yard line", style: TextStyle(fontSize: 20),) :
                  Text("on opp $currentYardLine yard line", style: TextStyle(fontSize: 20),),
                ]
              ),
            ),
        ),
      ),
    ),
  );
}

Widget PreviousPlayBox(BuildContext context, NewPlay previousPlay){
  return Center(
    child: ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: SizedBox(
        height: 200,
        width: 350,
        child: Container(
          color: Color.fromRGBO(217, 217, 217, 100),
          child: Align(
              alignment: Alignment.topCenter,
              child: prevPlay(context, previousPlay)
            ),
        ),
      ),
    ),
  );
}

Widget prevPlay(BuildContext context, NewPlay play){
  if (play == null){
    return Text(
                    "Previous Play:",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  );
  }
  return Column(
                children: <Widget>[
                  SizedBox(height: 10),
                  Text(
                    "Previous Play:",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  Divider(height:10, thickness: 5, indent: 60, endIndent: 60,),
                  play.typeOfPlay == "Run" || play.typeOfPlay == "Pass" ? 
                  Text(
                    "${play.formation} ${play.strength}",
                    style: TextStyle(color: Colors.green, fontSize: 20),
                  ) : SizedBox(height: 0),
                  play.typeOfPlay == "Run" || play.typeOfPlay == "Pass" ? 
                  Text(
                    "Ball ${play.ballPlacement}",
                    style: TextStyle(color: Colors.green, fontSize: 20),
                  ) : SizedBox(height: 0),
                  play.typeOfPlay == "Run" || play.typeOfPlay == "Pass" ?
                  Text(
                    "${play.specificType} ${play.typeOfPlay}",
                    style: TextStyle(color: Colors.green, fontSize: 20),
                  ):
                  play.typeOfPlay == "Kick" ? 
                  Text(
                    "${play.specificType}",
                    style: TextStyle(color: Colors.green, fontSize: 20),
                  ):
                  Text(
                    "${play.typeOfPlay}: ${play.specificType}",
                    style: TextStyle(color: Colors.green, fontSize: 20),
                  ),
                  play.netYardage != null ?
                  Text(
                    "Net Yardage: ${play.netYardage}",
                    style: TextStyle(color: Colors.green, fontSize: 20),
                  ) :
                  SizedBox(height: 0),
                  play.typeOfTurnover != null ?
                  Text(
                    "Turnover: ${play.typeOfTurnover}",
                    style: TextStyle(color: Colors.green, fontSize: 20),
                  ) :
                  SizedBox(height: 0),
                  play.points != null ?
                  Text(
                    "Points Scored: ${play.points}",
                    style: TextStyle(color: Colors.green, fontSize: 20),
                  ) :
                  SizedBox(height: 0)
                ]
              );
}

Widget PlayListItem(BuildContext context, play, int index){
  NewPlay _play = NewPlay.fromJson(play);
  return ListTile(
        leading: Text("$index", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        title: Card(
          child: Padding(
            padding: EdgeInsets.all(10),
            child:Column(
              children: <Widget> [
                _play.formation != null && _play.strength != null ? Text("Formation: ${_play.formation} ${_play.strength}"): SizedBox(height:0),
                _play.ballPlacement != null ? Text("${_play.ballPlacement}") : SizedBox(height:0),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child:_play.typeOfPlay != null && _play.specificType != null ? 
                    //if penalty
                    _play.typeOfPlay == 'Pre-Play Penalty' || _play.typeOfPlay == 'Post-Play Penalty'
                    ? 
                    Text(
                      "${_play.typeOfPlay}: ${_play.specificType}",
                      style: TextStyle(color: Colors.white),
                    ) 
                    //else
                    :
                    Text(
                      "${_play.specificType} ${_play.typeOfPlay}",
                      style: TextStyle(color: Colors.white),
                    ) 
                    : SizedBox(height:0),
                  ),
                  color: Colors.green,
                  ),
                _play.typeOfTurnover != null ? Text("${_play.typeOfTurnover}") : SizedBox(height:0),
                _play.netYardage != null ? Text("for ${_play.netYardage} yards") : SizedBox(height:0),
                _play.points != null ? Text("${_play.points} points scored!") : SizedBox(height:0),
              ]
            ),
          ), 
          color: Color.fromRGBO(217, 217, 217, 100),
        ),
        onTap: (){
          
        },
      );
}

Widget AllPlaysListView(BuildContext context, List<dynamic> allPlays){
  allPlays = allPlays.reversed.toList();
  if (allPlays.length < 1){
    return Center(child: Text("No Recorded Plays", style: TextStyle(fontSize: 40),));
  }
  else{
    return ListView.builder(
        itemExtent: 150.0,
        itemCount: allPlays.length,
        itemBuilder: (context, index) {
          return PlayListItem(context, allPlays[index], allPlays.length - index);
        }
      );
  }
}