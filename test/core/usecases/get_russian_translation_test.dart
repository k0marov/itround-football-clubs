import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:it_round/core/error/exceptions.dart';
import 'package:it_round/core/error/failures.dart';
import 'package:it_round/core/external_apis/google_translate_api.dart';
import 'package:it_round/core/usecases/get_russian_translation.dart';
import 'package:mocktail/mocktail.dart';

class MockGoogleTranslateAPI extends Mock implements GoogleTranslateAPI {} 


void main() {
  late MockGoogleTranslateAPI mockGoogleTranslateAPI; 
  late GetRussianTranslation sut;

  setUp(() {
    mockGoogleTranslateAPI = MockGoogleTranslateAPI(); 
    sut = GetRussianTranslation(mockGoogleTranslateAPI);
  });

  const tEnglish = "Hello"; 
  const tRussian = "Привет"; 

  test(
    "should call api and return the result if it the call was successful",
    () async {
      // arrange
      when(() => mockGoogleTranslateAPI.fromEnglishToRussian(tEnglish))
        .thenAnswer((_) async => tRussian); 
      // act
      final result = await sut(TranslationParams(englishText: tEnglish));
      // assert
      expect(result, Right(tRussian)); 
      verify(() => mockGoogleTranslateAPI.fromEnglishToRussian(tEnglish)); 
      verifyNoMoreInteractions(mockGoogleTranslateAPI); 
    },
  );
  test(
    "should return TranslationFailure if api throws TranslationException",
    () async {
      // arrange
      when(() => mockGoogleTranslateAPI.fromEnglishToRussian(tEnglish))
        .thenThrow(TranslationException()); 
      // act
      final result = await sut(TranslationParams(englishText: tEnglish)); 
      // assert
      expect(result, Left(TranslationFailure()));
    },
  );
}
