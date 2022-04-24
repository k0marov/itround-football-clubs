import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:it_round/core/error/exceptions.dart';
import 'package:it_round/core/external_apis/the_sports_db_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

import '../../fixtures/fixture_reader.dart'; 

class MockHttpClient extends Mock implements http.Client {} 

void main() {
  late MockHttpClient mockHttpClient; 
  late TheSportsDBAPIImpl sut;

  setUp(() {
    mockHttpClient = MockHttpClient(); 
    sut = TheSportsDBAPIImpl(mockHttpClient);

    registerFallbackValue(Uri()); 
  });

  const responseHeaders = {
    HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
  }; 

  group('listAllLeagues', () {
    final responseBody = fixture("list_leagues_fixture.json"); 
    final uri = Uri.https("www.thesportsdb.com", "api/v1/json/2/all_leagues.php");
    test(
      "should get the data using client with proper endpoint and return a String if status code is 200",
      () async {
        // arrange
        when(() => mockHttpClient.get(uri)) 
          .thenAnswer((_) async => http.Response(responseBody, 200, headers: responseHeaders)); 
        // act
        final result = await sut.listAllLeagues(); 
        // assert
        expect(result, responseBody); 
        verify(() => mockHttpClient.get(uri)); 
        verifyNoMoreInteractions(mockHttpClient); 
      },
    );
    test(
      "should throw NotFoundException if status_code is 404",
      () async {
        // arrange
        when(() => mockHttpClient.get(any()))
          .thenAnswer((_) async => http.Response("error-text", 404, headers: responseHeaders)); 
        // assert
        expect(() => sut.listAllLeagues(), throwsA(TypeMatcher<NotFoundException>()));
      },
    );
    test(
      "should throw ServerException if status_code is not 200 and not 404",
      () async {
        // arrange
        when(() => mockHttpClient.get(any()))
          .thenAnswer((_) async => http.Response("error-text", 420, headers: responseHeaders)); 
        // assert
        expect(() => sut.listAllLeagues(), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });

  group('listAllTeamsInALeague', () {
    final responseBody = fixture("list_teams_fixture.json"); 
    const tLeague = "English Premier League"; 
    final uri = Uri.https("www.thesportsdb.com", "api/v1/json/2/search_all_teams.php", {
      'l': tLeague
    });
    final uri_404 = Uri.https("www.thesportsdb.com", "api/v1/json/2/search_all_teams.php", {
      'l': "abracadabra"
    });

    test(
      "should get the data using client and return a string if status_code is 200",
      () async {
        // arrange
        when(() => mockHttpClient.get(uri))
          .thenAnswer((_) async => http.Response(responseBody, 200, headers: responseHeaders)); 
        // act
        final result = await sut.listAllTeamsInALeague(tLeague); 
        // assert
        expect(result, responseBody); 
        verify(() => mockHttpClient.get(uri)); 
        verifyNoMoreInteractions(mockHttpClient); 
      },
    );
    test(
      "should throw NotFoundException if status_code is 404",
      () async {
        // arrange
        when(() => mockHttpClient.get(uri_404))
          .thenAnswer((_) async => http.Response("not-found-error", 404, headers: responseHeaders)); 
        // assert
        expect(() => sut.listAllTeamsInALeague("abracadabra"), throwsA(TypeMatcher<NotFoundException>())); 
      },
    );
    test(
      "should throw ServerException if status_code is not 200 and not 404",
      () async {
        // arrange
        when(() => mockHttpClient.get(uri))
          .thenAnswer((_) async => http.Response("some-strange-error", 420, headers: responseHeaders)); 
        // assert
        expect(() => sut.listAllTeamsInALeague(tLeague), throwsA(TypeMatcher<ServerException>()));
      },
    );

  });
}
