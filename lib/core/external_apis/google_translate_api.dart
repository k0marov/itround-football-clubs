import 'package:it_round/core/error/exceptions.dart';
import 'package:it_round/core/error/failures.dart';
import 'package:translator/translator.dart';

abstract class GoogleTranslateAPI {
  Future<String> fromEnglishToRussian(String englishText); 
}

class GoogleTranslateAPIImpl extends GoogleTranslateAPI {
  final GoogleTranslator _translator;
  GoogleTranslateAPIImpl(this._translator); 

  /// throws [TranslationException] if something failed
  @override
  Future<String> fromEnglishToRussian(String englishText) async {
    try {
      final translation = await _translator.translate(englishText, from: "en", to: "ru");
      return translation.text; 
    } catch (e) {
      throw TranslationException(); 
    }
  }
}