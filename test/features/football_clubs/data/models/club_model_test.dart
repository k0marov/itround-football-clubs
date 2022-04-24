import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:it_round/features/football_clubs/data/models/club_model.dart';
import 'package:it_round/features/football_clubs/domain/entities/club_entity.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  late ClubModel tClubModel;


  const Club tClub = Club(
      imageUrl: "_", 
      league: "Test League", 
      title: "Test Title", 
      description: "Description of a test Club"
    ); 


  setUp(() {
    tClubModel = const ClubModel(tClub);
  });

  test(
    "should have a toEntity method that returns a valid entity",
    () async {
      // act 
      final result = tClubModel.toEntity(); 
      // assert 
      expect(result, tClub); 
    },
  );

  group('fromJson', () {

    test(
      "should return a valid model from json",
      () async {
        const tExpectedModel = ClubModel(Club(
            league: "English Premier League", 
            title: "Wolves", 
            imageUrl: "https://www.thesportsdb.com/images/media/team/badge/u9qr031621593327.png",
            description: "Wolverhampton Wanderers Football Club (commonly referred to as Wolves) is an English professional football club that represents the city of Wolverhampton in the West Midlands. The club was originally known as St. Luke's FC and was founded in 1877 and since 1889 has played at Molineux. They currently compete in the Football League Championship, the second highest tier of English football, having been promoted from League One in 2014 after a solitary season at that level.\r\n\r\nHistorically, Wolves have been highly influential, most notably as being founder members of the Football League, as well as having played an instrumental role in the establishment of the European Cup, later to become the UEFA Champions League. Having won the FA Cup twice before the outbreak of the First World War, they developed into one of England's leading clubs under the management of ex-player Stan Cullis after the Second World War, going on to win the league three times and the FA Cup twice more between 1949 and 1960. It was during this time that the European Cup competition was established, after the English press declared Wolves \"Champions of the World\" following their victories against numerous top European and World sides in some of British football's first live televised games.\r\n\r\nWolves have yet to match the successes of the Stan Cullis era, although, under Bill McGarry, they contested the first-ever UEFA Cup final in 1972 and won the 1974 League Cup, a trophy they lifted again six years later under John Barnwell. However, financial mismanagement in the 1980s led to the club's very existence being under threat as well as three consecutive relegations, before a revival and back-to-back promotions under manager Graham Turner and record goalscorer Steve Bull saw them finish the decade in the Second Division, winning the Football League Trophy along the way.", 
        ));
        // arrange
        final tJsonMap = json.decode(fixture("team_fixture.json"));
        // act
        final result = ClubModel.fromJson(tJsonMap); 
        // assert
        expect(result, tExpectedModel); 
      },
    );
  }); 
}
