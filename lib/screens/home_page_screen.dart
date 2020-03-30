import 'package:flutter/material.dart';
import 'package:play_tracker/Screens/new_game_screen.dart';
import 'package:play_tracker/Screens/previous_games_screen.dart';
import '../Buttons/buttons.dart';

class HomePageScreen extends StatelessWidget {
  HomePageScreen({Key key}) : super(key: key);

  static const routeName = '/';

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
                'Football Play Tracker',
                style: TextStyle(fontSize: 75, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              // After title spacer
              SizedBox(height: 50,),
              //               Label, width, height, textSize, radius, screen
              RoundedButton(context, "New Game", 200, 80, 25, 10, NewGameScreen()),
              // Between button spacer
              SizedBox(height: 30,),
              //               Label, width, height, textSize, radius, screen
              RoundedButton(context, "View Previous Game(s)", 200, 80, 25, 10, PreviousGamesScreen()),
            ],
          ),
        ),
      ),
    );
  }
}