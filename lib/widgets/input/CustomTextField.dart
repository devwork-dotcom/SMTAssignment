import 'package:assignment/theme/ThemeController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String hint;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? errorText;
  final int? maxLines;
  final int? minLines;
  final bool readOnly;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;
  final bool showPasswordToggle;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.title,
    required this.hint,
    required this.keyboardType,
    this.obscureText = false,
    this.errorText,
    this.maxLines = 1,
    this.minLines = 1,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
    this.textInputAction,
    this.onSubmitted,
    this.showPasswordToggle = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Get.find<ThemeController>();


    final isPasswordVisible = obscureText.obs;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title text
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: theme.textColor,
            ),
          ),
          SizedBox(height: 8.h),

          // Text Field
          Obx(() => TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: theme.offWhite,
                fontSize: 14.sp,
              ),
              // Password visibility toggle icon
              suffixIcon: showPasswordToggle ? IconButton(
                icon: Icon(
                  isPasswordVisible.value ? Icons.visibility_off : Icons.visibility,
                  color: theme.offWhite,
                  size: 20.sp,
                ),
                onPressed: () {
                  isPasswordVisible.value = !isPasswordVisible.value;
                },
              ) : null,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.r),
                borderSide: BorderSide(
                  color: theme.iconColor,
                  width: 0.4,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.r),
                borderSide: BorderSide(
                  color: theme.iconColor,
                  width: 0.4,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.r),
                borderSide: BorderSide(
                  color: theme.red,
                  width: 0.4,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.r),
                borderSide: BorderSide(
                  color: theme.red,
                  width: 0.4,
                ),
              ),
              fillColor: theme.white,
              filled: true,
              errorText: errorText,
              errorStyle: TextStyle(
                fontSize: 12.sp,
                color: Colors.red,
                height: 0.8.h,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 12.h,
              ),
            ),
            style: TextStyle(
              fontSize: 14.sp,
              color: theme.textColor,
            ),
            keyboardType: keyboardType,
            cursorColor: theme.textColor,
            obscureText: showPasswordToggle ? isPasswordVisible.value : obscureText,
            maxLines: _getMaxLines(),
            minLines: minLines,
            readOnly: readOnly,
            onTap: onTap,
            onChanged: onChanged,
            textInputAction: textInputAction,
            onFieldSubmitted: onSubmitted,
          )),
        ],
      ),
    );
  }

  int? _getMaxLines() {
    if (keyboardType == TextInputType.multiline) {
      return null;
    }
    return maxLines ?? 1;
  }
}