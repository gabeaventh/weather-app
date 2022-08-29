import 'package:flutter/material.dart';
import 'package:theme/space/space.dart';

class TempContainer extends StatelessWidget {
  final String temp;
  final String title;
  const TempContainer({
    Key? key,
    required this.temp,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: Space.x14,
          ),
        ),
        const SizedBox(
          height: Space.x8,
        ),
        Text(
          temp,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Space.x14,
          ),
        ),
      ],
    );
  }
}
