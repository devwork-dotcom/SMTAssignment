import 'package:assignment/theme/ThemeController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CircularBackButton extends StatelessWidget {
  final VoidCallback onTap;

  const CircularBackButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Get.find<ThemeController>();
    return GestureDetector(
      onTap: onTap,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 15.h,vertical: 10.h),
          child: Container(
            height: 0.08.sw,
            width: 0.08.sw,
            decoration: BoxDecoration(
              color: theme.background,
              shape: BoxShape.circle,
              border: Border.all(
                color: theme.iconColor,
                width: 0.1,
              ),
            ),
            child:  Center(
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 0.04.sw,
                color: theme.iconColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
