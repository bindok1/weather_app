import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weatherapp_starter_project/theme/theme.dart';

class WeatherTile extends StatelessWidget {
  final String image;
  final String temp;
  final String time;
  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  WeatherTile({required this.image, required this.temp, required this.time});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 78.w,
      height: 106.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4), color: greyBoxColor),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: Image.asset(
              image,
              width: 40.w,
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          Text(
            temp,
            style: blackTextStyle.copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            time,
            style: blackTextStyle,
          )
        ],
      ),
    );
  }
}
