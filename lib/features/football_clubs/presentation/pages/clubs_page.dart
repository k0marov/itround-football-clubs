import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:it_round/core/error/failures.dart';
import 'package:it_round/di.dart';
import 'package:it_round/features/football_clubs/domain/entities/club_entity.dart';
import 'package:it_round/features/football_clubs/domain/entities/league_entity.dart';
import 'package:it_round/features/football_clubs/domain/usecases/get_clubs_of_league.dart';
import 'package:it_round/features/football_clubs/presentation/pages/club_detail_page.dart';

import '../widgets/club_list_widget.dart';

class ClubsPage extends StatelessWidget {
  final League league; 
  const ClubsPage({ 
    required this.league, 
    Key? key 
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(league.title)
      ),
      body: Center(
        child: FutureBuilder<Either<Failure, List<Club>>>(
          future: sl<GetClubsOfLeague>()(ClubsParams(league: league)), 
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator(); 
            } 
            return snapshot.data!.fold(
              (failure) => Text(failure.toString()), 
              (clubList) => ClubListWidget(clubList: clubList)
            ); 
          }
        )
      )
    ); 
  }
}
