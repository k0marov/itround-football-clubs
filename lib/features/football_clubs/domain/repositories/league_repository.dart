import 'package:dartz/dartz.dart';
import 'package:it_round/core/error/failures.dart';
import 'package:it_round/features/football_clubs/domain/entities/league_entity.dart';

abstract class LeagueRepository {
  Future<Either<Failure, List<League>>> getAllLeagues(); 
}