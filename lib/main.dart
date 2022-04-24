import 'package:flutter/material.dart';
import 'package:it_round/features/football_clubs/presentation/pages/leagues_page.dart';
import 'di.dart' as di; 

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LeaguesPage()
    ); 
  }
}