import 'package:equatable/equatable.dart';

class Club extends Equatable {
  final String league; 
  final String? imageUrl; 
  final String title; 
  final String? description; 

  @override 
  List get props => [imageUrl, league, title, description]; 

  const Club({
    required this.imageUrl, 
    required this.league, 
    required this.title, 
    required this.description, 
  }); 
}