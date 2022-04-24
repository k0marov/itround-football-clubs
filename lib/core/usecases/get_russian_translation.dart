import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:it_round/core/error/exceptions.dart';
import 'package:it_round/core/usecases/usecases.dart';

import '../error/failures.dart';
import '../external_apis/google_translate_api.dart';

// This usecase does not depend on a repository, but rather on the API itself
// because it's too simple for writing a repository 
class GetRussianTranslation extends UseCase<String, TranslationParams> {
  final GoogleTranslateAPI _api; 

  GetRussianTranslation(this._api); 

  @override
  Future<Either<Failure, String>> call(TranslationParams params) async {
    try {
      final apiResponse = await _api.fromEnglishToRussian(params.englishText); 
      return Right(apiResponse); 
    } on TranslationException {
      return Left(TranslationFailure()); 
    }
  }
}

class TranslationParams extends Equatable {
  final String englishText;
  @override 
  List get props => [englishText];  

  TranslationParams({ required this.englishText }); 
}