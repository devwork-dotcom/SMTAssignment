import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CountryListItem extends StatelessWidget {
  final String flag;
  final String countryName;
  final bool isSelected;
  final VoidCallback onTap;
  final Color selectedBackgroundColor;
  final Color selectedBorderColor;
  final Color selectedButtonColor;
  final Color textColor;
  final Color unselectedButtonColor;
  final Color unselectedBorderColor;

  const CountryListItem({
    super.key,
    required this.flag,
    required this.countryName,
    required this.isSelected,
    required this.onTap,
    this.selectedBackgroundColor = const Color(0xfff8f9fa),
    this.selectedBorderColor = const Color(0xff007AFF),
    this.selectedButtonColor = const Color(0xff007AFF),
    this.textColor = const Color(0xff333333),
    this.unselectedButtonColor = const Color(0xfff5f5f5),
    this.unselectedBorderColor = const Color(0xff6c757d),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color: isSelected ? selectedBackgroundColor : Colors.transparent,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isSelected ? selectedBorderColor : Colors.transparent,
          width: isSelected ? 0.2 : 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12.r),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(12.r),
            child: Row(
              children: [
                // Flag
                Container(
                  width: 32.w,
                  height: 32.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Center(
                    child: Text(
                      flag,
                      style: TextStyle(fontSize: 20.sp),
                    ),
                  ),
                ),

                SizedBox(width: 12.w),

                // Country name
                Expanded(
                  child: Text(
                    countryName,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                SizedBox(width: 12.w),

                // Select/Selected button
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: isSelected ? selectedButtonColor : unselectedButtonColor,
                    borderRadius: isSelected
                        ? BorderRadius.circular(20.r)
                        : BorderRadius.circular(7.r),
                    border: Border.all(
                      color: isSelected ? selectedButtonColor : unselectedBorderColor.withOpacity(0.5),
                      width: isSelected ? 1 : 0.5,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isSelected)
                        Padding(
                          padding: EdgeInsets.only(right: 4.w),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 16.sp,
                          ),
                        ),
                      Text(
                        isSelected ? "selected".tr : "select".tr,
                        style: TextStyle(
                          color: isSelected ? Colors.white : textColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}