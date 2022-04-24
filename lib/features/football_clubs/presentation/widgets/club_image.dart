import 'package:flutter/material.dart';

class ClubImage extends StatelessWidget {
  final String? imageUrl; 
  final double size; 
  const ClubImage({ 
    required this.imageUrl,
    required this.size, 
    Key? key 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => imageUrl == null ? 
      SizedBox(
        width: size, 
        height: size,
        child: Icon(Icons.image_not_supported, size: 0.5*size),
      ) 
    : 
      Image.network(
        imageUrl!, 
        width: size
      );
}