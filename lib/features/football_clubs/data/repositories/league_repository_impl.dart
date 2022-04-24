import 'package:it_round/core/error/exceptions.dart';
import 'package:it_round/features/football_clubs/data/datasources/league_data_source.dart';
import 'package:it_round/features/football_clubs/domain/entities/league_entity.dart';
import 'package:it_round/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:it_round/features/football_clubs/domain/repositories/league_repository.dart';

class LeagueRepositoryImpl implements LeagueRepository {
  final LeagueDataSource dataSource;
  LeagueRepositoryImpl(this.dataSource); 

  @override
  Future<Either<Failure, List<League>>> getAllLeagues() async {
    try {
      final dataSourceResponse = await dataSource.getAllLeagues(); 
      final leagues = dataSourceResponse
      .map((leagueModel) => leagueModel.toEntity())
      .toList(); 
      return Right(leagues); 
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}