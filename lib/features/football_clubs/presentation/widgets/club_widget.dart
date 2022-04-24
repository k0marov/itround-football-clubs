import 'package:flutter/material.dart';
import 'package:it_round/features/football_clubs/presentation/widgets/club_image.dart';

import '../../domain/entities/club_entity.dart';
import '../pages/club_detail_page.dart';

class ClubWidget extends StatelessWidget {
  final Club club; 
  const ClubWidget({ 
    required this.club, 
    Key? key 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(Radius.circular(25)); 
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: borderRadius
      ),
      color: Colors.grey.shade100, 
      child: InkWell(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ClubDetailPage(club: club)
        )),
        borderRadius: borderRadius,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            width: 200, 
            child: Column(children: [
              ClubImage(
                imageUrl: club.imageUrl, 
                size: 200, 
              ),
              SizedBox(height: 10), 
              Text(club.title)
            ]),
          ),
        ),
      ),
    ); 
  }
}