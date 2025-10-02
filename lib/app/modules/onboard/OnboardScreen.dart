import 'package:assignment/theme/ThemeController.dart';
import 'package:assignment/widgets/button/elevated_button.dart';
import 'package:assignment/widgets/onboard/screen2.dart';
import 'package:assignment/widgets/onboard/screen1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'onboard_controller.dart';

class OnboardScreen extends GetView<OnboardController> {
  const OnboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme =Get.find<ThemeController>();
    return Obx((){
      theme.updateSystemUI();
      return WillPopScope(
        onWillPop: controller.onWillPop,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: controller.pageController,
                    onPageChanged: controller.onPageChanged,
                    children: const [
                      Screen1(),
                      Screen2(),
                    ],
                  ),
                ),


                Container(
                  padding: EdgeInsets.all(14.w),
                  child: Column(
                    children: [
                      SmoothPageIndicator(
                        controller: controller.pageController,
                        count: 2,
                        effect: WormEffect(
                          activeDotColor: theme.blue,
                          dotColor: theme.greyWhite,
                          dotHeight: 6.h,
                          dotWidth: 6.h,
                        ),
                      ),

                      SizedBox(height: 24.h),
                      elevatedButton(text: controller.buttonText, onTap: controller.navigateToNext),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      );
    });
  }
}