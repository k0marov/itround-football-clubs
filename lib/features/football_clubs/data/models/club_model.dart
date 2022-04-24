import 'package:equatable/equatable.dart';

import '../../domain/entities/club_entity.dart';

class ClubModel extends Equatable {
  final Club _entity; 

  @override 
  List get props => [_entity]; 

  Club toEntity() => _entity; 

  const ClubModel(this._entity);  

  ClubModel.fromJson(Map<String, dynamic> json) : this(
    Club(
      imageUrl: json['strTeamBadge'], 
      league: json['strLeague'], 
      title: json['strTeam'], 
      description: json['strDescriptionEN'], 
    )
  ); 
}