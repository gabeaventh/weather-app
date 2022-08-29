part of 'weather_list_bloc.dart';

abstract class WeatherListState extends Equatable {}

class WeatherListInitial extends WeatherListState {
  @override
  List<Object?> get props => [];
}

class WeatherListLoading extends WeatherListState {
  @override
  List<Object?> get props => [];
}

class WeatherListLoaded extends WeatherListState {
  final WeatherList weatherList;
  WeatherListLoaded({required this.weatherList});

  @override
  List<Object?> get props => [weatherList];
}

class WeatherListError extends WeatherListState {
  final NetworkError? error;

  WeatherListError({this.error});

  @override
  List<Object?> get props => [];
}
