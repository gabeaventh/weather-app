import 'package:bloc_test/bloc_test.dart';
import 'package:core/modules/env/env.dart';
import 'package:core/modules/network/error/network_error.dart';
import 'package:core/modules/network/error/type.dart';
import 'package:dartz/dartz.dart';
import 'package:delosaqua_trial/screens/list/bloc/weather_list_bloc.dart';
import 'package:delosaqua_trial/screens/list/services/service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'weather_list_bloc_test.mocks.dart';

@GenerateMocks([WeatherListService])
void main() {
  late WeatherListBloc bloc;
  late WeatherListState state;
  late WeatherListService service;
  late Map<String, dynamic> listOfForecast;
  double long = 106.82708842419382;
  double lat = -6.175115064391812;
  String metric = "metric";
  String appId = "appId";
  NetworkError notFound = NetworkError(
    "Not Found",
    NetworkErrorType.notfound,
  );

  setUp(() {
    service = MockWeatherListService();
    state = WeatherListInitial();
    bloc = WeatherListBloc(service: service);
    Env.instance?.initEnv();

    listOfForecast = {
      "cod": "200",
      "message": 0,
      "cnt": 40,
      "list": [
        {
          "dt": 1647345600,
          "main": {
            "temp": 286.88,
            "feels_like": 285.93,
            "temp_min": 286.74,
            "temp_max": 286.88,
            "pressure": 1021,
            "sea_level": 1021,
            "grnd_level": 1018,
            "humidity": 62,
            "temp_kf": 0.14
          },
          "weather": [
            {
              "id": 804,
              "main": "Clouds",
              "description": "overcast clouds",
              "icon": "04d"
            }
          ],
          "clouds": {"all": 85},
          "wind": {"speed": 3.25, "deg": 134, "gust": 4.45},
          "visibility": 10000,
          "pop": 0,
          "sys": {"pod": "d"},
          "dt_txt": "2022-03-15 12:00:00"
        },
        {
          "dt": 1647356400,
          "main": {
            "temp": 286.71,
            "feels_like": 285.77,
            "temp_min": 286.38,
            "temp_max": 286.71,
            "pressure": 1021,
            "sea_level": 1021,
            "grnd_level": 1017,
            "humidity": 63,
            "temp_kf": 0.33
          },
          "weather": [
            {
              "id": 804,
              "main": "Clouds",
              "description": "overcast clouds",
              "icon": "04d"
            }
          ],
          "clouds": {"all": 90},
          "wind": {"speed": 3.34, "deg": 172, "gust": 4.03},
          "visibility": 10000,
          "pop": 0,
          "sys": {"pod": "d"},
          "dt_txt": "2022-03-15 15:00:00"
        },
      ],
      "city": {
        "id": 2643743,
        "name": "London",
        "coord": {"lat": 51.5073, "lon": -0.1277},
        "country": "GB",
        "population": 1000000,
        "timezone": 0,
        "sunrise": 1647324903,
        "sunset": 1647367441
      }
    };
  });

  tearDown(() {
    bloc.close();
  });

  test('Initial state is correct', () {
    expect(state, bloc.state);
  });

  blocTest(
    'Close doesn\'t emit new states',
    build: () => bloc,
    act: (_) => bloc.close(),
    expect: () => [],
  );

  blocTest(
    'when fetchWeatherForecast return [200], should return list of weather forecast',
    build: () => bloc,
    act: (_) {
      when(service.fetchWeatherForecast(
              appId: Env.instance?.apiKey,
              lat: lat.toString(),
              lon: long.toString(),
              metric: metric))
          .thenAnswer(
        (_) async => Left<Response, NetworkError>(
          Response(
            data: listOfForecast,
            statusCode: 200,
            requestOptions: RequestOptions(
              method: 'GET',
              baseUrl: 'https://api.openweathermap.org/data/2.5',
              path: 'forecast?lat=$lat&lon=$long&appid=$appId&units=$metric',
            ),
          ),
        ),
      );

      bloc.add(WeatherListFetched());
    },
    expect: () => [
      WeatherListLoading(),
      isA<WeatherListLoaded>(),
    ],
  );

  blocTest(
    'when fetchWeatherForecast return [404], should return list of weather forecast',
    build: () => bloc,
    act: (_) {
      when(service.fetchWeatherForecast(
              appId: Env.instance?.apiKey,
              lat: lat.toString(),
              lon: long.toString(),
              metric: metric))
          .thenAnswer(
        (_) async => Right<Response, NetworkError>(
          NetworkError(
            "Not Found",
            NetworkErrorType.notfound,
          ),
        ),
      );

      bloc.add(WeatherListFetched());
    },
    expect: () => [
      WeatherListLoading(),
      WeatherListError(error: notFound),
    ],
  );
}
