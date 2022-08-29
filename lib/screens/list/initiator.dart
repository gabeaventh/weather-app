import 'package:core/modules/utility/initiator.dart';
import 'package:delosaqua_trial/screens/list/bloc/weather_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeatherListInitiator extends CoreInitiator {
  late WeatherListBloc _bloc;
  @override
  void dispose() {}

  @override
  void init(BuildContext context) {
    _bloc = Get.find<WeatherListBloc>();
    _bloc.add(WeatherListFetched());
  }

  /// Getters

  WeatherListBloc get bloc => _bloc;
}
