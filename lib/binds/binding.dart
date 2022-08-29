import 'package:delosaqua_trial/screens/list/bloc/weather_list_bloc.dart';
import 'package:delosaqua_trial/screens/list/services/service.dart';
import 'package:get/get.dart';

/// usualy the bindings is seperated per module/feature/screen
/// in this case, for a small app, ill combine this to one binding class
class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WeatherListService>(WeatherListService.new);
    Get.lazyPut<WeatherListBloc>(WeatherListBloc.new);
  }
}
