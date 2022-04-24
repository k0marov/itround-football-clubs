import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:it_round/core/usecases/usecases.dart';
import 'package:it_round/features/football_clubs/domain/repositories/club_repository.dart';

import '../../../../core/error/failures.dart';
import '../entities/club_entity.dart';
import '../entities/league_entity.dart';

class GetClubsOfLeague extends UseCase<List<Club>, ClubsParams> {
  final ClubRepository repository; 
  GetClubsOfLeague(this.repository); 

  @override 
  Future<Either<Failure, List<Club>>> call(ClubsParams params) async {
    return repository.getClubsOfLeague(params.league); 
  }
}

class ClubsParams extends Equatable {
  final League league; 
  @override 
  List get props => [league]; 

  const ClubsParams({
    required this.league,
  }); 
}