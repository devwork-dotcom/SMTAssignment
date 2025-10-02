import 'package:assignment/theme/ThemeController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Screen2 extends StatelessWidget {
  const Screen2({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Get.find<ThemeController>();
    return Container(
      padding: EdgeInsets.all(24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/onboarding_2.png",height: 0.8.sw,width: 0.8.sw,),
          SizedBox(height: 24.h),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 0.04.sw),
            child: Text(
              "screen2_title".tr,
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: theme.textColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            "screen2_subTitle".tr,
            style: TextStyle(
              fontSize: 14.sp,
              color: theme.subTextColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}