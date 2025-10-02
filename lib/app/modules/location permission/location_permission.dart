import 'package:assignment/app/modules/location%20permission/location_controller.dart';
import 'package:assignment/theme/ThemeController.dart';
import 'package:assignment/widgets/button/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LocationPermission extends GetView<LocationPermissionController> {
  const LocationPermission({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Get.find<ThemeController>();

    return Obx(() {
      theme.updateSystemUI();

      return Scaffold(
        backgroundColor: theme.background,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 0.04.sh),
              Center(child: Image.asset('assets/Maps.png')),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 0.02.sw),
                child: Text(
                  'enable_location_title'.tr,
                  style: TextStyle(
                    color: theme.textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 28.sp,
                  ),
                ),
              ),

              Padding(
                padding:EdgeInsets.symmetric(vertical: 0.02.sw,horizontal: 0.1.sw),
                child: Text(
                  'enable_location_description'.tr,
                  style: TextStyle(
                    color: theme.subTextColor,
                    fontWeight: FontWeight.normal,
                    fontSize: 14.sp,
                  ),
                  textAlign: TextAlign.center,
                ),

              ),

              elevatedButton(
                  text: "enable_button".tr,
                onTap: () async {
                  await controller.requestLocationPermission();
                },
              ),

              Padding(
                padding:EdgeInsets.symmetric(vertical: 0.02.sw,horizontal: 0.1.sw),
                child: GestureDetector(
                  onTap: (){
                    controller.navigateToLanguageSelection();
                  },
                  child: Text(
                    'skip_button'.tr,
                    style: TextStyle(
                      color: theme.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

              ),



              SizedBox(height: 40.h),
            ],
          ),
        ),
      );
    });
  }
}