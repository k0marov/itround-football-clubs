import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:it_round/core/error/exceptions.dart';
import 'package:it_round/core/error/failures.dart';
import 'package:it_round/features/football_clubs/data/datasources/league_data_source.dart';
import 'package:it_round/features/football_clubs/data/models/league_model.dart';
import 'package:it_round/features/football_clubs/data/repositories/league_repository_impl.dart';
import 'package:it_round/features/football_clubs/domain/entities/league_entity.dart';
import 'package:mocktail/mocktail.dart';

class MockLeagueDataSource extends Mock 
  implements LeagueDataSource {} 

void main() {
  late MockLeagueDataSource mockLeagueDataSource; 
  late LeagueRepositoryImpl sut;

  setUp(() {
    mockLeagueDataSource = MockLeagueDataSource(); 
    sut = LeagueRepositoryImpl(mockLeagueDataSource);
  });

  group('getAllLeagues', () {
    const tLeagues = [
      League(
        imageUrl: "some-url-1", 
        title: "League 1"
      ),
      League(
        imageUrl: "some-url-2", 
        title: "League 2"
      ),
      League(
        imageUrl: "some-url-3", 
        title: "League 3"
      ),
    ]; 
    final tLeagueModels = tLeagues
      .map((league) => LeagueModel(league))
      .toList(); 
    test(
      "should call datasource and return the data" 
      " if the call was successful",
      () async {
        // arrange
        when(() => mockLeagueDataSource.getAllLeagues())
          .thenAnswer((_) async => tLeagueModels); 
        // act
        final result = await sut.getAllLeagues(); 
        // assert
        result.fold(
          (failure) => throw Exception(), 
          (leagues) => expect(listEquals(leagues, tLeagues), true)
        ); 
        verify(() => mockLeagueDataSource.getAllLeagues()); 
        verifyNoMoreInteractions(mockLeagueDataSource); 
      },
    );
    test(
      "should return ServerFailure if the call to datasource was unsuccesful",
      () async {
        // arrange
        when(() => mockLeagueDataSource.getAllLeagues())
          .thenThrow(ServerException()); 
        // act
        final result = await sut.getAllLeagues(); 
        // assert
        expect(result, Left(ServerFailure())); 
      },
    );
  });
}
