import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:it_round/core/error/exceptions.dart';
import 'package:it_round/core/error/failures.dart';
import 'package:it_round/features/football_clubs/data/datasources/club_data_source.dart';
import 'package:it_round/features/football_clubs/data/models/club_model.dart';
import 'package:it_round/features/football_clubs/data/repositories/club_repository_impl.dart';
import 'package:it_round/features/football_clubs/domain/entities/club_entity.dart';
import 'package:it_round/features/football_clubs/domain/entities/league_entity.dart';
import 'package:mocktail/mocktail.dart';

class MockClubDataSource extends Mock implements ClubDataSource {} 

void main() {
  late MockClubDataSource mockClubDataSource; 
  late ClubRepositoryImpl sut;

  setUp(() {
    mockClubDataSource = MockClubDataSource(); 
    sut = ClubRepositoryImpl(mockClubDataSource);
  });

  const tLeague = League(
    title: "Test Title", 
    imageUrl: "test-url"
  ); 
  final tClubs = [
    Club(
      imageUrl: "url-1", 
      league: tLeague.title, 
      title: "Club 1", 
      description: "Some description", 
    ), 
    Club(
      imageUrl: "url-2", 
      league: tLeague.title, 
      title: "Club 2", 
      description: "Some description",
    ), 
  ]; 

  final tClubModels = tClubs
    .map((club) => ClubModel(club))
    .toList(); 

  group('getClubsOfLeague', () {
    test(
      "should call datasource and return the result if the call was successful",
      () async {
        // arrange
        when(() => mockClubDataSource.getClubsOfLeague(tLeague))
          .thenAnswer((_) async => tClubModels);
        // act
        final result = await sut.getClubsOfLeague(tLeague); 
        // assert
        result.fold(
          (failure) => throw Exception(), 
          (clubs) => expect(listEquals(clubs, tClubs), true)
        ); 
        verify(() => mockClubDataSource.getClubsOfLeague(tLeague)); 
        verifyNoMoreInteractions(mockClubDataSource); 
      },
    );
    test(
      "should return NotFoundFailure if datasource threw NotFoundException",
      () async {
        // arrange
        when(() => mockClubDataSource.getClubsOfLeague(tLeague))
          .thenThrow(NotFoundException()); 
        // act
        final result = await sut.getClubsOfLeague(tLeague); 
        // assert
        expect(result, Left(NotFoundFailure())); 
      },
    );
    test(
      "should return ServerFailure if datasource threw ServerException",
      () async {
        // arrange
        when(() => mockClubDataSource.getClubsOfLeague(tLeague))
          .thenThrow(ServerException()); 
        // act
        final result = await sut.getClubsOfLeague(tLeague); 
        // assert
        expect(result, Left(ServerFailure())); 
      },
    );
  });
}
