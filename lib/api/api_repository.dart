import 'package:weatherapp_starter_project/api/fetch_api.dart';
import 'package:weatherapp_starter_project/weatherModel/weatherDataCurrent.dart';


class ApiRepository {
  final provider = WeatherRepository();
  Future<WeatherDataCurrent> fetchWeatherData() {
    return provider.fetchData();
  }
}
