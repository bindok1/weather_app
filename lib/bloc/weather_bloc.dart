// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:weatherapp_starter_project/bloc/weather_event.dart';
import 'package:weatherapp_starter_project/bloc/weather_state.dart';

import '../api/fetch_api.dart';
import '../weatherModel/weatherDataCurrent.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository _weatherRepository = WeatherRepository();

  WeatherBloc() : super(WeatherInitial()) {
  on<FetchWeatherData>((event, emit) async {
    emit(WeatherLoading());
    try {
      final WeatherDataCurrent weatherData =
          await _weatherRepository.fetchData();
      // ignore: unnecessary_null_comparison
      if (weatherData.current != null) {
        emit(WeatherLoaded(weatherData:weatherData ));
      } else {
        emit(const WeatherError(error: "Data is empty"));
      }
    } catch (e) {
      emit(WeatherError(error: e.toString()));
    }
  });
}


  @override
  void onEvent(WeatherEvent event) {
    super.onEvent(event);
    print(event);
  }

  @override
  void onChange(Change<WeatherState> change) {
    super.onChange(change);
    print(change);
  }

  @override
  void onTransition(Transition<WeatherEvent, WeatherState> transition) {
    super.onTransition(transition);
    print(transition);
  }
}
