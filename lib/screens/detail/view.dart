import 'package:core/core.dart';
import 'package:core/modules/constant/unicode.dart';
import 'package:core/modules/constant/widget_key.dart';
import 'package:delosaqua_trial/models/weather_detail.dart';
import 'package:delosaqua_trial/screens/detail/components/detail_info.dart';
import 'package:delosaqua_trial/screens/detail/components/detail_temp.dart';
import 'package:delosaqua_trial/screens/detail/components/detail_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:theme/space/space.dart';

class WeatherDetailView extends StatefulWidget {
  const WeatherDetailView({
    Key? key,
  }) : super(key: key);

  @override
  State<WeatherDetailView> createState() => _WeatherDetailViewState();
}

class _WeatherDetailViewState extends State<WeatherDetailView> {
  late WeatherDetail _weatherDetail;
  @override
  void initState() {
    _weatherDetail = Get.arguments ?? WeatherDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: WidgetKey.DETAIL_APP_BAR,
        title: const Text('Weather Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Space.x24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              WeatherDetailTitle(
                key: WidgetKey.DETAIL_TITLE,
                date: DateTime.parse(_weatherDetail.dtTxt ?? '')
                    .formatToShortTitle(),
                time: DateTime.parse(_weatherDetail.dtTxt ?? '')
                    .formatToShortTime(),
              ),
              WeatherDetailInfo(
                key: WidgetKey.DETAIL_INFO,
                temp:
                    "${_weatherDetail.main?.temp.toString() ?? ''}${CharUnicode.DEGREE}C",
                imagePath:
                    "https://openweathermap.org/img/wn/${_weatherDetail.weather?.first.icon}@4x.png",
                description:
                    "${_weatherDetail.weather?.first.main} (${_weatherDetail.weather?.first.description ?? ''})",
              ),
              const SizedBox(
                height: Space.x32,
              ),
              WeatherDetailTemp(
                key: WidgetKey.DETAIL_TEMP,
                tempMin:
                    "${_weatherDetail.main?.tempMin.toString() ?? ''}${CharUnicode.DEGREE}C",
                tempMax:
                    "${_weatherDetail.main?.tempMax.toString() ?? ''}${CharUnicode.DEGREE}C",
              )
            ],
          ),
        ),
      ),
    );
  }
}
