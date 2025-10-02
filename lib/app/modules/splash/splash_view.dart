import 'package:assignment/theme/ThemeController.dart';
import 'package:assignment/widgets/progress%20dailog/dot_circular_progress_dailog.dart';
import 'package:assignment/widgets/progress%20dailog/dot_progress_dailog_withColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Get.find<ThemeController>();
    return Obx((){
      theme.updateSystemUI();
      return Scaffold(
        backgroundColor: theme.background,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 0.2.sh),
              SvgPicture.asset('assets/car.svg',color: theme.blue,),
              Center(
                child: Text(
                  "theory".tr,
                  style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: theme.textColor),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.12.sw),
                  child: Text(
                    "theory_description".tr,
                    style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.normal, color: theme.textColor),
                    textAlign: TextAlign.center,
                  ),

                ),
              ),


              Spacer(),


              DotCircularProgressIndicator(
                size: 50.w,
                dotColor: theme.blue,
                numberOfDots: 8,
                startAngle: -90.0,
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      );
    });
  }
}
