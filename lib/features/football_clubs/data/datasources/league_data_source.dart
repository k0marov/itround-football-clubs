import 'dart:convert';

import 'package:it_round/core/error/exceptions.dart';
import 'package:it_round/core/external_apis/the_sports_db_api.dart';
import 'package:it_round/features/football_clubs/data/models/league_model.dart';

abstract class LeagueDataSource {
  /// Gets the list of all leagues 
  /// Throws [ServerException] if there was a connection issue
  Future<List<LeagueModel>> getAllLeagues(); 
}


class LeagueDataSourceImpl implements LeagueDataSource {
  final TheSportsDBAPI _api; 

 LeagueDataSourceImpl(this._api); 

  @override
  Future<List<LeagueModel>> getAllLeagues() async {
    final listOfLeaguesStr = await _api.listAllLeagues(); 
    try {
      final parsedLeagues = json.decode(listOfLeaguesStr)['leagues']
      .where((leagueJson) => leagueJson['strSport'] == "Soccer")
      .map<LeagueModel>((leagueJson) => LeagueModel.fromJson(leagueJson))
      .where((LeagueModel model) => !model.toEntity().title.startsWith("_"))  // in this api leagues starting with _ are for test purposes (I guess)
      .toList(); 
      return parsedLeagues; 
    } catch (e) {
      throw ServerException(); 
    }
  }
}