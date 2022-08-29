import 'package:core/modules/network/error/network_error.dart';
import 'package:core/modules/network/rest_service.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class WeatherListService extends CoreRestService {
  Future<Either<Response, NetworkError>> fetchWeatherForecast({
    String? lat,
    String? lon,
    String? appId,
    String? metric,
  }) {
    return network.get(
      path: 'forecast?lat=$lat&lon=$lon&appid=$appId&units=$metric',
    );
  }
}
