import 'package:delosaqua_trial/binds/binding.dart';
import 'package:delosaqua_trial/routes/name.dart';
import 'package:delosaqua_trial/screens/detail/view.dart';
import 'package:delosaqua_trial/screens/list/view.dart';
import 'package:get/get.dart';

class AppRoutes {
  static List<GetPage> getRoutes = [
    GetPage(
      name: Routes.APP,
      page: WeatherListView.new,
      binding: AppBinding(),
    ),
    GetPage(
      name: Routes.DETAIL,
      page: WeatherDetailView.new,
    ),
  ];
}
