import 'package:equatable/equatable.dart';

class League extends Equatable {
  final String title; 
  final String imageUrl; 

  @override 
  List get props => [title, imageUrl];

  const League({
    required this.title, 
    required this.imageUrl, 
  }); 
}