import 'package:flutter_test/flutter_test.dart';
import 'package:it_round/core/error/exceptions.dart';
import 'package:it_round/core/external_apis/google_translate_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:translator/translator.dart' as translator;

class MockGoogleTranslator extends Mock implements translator.GoogleTranslator {} 
class MockTranslation extends Mock implements translator.Translation {}

void main() {
  late MockGoogleTranslator mockGoogleTranslator; 
  late GoogleTranslateAPIImpl sut;

  setUp(() {
    mockGoogleTranslator = MockGoogleTranslator(); 
    sut = GoogleTranslateAPIImpl(mockGoogleTranslator);
  });

  const tEnglish = "Hello"; 
  const tRussian = "Привет"; 

  group('fromEnglishToRussian', () {
    test(
      "should call translator with proper args and return the result",
      () async {
        // arrange
        final translation = MockTranslation(); 
        when(() => translation.text)
          .thenReturn(tRussian); 
        when(() => mockGoogleTranslator.translate(tEnglish, from: 'en', to: 'ru'))
          .thenAnswer((_) async => translation); 
        // act
        final result = await sut.fromEnglishToRussian(tEnglish); 
        // assert
        expect(result, tRussian); 
        verify(() => mockGoogleTranslator.translate(tEnglish, from: 'en', to: 'ru')); 
        verifyNoMoreInteractions(mockGoogleTranslator); 
      },
    );
    test(
      "should throw TranslationException if translator threw something",
      () async {
        // arrange
        when(() => mockGoogleTranslator.translate(any()))
          .thenThrow(Exception()); 
        // assert
        expect(() => sut.fromEnglishToRussian(tEnglish), throwsA(TypeMatcher<TranslationException>())); 
      },
    );
  });
}
