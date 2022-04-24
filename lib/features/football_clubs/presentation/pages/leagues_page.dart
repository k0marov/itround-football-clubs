import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:it_round/core/usecases/usecases.dart';
import 'package:it_round/features/football_clubs/domain/entities/league_entity.dart';
import 'package:it_round/features/football_clubs/domain/usecases/get_all_leagues.dart';

import '../../../../core/error/failures.dart';
import '../../../../di.dart';
import '../widgets/league_list_widget.dart';
class LeaguesPage extends StatelessWidget {
  const LeaguesPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select a League"),
      ),
      body: Center(
        child: FutureBuilder<Either<Failure, List<League>>>(
          future: sl<GetAllLeagues>()(NoParams()), 
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator(); 
            } 
            return snapshot.data!.fold(
              (failure) => Text(failure.toString()), 
              (leagueList) => LeagueListWidget(leagues: leagueList)
            );
          } 
        ),
      ),
    ); 
  }
}

