import 'package:flutter/material.dart';
import 'package:it_round/core/usecases/get_russian_translation.dart';
import 'package:it_round/di.dart';
import 'package:it_round/features/football_clubs/domain/entities/club_entity.dart';

class ClubDetailWidget extends StatelessWidget {
  final Club club; 
  const ClubDetailWidget({ 
    required this.club, 
    Key? key 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
        SizedBox(height: 20), 
        if (club.imageUrl != null) 
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 400, maxHeight: 400), 
            child: Image.network(
              club.imageUrl!, 
              width: 400, 
              height: 400,
            ), 
          ), 
        Text(
          club.title, 
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium
        ), 
        SizedBox(height: 10), 
        if (club.description != null)
          ClubDescription(description: club.description!)
    ]);
  }
}

enum TranslationState {
  english, 
  fetchingRussian, 
  russian, 
}
class ClubDescription extends StatefulWidget {
  final String description; 
  const ClubDescription({ 
    required this.description, 
    Key? key 
  }) : super(key: key);

  @override
  State<ClubDescription> createState() => _ClubDescriptionState();
}

class _ClubDescriptionState extends State<ClubDescription> {
  TranslationState _translationState = TranslationState.english; 

  late String _currentDescription; 
  @override
  void initState() {
    _currentDescription = widget.description;
    super.initState();
  }

  void _fetchRussianTranslation() async {
    setState(() => _translationState = TranslationState.fetchingRussian); 
    final translationResult = await sl<GetRussianTranslation>()(
      TranslationParams(englishText: widget.description)
    );
    translationResult.fold(
      (failure) => _currentDescription = "Произшла ошибка перевода.", 
      (translatedDescription) => _currentDescription = translatedDescription
    ); 
    setState(() => _translationState = TranslationState.russian); 
  }

  void _rollBackToEnglish() {
    _currentDescription = widget.description; 
    _translationState = TranslationState.english; 
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => Column(children: [
      if (_translationState == TranslationState.russian) 
        TextButton(
          child: Text("Display in English"), 
          onPressed: _rollBackToEnglish,
        ),
      if (_translationState != TranslationState.russian)
        TextButton(
          child: Text("Перевести на русский"), 
          onPressed: _fetchRussianTranslation, 
        ), 
      Padding(
        padding: const EdgeInsets.all(15),
        child: _translationState == TranslationState.fetchingRussian ? 
          CircularProgressIndicator()
        : SelectableText(
            _currentDescription, 
            style: Theme.of(context).textTheme.bodyLarge
          )
      ), 
    ]); 
}