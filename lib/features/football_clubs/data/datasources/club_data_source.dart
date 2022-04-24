import 'dart:convert';

import 'package:it_round/core/error/exceptions.dart';
import 'package:it_round/core/external_apis/the_sports_db_api.dart';
import 'package:it_round/features/football_clubs/data/models/club_model.dart';
import 'package:it_round/features/football_clubs/domain/entities/league_entity.dart';

abstract class ClubDataSource {
  /// Gets all clubs that are playing in the given league
  /// throws [NotFoundException] if the league was not found or it has 0 leagues with description available
  /// throws [ServerException] if there was a connection issue
  Future<List<ClubModel>> getClubsOfLeague(League league); 
}

class ClubDataSourceImpl implements ClubDataSource {
  final TheSportsDBAPI _api;
  ClubDataSourceImpl(this._api); 

  @override
  Future<List<ClubModel>> getClubsOfLeague(League league) async {
    final apiResponse = await _api.listAllTeamsInALeague(league.title); 
    try {
      final teams = json.decode(apiResponse)['teams']; 
      if (teams == null) throw NotFoundException(); 
      final parsedClubs = json.decode(apiResponse)['teams'] 
        .map<ClubModel>((clubJson) => ClubModel.fromJson(clubJson)) 
        .toList(); 
      return parsedClubs; 
    } catch (e) {
      if (e is NotFoundException) rethrow; 
      throw ServerException(); 
    }
  }
}