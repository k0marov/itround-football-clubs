import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:it_round/core/error/exceptions.dart';
import 'package:it_round/features/football_clubs/data/datasources/league_data_source.dart';
import 'package:it_round/core/external_apis/the_sports_db_api.dart';
import 'package:it_round/features/football_clubs/data/models/league_model.dart';
import 'package:it_round/features/football_clubs/domain/entities/league_entity.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSportsAPI extends Mock 
  implements TheSportsDBAPI {} 

void main() {
  late MockSportsAPI mockSportsAPI; 
  late LeagueDataSourceImpl sut;

  setUp(() {
    mockSportsAPI = MockSportsAPI(); 
    sut = LeagueDataSourceImpl(mockSportsAPI);
  });

  group('getAllLeagues', () {
    const tLeagues = [
      LeagueModel(League(title: "English Premier League", imageUrl: "TODO")), 
      LeagueModel(League(title: "Chinese Super League", imageUrl: "TODO")), 
    ]; 
    test(
      "should call API and return the parsed result",
      () async {
        // arrange
        final apiResponse = fixture("list_leagues_fixture.json"); 
        when(() => mockSportsAPI.listAllLeagues())
          .thenAnswer((_) async => apiResponse);
        // act
        final result = await sut.getAllLeagues(); 
        // assert
        expect(result, tLeagues); 
        verify(() => mockSportsAPI.listAllLeagues()); 
        verifyNoMoreInteractions(mockSportsAPI); 
      },
    );
    test(
      "should throw ServerException if apiResponse was not parsed correctly",
      () async {
        // arrange
        when(() => mockSportsAPI.listAllLeagues())
          .thenAnswer((_) async => "abracadabra"); 
        // assert
        expect(() => sut.getAllLeagues(), throwsA(const TypeMatcher<ServerException>()));
      },
    );
    test(
      "should rethrow the exception if api throws one",
      () async {
        // arrange
        final exception = NotFoundException(); 
        when(() => mockSportsAPI.listAllLeagues())
          .thenThrow(exception); 
        // assert
        expect(() => sut.getAllLeagues(), throwsA(const TypeMatcher<NotFoundException>()));
      },
    );
  });
}
