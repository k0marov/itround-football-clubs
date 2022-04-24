import 'package:dartz/dartz.dart';
import 'package:it_round/features/football_clubs/domain/entities/club_entity.dart';
import 'package:it_round/features/football_clubs/domain/entities/league_entity.dart';

import '../../../../core/error/failures.dart';

abstract class ClubRepository {
  Future<Either<Failure, List<Club>>> getClubsOfLeague(League league); 
}