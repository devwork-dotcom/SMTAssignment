import 'package:assignment/theme/ThemeController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class elevatedButton extends StatelessWidget {

  final String text;
  final VoidCallback onTap;
  final bool isEnabled;

  const elevatedButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Get.find<ThemeController>();
    return Padding(
      padding: EdgeInsets.all(0.04.sw),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: isEnabled ? onTap : null,
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
            text.tr,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}