import 'package:core/modules/constant/widget_key.dart';
import 'package:delosaqua_trial/screens/list/bloc/weather_list_bloc.dart';
import 'package:delosaqua_trial/screens/list/components/weather_list_items.dart';
import 'package:delosaqua_trial/screens/list/initiator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherListView extends StatefulWidget {
  const WeatherListView({Key? key}) : super(key: key);

  @override
  State<WeatherListView> createState() => _WeatherListViewState();
}

class _WeatherListViewState extends State<WeatherListView> {
  late WeatherListInitiator _i;

  @override
  void initState() {
    _i = WeatherListInitiator()..init(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: WidgetKey.LIST_APP_BAR,
        title: const Text('Weather App'),
      ),
      body: BlocConsumer(
        bloc: _i.bloc,
        listener: (context, state) {
          if (state is WeatherListError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error?.message ?? ''),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is WeatherListLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WeatherListLoaded) {
            return WeatherListItems(weatherList: state.weatherList);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
