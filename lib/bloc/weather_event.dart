import 'package:equatable/equatable.dart';
import 'package:weatherapp_starter_project/api/fetch_api.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class FetchWeatherData extends WeatherEvent {
  final WeatherRepository weatherData;

  const FetchWeatherData({required this.weatherData});
}
