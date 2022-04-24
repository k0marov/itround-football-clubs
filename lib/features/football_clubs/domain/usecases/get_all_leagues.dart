import 'package:dartz/dartz.dart';
import 'package:it_round/core/usecases/usecases.dart';
import 'package:it_round/features/football_clubs/domain/entities/league_entity.dart';
import 'package:it_round/features/football_clubs/domain/repositories/league_repository.dart';

import '../../../../core/error/failures.dart';

class GetAllLeagues extends UseCase<List<League>, NoParams> {
  final LeagueRepository repository; 
  GetAllLeagues(this.repository); 

  @override
  Future<Either<Failure, List<League>>> call(NoParams params) async {
    return repository.getAllLeagues(); 
  }
}