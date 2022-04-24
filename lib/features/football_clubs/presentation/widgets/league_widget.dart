import 'package:flutter/material.dart';

import '../../domain/entities/league_entity.dart';
import '../pages/clubs_page.dart';

class LeagueWidget extends StatelessWidget {
  final League league; 
  const LeagueWidget({ 
    required this.league, 
    Key? key 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => 
    TextButton(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(league.title, textScaleFactor: 1.4,),
      ), 
      onPressed: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ClubsPage(league: league),
      ))
    ); 
}