import 'package:http/http.dart' as http;
import 'package:it_round/core/error/exceptions.dart'; 

abstract class TheSportsDBAPI {
  Future<String> listAllLeagues();  
  Future<String> listAllTeamsInALeague(String enLeagueName);
}


class TheSportsDBAPIImpl implements TheSportsDBAPI {
  static const apiHost = "www.thesportsdb.com"; 
  static const apiPrefix = "/api/v1/json/2/";

  final http.Client _client;
  TheSportsDBAPIImpl(this._client); 

  @override
  Future<String> listAllLeagues() async {
    const endpoint = "all_leagues.php"; 
    final apiResponse = await _client.get(Uri.https(apiHost, apiPrefix+endpoint)); 
    if (apiResponse.statusCode == 200) {
      return apiResponse.body; 
    } else if (apiResponse.statusCode == 404) {
      throw NotFoundException(); 
    } else {
      throw ServerException();
    }
  }

  static const listAllTeamsInALeagueEndpoint = "search_all_teams.php"; 
  @override
  Future<String> listAllTeamsInALeague(String enLeagueName) async {
    const endpoint = "search_all_teams.php"; 
    final apiResponse = await _client.get(Uri.https(apiHost, apiPrefix+endpoint, {
      'l': enLeagueName
    })); 
    if (apiResponse.statusCode == 200) {
      return apiResponse.body; 
    } else if (apiResponse.statusCode == 404) {
      throw NotFoundException(); 
    } else {
      throw ServerException(); 
    }
  }
}