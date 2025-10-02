import 'package:assignment/theme/ThemeController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PasswordStrengthIndicator extends StatelessWidget {
  final int score;
  final String status;

  const PasswordStrengthIndicator({
    super.key,
    required this.score,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Get.find<ThemeController>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 4 strength bars - flex 3
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    _buildStrengthBar(1, theme, score),
                    SizedBox(width: 4.w),
                    _buildStrengthBar(2, theme, score),
                    SizedBox(width: 4.w),
                    _buildStrengthBar(3, theme, score),
                    SizedBox(width: 4.w),
                    _buildStrengthBar(4, theme, score),
                  ],
                ),
              ),

              // Status text - flex 1
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          _getStatusDescription(score),
                          style: TextStyle(
                            color: _getTextColor(score, theme),
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStrengthBar(int barNumber, ThemeController theme, int score) {
    final isActive = barNumber <= score;

    return Expanded(
      child: Container(
        height: 2.h,
        decoration: BoxDecoration(
          color: isActive ? _getBarColor(score, theme) : theme.offGreyWhite,
          borderRadius: BorderRadius.circular(2.r),
        ),
      ),
    );
  }

  Color _getBarColor(int score, ThemeController theme) {
    switch (score) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 3:
        return theme.blue; // Your theme blue color
      case 4:
        return Colors.green;
      default:
        return theme.offGreyWhite;
    }
  }

  Color _getTextColor(int score, ThemeController theme) {
    switch (score) {
      case 0:
        return theme.subTextColor;
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 3:
        return theme.blue; // Your theme blue color
      case 4:
        return Colors.green;
      default:
        return theme.subTextColor;
    }
  }

  String _getStatusDescription(int score) {
    switch (score) {
      case 0:
        return '';
      case 1:
        return 'weak'.tr;
      case 2:
        return 'medium'.tr;
      case 3:
        return 'strong'.tr;
      case 4:
        return 'very_strong'.tr;
      default:
        return '';
    }
  }
}