import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weatherapp_starter_project/theme/theme.dart';

// ignore: must_be_immutable
class DetailTile extends StatelessWidget {
  String? image;
  String? textInfo;
  String? detail;

  DetailTile(
      {required this.image, required this.textInfo, required this.detail});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 164.w,
      height: 69.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: greyBoxColor),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Image.asset(
              image!,
              width: 24.w,
              height: 24.h,
            ),
            SizedBox(
              width: 12.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  textInfo!,
                  style: blackTextStyle.copyWith(
                      fontSize: 14.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  detail!,
                  style: blackTextStyle.copyWith(fontSize: 10.sp),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
