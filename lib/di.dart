import 'package:get_it/get_it.dart';
import 'package:it_round/core/external_apis/google_translate_api.dart';
import 'package:it_round/core/external_apis/the_sports_db_api.dart';
import 'package:it_round/core/usecases/get_russian_translation.dart';
import 'package:it_round/features/football_clubs/data/datasources/club_data_source.dart';
import 'package:it_round/features/football_clubs/data/datasources/league_data_source.dart';
import 'package:it_round/features/football_clubs/data/repositories/club_repository_impl.dart';
import 'package:it_round/features/football_clubs/domain/repositories/club_repository.dart';
import 'package:it_round/features/football_clubs/domain/repositories/league_repository.dart';
import 'package:it_round/features/football_clubs/domain/usecases/get_all_leagues.dart';
import 'package:translator/translator.dart';

import 'features/football_clubs/data/repositories/league_repository_impl.dart';
import 'features/football_clubs/domain/usecases/get_clubs_of_league.dart';
import 'package:http/http.dart' as http; 

final sl = GetIt.instance; 

void init() {
  // usecases
  sl.registerLazySingleton(() => GetAllLeagues(sl())); 
  sl.registerFactory(() => GetClubsOfLeague(sl())); 
  sl.registerFactory(() => GetRussianTranslation(sl()));

  // repositories
  sl.registerFactory<LeagueRepository>(() => LeagueRepositoryImpl(sl())); 
  sl.registerFactory<ClubRepository>(() => ClubRepositoryImpl(sl())); 

  // datasources 
  sl.registerFactory<LeagueDataSource>(() => LeagueDataSourceImpl(sl())); 
  sl.registerFactory<ClubDataSource>(() => ClubDataSourceImpl(sl())); 

  // APIs 
  sl.registerFactory<TheSportsDBAPI>(() => TheSportsDBAPIImpl(sl())); 
  sl.registerFactory<GoogleTranslateAPI>(() => GoogleTranslateAPIImpl(sl())); 

  // External
  sl.registerFactory(() => http.Client()); 
  sl.registerFactory(() => GoogleTranslator()); 
}