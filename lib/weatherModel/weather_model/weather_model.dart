import 'city.dart';
import 'list.dart';

class WeatherModel {
  String? cod;
  int? message;
  int? cnt;
  List? list;
  City? city;

  WeatherModel({this.cod, this.message, this.cnt, this.list, this.city});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cod: json['cod'] as String?,
      message: json['message'] as int?,
      cnt: json['cnt'] as int?,
      list: (json['list'])
          ?.map((e) => e.fromJson(e as Map<String, dynamic>))
          .toList(),
      city: json['city'] == null
          ? null
          : City.fromJson(json['city'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cod': cod,
      'message': message,
      'cnt': cnt,
      'list': list,
      'city': city?.toJson(),
    };
  }
}
