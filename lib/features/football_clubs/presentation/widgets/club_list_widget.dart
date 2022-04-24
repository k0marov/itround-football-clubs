import 'package:flutter/material.dart';

import '../../domain/entities/club_entity.dart';
import 'club_widget.dart';

class ClubListWidget extends StatelessWidget {
  final List<Club> clubList; 
  const ClubListWidget({ 
    required this.clubList, 
    Key? key 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => 
    SingleChildScrollView(
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: clubList
          .map((club) => ClubWidget(club: club))
          .toList()
      ),
    );
}
