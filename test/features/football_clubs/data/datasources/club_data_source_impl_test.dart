import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:it_round/core/error/exceptions.dart';
import 'package:it_round/features/football_clubs/data/datasources/club_data_source.dart';
import 'package:it_round/core/external_apis/the_sports_db_api.dart';
import 'package:it_round/features/football_clubs/data/models/club_model.dart';
import 'package:it_round/features/football_clubs/domain/entities/league_entity.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSportsAPI extends Mock 
  implements TheSportsDBAPI {} 

void main() {
  late MockSportsAPI mockSportsAPI; 
  late ClubDataSourceImpl sut;

  setUp(() {
    mockSportsAPI = MockSportsAPI(); 
    sut = ClubDataSourceImpl(mockSportsAPI);
  });

  const tLeague = League(
    title: "Some Test League Title", 
    imageUrl: "url",
  ); 

  group('getClubsOfLeague', () {
    test(
      "should call API and return the parsed result",
      () async {
        // arrange
        final apiResponse = fixture('list_teams_fixture.json'); 
        when(() => mockSportsAPI.listAllTeamsInALeague(tLeague.title))
          .thenAnswer((_) async => apiResponse); 
        // act
        final result = await sut.getClubsOfLeague(tLeague); 
        // assert
        final expectedResult = json.decode(apiResponse)['teams']
          .map<ClubModel>((teamJson) => ClubModel.fromJson(teamJson))
          .toList(); 
        expect(result, expectedResult); 
        verify(() => mockSportsAPI.listAllTeamsInALeague(tLeague.title)); 
        verifyNoMoreInteractions(mockSportsAPI); 
      },
    );
    test(
      'should throw NotFoundException if API returns {"teams": null}',
      () async {
        // arrange
        when(() => mockSportsAPI.listAllTeamsInALeague(tLeague.title))
          .thenAnswer((_) async => '{"teams": null}');
        // assert
        expect(() => sut.getClubsOfLeague(tLeague), throwsA(TypeMatcher<NotFoundException>())); 
      },
    );
    test(
      "should throw ServerException if api response could not be parsed",
      () async {
        // arrange
        when(() => mockSportsAPI.listAllTeamsInALeague(tLeague.title))
          .thenAnswer((_) async => "abracadabra");
        // assert
        expect(() => sut.getClubsOfLeague(tLeague), throwsA(const TypeMatcher<ServerException>()));
      },
    );
    test(
      "should rethrow the exception that api throws",
      () async {
        // arrange
        when(() => mockSportsAPI.listAllTeamsInALeague(tLeague.title))
          .thenThrow(NotFoundException()); 
        // assert
        expect(() => sut.getClubsOfLeague(tLeague), throwsA(const TypeMatcher<NotFoundException>())); 
      },
    );
  });
}
