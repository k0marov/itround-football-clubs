import 'package:flutter/material.dart';
import 'package:it_round/core/error/failures.dart';

class FailureWidget extends StatelessWidget {
  final Failure failure; 
  const FailureWidget({ 
    required this.failure, 
    Key? key 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Oops, some error happened.\n" 
          "Probably, there is no data to show about this league."
        ),
        SizedBox(height: 10),
        TextButton(
          child: Text("Go back"), 
          onPressed: () => Navigator.of(context).pop(),
        )
      ],
    ); 
  }
}