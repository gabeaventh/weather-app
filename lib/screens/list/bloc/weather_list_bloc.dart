import 'package:bloc/bloc.dart';
import 'package:core/modules/env/env.dart';
import 'package:core/modules/network/error/network_error.dart';
import 'package:delosaqua_trial/models/weather_list.dart';
import 'package:delosaqua_trial/screens/list/services/service.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'weather_list_event.dart';
part 'weather_list_state.dart';

class WeatherListBloc extends Bloc<WeatherListEvent, WeatherListState> {
  final WeatherListService _service;

  WeatherListBloc({WeatherListService? service})
      : _service = service ?? Get.find<WeatherListService>(),
        super(WeatherListInitial()) {
    on<WeatherListEvent>((event, emit) async {
      double long = 106.82708842419382;
      double lat = -6.175115064391812;
      String metric = "metric";
      emit(WeatherListLoading());
      await _service
          .fetchWeatherForecast(
            appId: Env.instance?.apiKey,
            lat: lat.toString(),
            lon: long.toString(),
            metric: metric,
          )
          .then(
            ((res) => emit(
                  res.fold(
                    (response) => WeatherListLoaded(
                      weatherList: WeatherList.fromJson(response.data),
                    ),
                    (error) => WeatherListError(
                      error: NetworkError(error.message),
                    ),
                  ),
                )),
          );
    });
  }
}
