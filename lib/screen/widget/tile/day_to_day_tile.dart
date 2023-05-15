import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weatherapp_starter_project/theme/theme.dart';

class DayToDay extends StatelessWidget {
  final String? image;
  final String? dayPlus;
  final String? weather;
  final String? temp;

  DayToDay({
    required this.image,
    required this.dayPlus,
    required this.weather,
    required this.temp,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Container(
        width: 343.w,
        height: 80.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: blueColor),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 16, left: 16),
              child: Row(
                children: [
                  Image.asset(
                    image!,
                    width: 40.w,
                    height: 40.h,
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dayPlus!,
                        style: blackTextStyle.copyWith(
                            fontSize: 14.sp, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Text(
                        weather!,
                        style: blackTextStyle.copyWith(fontSize: 13.sp),
                      )
                    ],
                  )
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(top: 16.h, right: 16.w, bottom: 16.w),
              child: Row(
                children: [
                  Text(
                    temp!,
                    style: blackTextStyle.copyWith(
                        fontSize: 14.sp, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  Icon(
                    Icons.arrow_right_outlined,
                    size: 24.h,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
