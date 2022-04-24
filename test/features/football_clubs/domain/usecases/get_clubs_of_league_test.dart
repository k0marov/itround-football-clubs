import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:it_round/features/football_clubs/domain/entities/club_entity.dart';
import 'package:it_round/features/football_clubs/domain/entities/league_entity.dart';
import 'package:it_round/features/football_clubs/domain/repositories/club_repository.dart';
import 'package:it_round/features/football_clubs/domain/usecases/get_clubs_of_league.dart';
import 'package:mocktail/mocktail.dart';

class MockClubRepository extends Mock 
  implements ClubRepository {}

void main() {
  late GetClubsOfLeague sut;
  late MockClubRepository mockClubRepository; 
  

  setUp(() {
    mockClubRepository = MockClubRepository(); 
    sut = GetClubsOfLeague(mockClubRepository);
  });

  const tLeague = League(
    title: "Test League", 
    imageUrl: "some-url"
  ); 
  final tClubs = [
    Club(
      imageUrl: "_", 
      league: tLeague.title, 
      title: "Club 1", 
      description: "The first club in this test",
    ),
    Club(
      imageUrl: "_", 
      league: tLeague.title, 
      title: "Club 2", 
      description: "The second club in this test", 
    ), 
  ]; 

  test(
    "should call the repository and return its result",
    () async {
      // arrange
      when(() => mockClubRepository.getClubsOfLeague(tLeague))
        .thenAnswer((_) async => Right(tClubs));
      // act
      final result = await sut(const ClubsParams(league: tLeague)); 
      // assert
      expect(result, Right(tClubs)); 
      verify(() => mockClubRepository.getClubsOfLeague(tLeague)); 
      verifyNoMoreInteractions(mockClubRepository); 
    },
  );
}
