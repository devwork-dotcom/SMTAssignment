import 'package:assignment/theme/ThemeController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomDialog extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback onButtonPressed;
  final Color? buttonColor;
  final Color? buttonTextColor;

  const CustomDialog({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.onButtonPressed,
    this.buttonColor,
    this.buttonTextColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Get.find<ThemeController>();

    return Dialog(
      backgroundColor: theme.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Container(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  width: 30.w,
                  height: 30.w,
                  child: Icon(
                    Icons.close,
                    color: theme.textColor,
                    size: 18.sp,
                  ),
                ),
              ),
            ),

            // Image
            Container(
              width: 0.6.sw,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
              ),
            ),

            // Title
            Text(
              title,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: theme.textColor,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 2.h),

            // Subtitle
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 13.sp,
                color: theme.subTextColor,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 24.h),

            // Elevated Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onButtonPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.blue,
                  foregroundColor: theme.button_text_color,
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  buttonText,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Static method to show dialog
  static void show({
    required String imagePath,
    required String title,
    required String subtitle,
    required String buttonText,
    required VoidCallback onButtonPressed,
    Color? buttonColor,
    Color? buttonTextColor = Colors.white,
    bool barrierDismissible = true,
  }) {
    Get.dialog(
      CustomDialog(
        imagePath: imagePath,
        title: title,
        subtitle: subtitle,
        buttonText: buttonText,
        onButtonPressed: onButtonPressed,
        buttonColor: buttonColor,
        buttonTextColor: buttonTextColor,
      ),
      barrierDismissible: barrierDismissible,
    );
  }
}