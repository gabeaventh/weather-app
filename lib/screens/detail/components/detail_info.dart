import 'package:flutter/material.dart';
import 'package:theme/space/space.dart';

class WeatherDetailInfo extends StatelessWidget {
  final String temp;
  final String imagePath;
  final String description;
  const WeatherDetailInfo({
    Key? key,
    required this.temp,
    required this.imagePath,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              temp,
              style: const TextStyle(
                fontSize: Space.x32,
              ),
            ),
            Image.network(
              imagePath,
              width: Space.x100,
              height: Space.x100,
            )
          ],
        ),
        Text(
          description,
          style: const TextStyle(
            fontSize: Space.x14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
