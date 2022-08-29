import 'package:delosaqua_trial/screens/detail/components/temp_container.dart';
import 'package:flutter/material.dart';

class WeatherDetailTemp extends StatelessWidget {
  final String tempMin;
  final String tempMax;
  const WeatherDetailTemp({
    Key? key,
    required this.tempMin,
    required this.tempMax,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TempContainer(
          temp: tempMin,
          title: 'Temp (Min)',
        ),
        TempContainer(
          temp: tempMax,
          title: 'Temp (Max)',
        ),
      ],
    );
  }
}
