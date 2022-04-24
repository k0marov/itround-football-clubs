import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:it_round/features/football_clubs/data/models/league_model.dart';
import 'package:it_round/features/football_clubs/domain/entities/league_entity.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  late LeagueModel tClubModel;


  const League tLeague = League(
      title: "Test League", 
      imageUrl: "league-url", 
    ); 

  setUp(() {
    tClubModel = const LeagueModel(tLeague); 
  });

  test(
    "should have a toEntity method that returns a valid entity",
    () async {
      // act 
      final result = tClubModel.toEntity(); 
      // assert 
      expect(result, tLeague); 
    },
  );

  group('fromJson', () {
    const tExpectedLeague = LeagueModel(League(
      title: "English Premier League", 
      imageUrl: "TODO" // TODO
    )); 
    test(
      "should return a valid model from a json",
      () async {
        // arrange
        final jsonMap = json.decode(fixture("league_fixture.json"));
        // act
        final result = LeagueModel.fromJson(jsonMap); 
        // assert
        expect(result, tExpectedLeague);
      },
    );
  }); 
}
