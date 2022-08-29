import 'package:core/core.dart';
import 'package:core/modules/constant/unicode.dart';
import 'package:delosaqua_trial/models/weather_detail.dart';
import 'package:delosaqua_trial/models/weather_list.dart';
import 'package:delosaqua_trial/routes/name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeatherListItems extends StatelessWidget {
  final WeatherList? weatherList;
  const WeatherListItems({
    Key? key,
    this.weatherList,
  }) : super(key: key);

  void onPressed(WeatherDetail? detail) {
    Get.toNamed(Routes.DETAIL, arguments: detail);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: weatherList?.list?.length ?? 0,
      separatorBuilder: (context, index) {
        return const Divider(
          color: Colors.grey,
        );
      },
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => onPressed(weatherList?.list?[index]),
          child: ListTile(
            key: Key("FORECAST-$index"),
            leading: Image.asset(
                'assets/images/${weatherList?.list?[index].weather?.first.icon}@2x.png'),
            title: Text(
              DateTime.parse(weatherList?.list?[index].dtTxt ?? '')
                  .formatToFullTitle(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '${weatherList?.list?[index].weather?.first.main}',
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Temp: ${weatherList?.list?[index].main?.temp}${CharUnicode.DEGREE}C',
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
