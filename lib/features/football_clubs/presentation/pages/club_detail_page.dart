import 'package:flutter/material.dart';
import 'package:it_round/features/football_clubs/presentation/widgets/club_detail_widget.dart';

import '../../domain/entities/club_entity.dart';

class ClubDetailPage extends StatelessWidget {
  final Club club;  
  const ClubDetailPage({ 
    required this.club, 
    Key? key 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(club.title)
      ),
      body: Center(
        child: ClubDetailWidget(club: club)
      )
    ); 
  }
}