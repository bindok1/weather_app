// ignore_for_file: avoid_print, override_on_non_overriding_member

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weatherapp_starter_project/api/fetch_api.dart';
import 'package:weatherapp_starter_project/bloc/weather_event.dart';

import 'package:weatherapp_starter_project/screen/widget/tile/detail_tile.dart';
import 'package:weatherapp_starter_project/screen/widget/tile/weather_tile.dart';

import 'package:weatherapp_starter_project/theme/app_assets.dart';
import 'package:weatherapp_starter_project/theme/date.dart';

import 'package:weatherapp_starter_project/theme/theme.dart';
import 'package:weatherapp_starter_project/weatherModel/weatherDataCurrent.dart';

import '../../bloc/weather_bloc.dart';
import '../../bloc/weather_state.dart';

class DetailScreen extends StatefulWidget {
  final WeatherDataCurrent weatherData;
  final int index;
  final String formattedDate;

  const DetailScreen(
      {super.key,
      required this.weatherData,
      required this.index,
      required this.formattedDate});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  WeatherRepository weatherRepository = WeatherRepository();
  final WeatherBloc _weatherBloc = WeatherBloc();

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
        return "Unknwon Weather"; // jika kode cuaca tidak dikenal, gunakan asset kosong
    }
  }

  @override
  void initState() {
    super.initState();
    _weatherBloc.add(FetchWeatherData(weatherData: weatherRepository));
  }

  @override
  void dispose() {
    _weatherBloc.close();
    super.dispose();
  }

  void getResponse() async {
    try {
      WeatherDataCurrent weatherData = await weatherRepository.fetchData();
      print(weatherData.toString());
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  // ignore: annotate_overrides
  Widget build(BuildContext context) {
    return Scaffold(
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
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        weatherInfo(context, state.weatherData),
                        weatherPerHour(state.weatherData),
                        detailInfo(state.weatherData)
                      ],
                    )
                  ],
                ),
              ),
              onRefresh: () async {
                _weatherBloc
                    .add(FetchWeatherData(weatherData: weatherRepository));
                await Future.delayed(const Duration(seconds: 2));
              });
        } else if (state is WeatherError) {
          return Center(
            child: Text(state.error),
          );
        } else {
          return Container();
        }
      },
    ));
  }

  Widget weatherInfo(context, WeatherDataCurrent weatherData) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.5.h,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff4C7AF0), Color(0xff335FD1)],
              begin: Alignment.topRight,
              end: Alignment.topLeft,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 40.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 24.w,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'The Breeze XXI, BSD',
                      style: primaryTextStyle.copyWith(
                          fontSize: 16.sp, fontWeight: FontWeight.w500),
                    ),
                    Icon(
                      Icons.water_drop_outlined,
                      size: 24.w,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.formattedDate,
                    style: primaryTextStyle.copyWith(
                      fontSize: 14.sp,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 24.h,
              ),
              Column(
                children: [
                  Image.asset(
                    getWeatherAsset(widget
                        .weatherData.current[widget.index].weather![0].icon),
                    width: 80.w,
                    height: 80.h,
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${(weatherData.current[widget.index].main!.temp! - 273.15).toStringAsFixed(1)} C ',
                        style: primaryTextStyle.copyWith(fontSize: 20.sp),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Text(
                        widget.weatherData.current[widget.index].weather![0]
                            .description,
                        style: primaryTextStyle.copyWith(
                            fontSize: 20.sp, fontWeight: FontWeight.w600),
                      )
                    ],
                  )
                ],
              )
            ],
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
          SizedBox(
            height: 8.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (int i = 1; i <= 4; i++)
                if (i < 4)
                  Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: WeatherTile(
                      image: getWeatherAsset(
                          weatherData.current[widget.index].weather![0].icon),
                      temp:
                          '${(weatherData.current[widget.index].main!.temp! - 273.15).toStringAsFixed(1)}º',
                      time: TimePlus.timePlus(3 * i),
                    ),
                  )
                else
                  WeatherTile(
                    image: getWeatherAsset(
                        weatherData.current[widget.index].weather![0].icon),
                    temp:
                        '${(weatherData.current[widget.index].main!.temp! - 273.15).toStringAsFixed(1)}º',
                    time: TimePlus.timePlus(3 * i),
                  ),
            ],
          ),
        ],
      ),
    );
  }

  Widget detailInfo(WeatherDataCurrent weatherData) {
    return Padding(
      padding: EdgeInsets.only(top: 28.h, left: 8.w, right: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Detailed',
            style: blackTextStyle.copyWith(
                fontSize: 20.sp, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 16.h,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DetailTile(
                      image: AppAsset.humidityIcon,
                      textInfo:
                          '${weatherData.current[widget.index].main!.humidity} %',
                      detail: 'Kelembapan'),
                  SizedBox(
                    width: 8.w,
                  ),
                  DetailTile(
                      image: AppAsset.airPressureIcon,
                      textInfo:
                          '${weatherData.current[widget.index].main!.pressure} hPa',
                      detail: 'Tekanan Udara'),
                ],
              ),
              SizedBox(
                height: 16.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DetailTile(
                      image: AppAsset.windSpeedIcon,
                      textInfo:
                          '${weatherData.current[widget.index].wind!.speed} km/h',
                      detail: 'Kecepatan Angin'),
                  SizedBox(
                    width: 8.w,
                  ),
                  DetailTile(
                    image: AppAsset.fogIcon,
                    textInfo: weatherData.current[widget.index].visibility == 0
                        ? 'N/A'
                        : '${(weatherData.current[widget.index].visibility! / 1000).toStringAsFixed(0)} km',
                    detail: 'Visibilitas',
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
