import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:it_round/core/usecases/usecases.dart';
import 'package:it_round/features/football_clubs/domain/entities/league_entity.dart';
import 'package:it_round/features/football_clubs/domain/repositories/league_repository.dart';
import 'package:it_round/features/football_clubs/domain/usecases/get_all_leagues.dart';
import 'package:mocktail/mocktail.dart'; 

class MockLeagueRepository extends Mock 
  implements LeagueRepository {} 

void main() {
  late GetAllLeagues sut;
  late MockLeagueRepository mockLeagueRepository; 
  setUp(() {
    mockLeagueRepository = MockLeagueRepository(); 
    sut = GetAllLeagues(mockLeagueRepository);
  });

  const tLeagues = [
    League(
      title: "Test League 1", 
      imageUrl: "url1", 
    ),
    League(
      title: "Test League 2", 
      imageUrl: "url2", 
    ),
    League(
      title: "Test League 3", 
      imageUrl: "url3", 
    ),
  ]; 

  test(
    "should get all leagues from the repository",
    () async {
      // arrange
      when(() => mockLeagueRepository.getAllLeagues())
        .thenAnswer((_) async => const Right(tLeagues)); 
      // act
      final result = await sut(NoParams()); 
      // assert
      expect(result, const Right(tLeagues)); 
      verify(() => mockLeagueRepository.getAllLeagues()); 
      verifyNoMoreInteractions(mockLeagueRepository);
    },
  );
}
