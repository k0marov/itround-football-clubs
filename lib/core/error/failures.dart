import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List _props; 

  @override 
  List get props => _props; 


  const Failure([this._props = const []]); 
}

class NotFoundFailure extends Failure {} 

class ServerFailure extends Failure {} 

class TranslationFailure extends Failure {} 