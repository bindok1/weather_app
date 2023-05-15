// ignore_for_file: override_on_non_overriding_member, unused_element

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp_starter_project/api/fetch_api.dart';
import 'package:weatherapp_starter_project/bloc/weather_event.dart';
import 'package:weatherapp_starter_project/screen/detail_screen.dart';
import 'package:weatherapp_starter_project/screen/widget/tile/day_to_day_tile.dart';
import 'package:weatherapp_starter_project/screen/widget/tile/weather_tile.dart';

import 'package:weatherapp_starter_project/theme/app_assets.dart';
import 'package:weatherapp_starter_project/theme/date.dart';

import 'package:weatherapp_starter_project/theme/theme.dart';
import 'package:weatherapp_starter_project/weatherModel/weatherDataCurrent.dart';

import '../bloc/weather_bloc.dart';
import '../bloc/weather_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WeatherRepository weatherRepository = WeatherRepository();
  final WeatherBloc _weatherBloc = WeatherBloc();
  Completer<void>? _refreshCompleter;

  String getWeatherAsset(String weatherCode) {
    switch (weatherCode) {
      case "01d":
        return AppAsset.clearSkyD;
      case "01n":
        return AppAsset.clearSkyN;
      case "02d":
        return AppAsset.fewCloudsD;
      case "02n":
        return AppAsset.fewCloudsN;
      case "03d":
        return AppAsset.scatteredCloudsD;
      case "03n":
        return AppAsset.scatteredCloudsN;
      case "04d":
        return AppAsset.brokenCloudsD;
      case "04n":
        return AppAsset.brokenCloudsN;
      case "09d":
        return AppAsset.showerRainD;
      case "09n":
        return AppAsset.showerRainN;
      case "10d":
        return AppAsset.rainD;
      case "10n":
        return AppAsset.rainN;
      case "11d":
        return AppAsset.thunderStormD;
      case "11n":
        return AppAsset.thunderStormN;
      case "13d":
        return AppAsset.snowD;
      case "13n":
        return AppAsset.snowN;
      case "50d":
        return AppAsset.mistD;
      case "50n":
        return AppAsset.mistN;
      default:
        return AppAsset
            .airPressureIcon; // jika kode cuaca tidak dikenal, gunakan asset kosong
    }
  }

  @override
  void initState() {
    super.initState();
    _weatherBloc.add(FetchWeatherData(weatherData: weatherRepository));

    _refreshCompleter = Completer<void>();
  }

  @override
  void dispose() {
    _weatherBloc.close();
    super.dispose();
  }

  void getResponse() async {
    try {
      setState(() {}); // trigger widget to rebuild with new data
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  @override
  Future<void> _refresh() async {
    _refreshCompleter?.complete();
    _refreshCompleter = Completer();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: BlocBuilder<WeatherBloc, WeatherState>(
        bloc: _weatherBloc,
        builder: (context, state) {
          if (state is WeatherLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WeatherLoaded) {
            return RefreshIndicator(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(top: 32.h, left: 4.w, right: 4.w),
                        child: Column(
                          children: [
                            weatherInfo(context, state.weatherData),
                            weatherPerHour(state.weatherData),
                            dayToDay(state.weatherData)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                onRefresh: () async {
                  _weatherBloc
                      .add(FetchWeatherData(weatherData: weatherRepository));
                  await Future.delayed(const Duration(seconds: 1));
                });
          } else if (state is WeatherError) {
            return Center(
              child: Text(state.error),
            );
          } else {
            return Container();
          }
        },
      )),
    );
  }

  Widget weatherInfo(context, WeatherDataCurrent weatherData) {
    int? index;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Row(
            children: [
              Icon(
                Icons.location_on,
                size: 24.w,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                'The Breeze XXI',
                style: blackTextStyle.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 24.h,
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(
                    weatherData: weatherData,
                    index: 0,
                    formattedDate: DateFormat('EEEE, dd MMMM yyyy')
                        .format(DateTime.now())),
              ),
            );
          },
          child: Container(
            width: 343.w,
            height: 193.h,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xff4C7AF0), Color(0xff335FD1)],
                begin: Alignment.topRight,
                end: Alignment.topLeft,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 24.h, left: 24.w, right: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        DateUtil.getFormattedDate(),
                        style: primaryTextStyle,
                      ),
                      const Spacer(),
                      Text(
                        TimeUtil.formatTime(),
                        style: primaryTextStyle,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        getWeatherAsset(
                            weatherData.current[0].weather![0].icon),
                        width: 64.w,
                        height: 64.h,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${(weatherData.current[0].main!.temp! - 273.15).toStringAsFixed(1)}º C ',
                            style: primaryTextStyle.copyWith(fontSize: 20.sp),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            weatherData.current[0].weather![0].main,
                            style: primaryTextStyle.copyWith(
                                fontSize: 20.sp, fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      Text('Swipe down to refresh',
                          style: primaryTextStyle.copyWith(
                              fontSize: 14.sp, fontWeight: FontWeight.w500)),
                      Icon(
                        Icons.refresh_rounded,
                        size: 16.w,
                        color: Colors.white,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget weatherPerHour(WeatherDataCurrent weatherData) {
    return Padding(
      padding: EdgeInsets.only(top: 24.h, left: 8.w, right: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weather Every 3 Hours',
            style: blackTextStyle.copyWith(
                fontSize: 20.sp, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              for (int i = 1; i <= 4; i++)
                if (i < 4)
                  Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: WeatherTile(
                      image: getWeatherAsset(
                          weatherData.current[i].weather![0].icon),
                      temp:
                          '${(weatherData.current[i].main!.temp! - 273.15).toStringAsFixed(1)}º',
                      time: TimePlus.timePlus(3 * i),
                    ),
                  )
                else
                  WeatherTile(
                    image: getWeatherAsset(
                        weatherData.current[i].weather![0].icon),
                    temp:
                        '${(weatherData.current[i].main!.temp! - 273.15).toStringAsFixed(1)}º',
                    time: TimePlus.timePlus(3 * i),
                  ),
            ],
          ),
        ],
      ),
    );
  }

  Widget dayToDay(WeatherDataCurrent weatherData) {
    DateTime today = DateTime.now();
    List<Widget> dayToDayWidgets = [];

    for (int i = 1; i <= 4; i++) {
      DateTime nextDay = today.add(Duration(days: i));
      String formattedDate = DateFormat('EEEE').format(nextDay);

      for (int j = 0; j < weatherData.current.length; j++) {
        DateTime currentDateTime =
            DateTime.parse(weatherData.current[j].dtTxt.toString());
        DateTime currentDate = DateTime(
            currentDateTime.year, currentDateTime.month, currentDateTime.day);

        if (currentDate.day == nextDay.day &&
            currentDate.month == nextDay.month &&
            currentDate.year == nextDay.year) {
          dayToDayWidgets.add(
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(
                      weatherData: weatherData,
                      index: j,
                      formattedDate: formattedDate,
                    ),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DayToDay(
                    image: getWeatherAsset(
                        weatherData.current[j].weather![0].icon),
                    dayPlus: formattedDate,
                    weather: weatherData.current[j].weather![0].description,
                    temp:
                        '${(weatherData.current[j].main!.temp! - 273.15).toStringAsFixed(0)}º C',
                  ),
                ],
              ),
            ),
          );
          break;
        }
      }
    }

    return Padding(
      padding: EdgeInsets.only(top: 24.h, left: 8.w, right: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Daily',
            style: blackTextStyle.copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4.h),
          ...dayToDayWidgets,
        ],
      ),
    );
  }
}
