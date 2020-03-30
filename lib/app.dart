import 'package:flutter/material.dart';
import 'Screens/home_page_screen.dart';

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Play Tracker',
      home: HomePageScreen(),
    );
  }
}