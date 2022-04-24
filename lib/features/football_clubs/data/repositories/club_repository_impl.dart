import 'package:it_round/core/error/exceptions.dart';
import 'package:it_round/features/football_clubs/data/datasources/club_data_source.dart';
import 'package:it_round/features/football_clubs/domain/entities/league_entity.dart';
import 'package:it_round/features/football_clubs/domain/entities/club_entity.dart';
import 'package:it_round/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repositories/club_repository.dart';

class ClubRepositoryImpl implements ClubRepository {
  final ClubDataSource dataSource; 
  const ClubRepositoryImpl(this.dataSource); 

  @override
  Future<Either<Failure, List<Club>>> getClubsOfLeague(League league) async {
    try {
      final dataSourceResponse = await dataSource.getClubsOfLeague(league); 
      final clubs = dataSourceResponse
        .map((clubModel) => clubModel.toEntity())
        .toList(); 
      return Right(clubs); 
    } on NotFoundException {
      return Left(NotFoundFailure()); 
    } on ServerException {
      return Left(ServerFailure()); 
    }
  }
}