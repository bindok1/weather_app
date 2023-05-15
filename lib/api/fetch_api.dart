
// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:weatherapp_starter_project/api/api_key.dart';

import '../weatherModel/weatherDataCurrent.dart';

class WeatherRepository {
  Future<WeatherDataCurrent> fetchData() async {
    try {
      var dResponse = await Dio().get(apiUrl.toString());

      final WeatherDataCurrent weatherData =
          WeatherDataCurrent.fromJson(dResponse.data);

      return weatherData;
    } catch (e) {
      print(e.toString());

      throw Exception(
          "Failed to fetch weather data. Please check your internet connection and try again.");
    }
  }
}



 // final dResponse = await Dio().get(apiUrl);
      // print(dResponse.data);
      // if (dResponse.statusCode == 200) {
      //   return WetModel.fromJson(jsonDecode(dResponse.data));
      // } else {
      //   throw Exception('Error etch data');
      // }


        // Future<List<Weather>> fetchWeatherData() async {
  //   try {
  //     final response = await Dio().get(apiUrl.toString());

  //     final List<dynamic> weatherList = response.data['list'];

  //     List<Weather> weatherDataNew = [];

  //     for (var weather in weatherList) {
  //       final mainData = weather['main'];
  //       final weatherDataList = weather['weather'] as List<dynamic>;
  //       final weatherDataItem = weatherDataList[0];
  //       final weatherData = Weather(
  //         id: mainData['id'],
  //         description: weatherDataItem['description'],
  //         main: weatherDataItem['main'],
  //         icon: weather['icon'],
  //       );

  //       weatherDataNew.add(weatherData);
  //     }

  //     return weatherDataNew;
  //   } catch (e) {
  //     throw Exception('error saat ambil data api');
  //   }
  // }
