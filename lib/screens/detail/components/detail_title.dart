import 'package:flutter/material.dart';
import 'package:theme/space/space.dart';

class WeatherDetailTitle extends StatelessWidget {
  final String date;
  final String time;
  const WeatherDetailTitle({
    Key? key,
    required this.date,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          date,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Space.x20,
          ),
        ),
        Text(
          time,
          style: const TextStyle(
            fontSize: Space.x20,
          ),
        ),
      ],
    );
  }
}
