import 'package:equatable/equatable.dart';

import '../../domain/entities/league_entity.dart';

class LeagueModel extends Equatable {
  final League _entity; 

  League toEntity() => _entity; 

  @override 
  List get props => [_entity]; 

  const LeagueModel(this._entity); 

  LeagueModel.fromJson(Map<String, dynamic> json) : this(
    League(
      title: json['strLeague'], 
      imageUrl: "TODO" // TODO
    )
  ); 
}