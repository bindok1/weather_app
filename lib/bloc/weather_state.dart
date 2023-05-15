import 'package:equatable/equatable.dart';
import 'package:weatherapp_starter_project/weatherModel/weatherDataCurrent.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

// ignore: must_be_immutable
class WeatherLoaded extends WeatherState {
  WeatherDataCurrent weatherData;

  WeatherLoaded({required this.weatherData});

  @override
  List<Object> get props => [weatherData];
}

class WeatherError extends WeatherState {
  final String error;

  const WeatherError({required this.error});

  @override
  List<Object> get props => [error];
}
