import 'package:assignment/app/modules/auth/forgot%20password/forgot_controller.dart';
import 'package:assignment/theme/ThemeController.dart';
import 'package:assignment/widgets/button/circular_back_button.dart';
import 'package:assignment/widgets/button/elevated_button.dart';
import 'package:assignment/widgets/input/CustomTextField.dart';
import 'package:assignment/widgets/input/PasswordIndicator.dart';
import 'package:assignment/widgets/otp_verification/otp_verification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OtpVerify extends GetView<ForgotPassController> {
  const OtpVerify({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Get.find<ThemeController>();

      theme.updateSystemUI();

      return Scaffold(
        backgroundColor: theme.background,
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                CircularBackButton(onTap: (){
                  controller.navigateToForgotPassword();
                }),
                SizedBox(height: 0.02.sw,),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                  child: Center(
                    child: Text(
                      'forgot_password'.tr,
                      style: TextStyle(
                        color: theme.textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 28.sp,
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.19.sw,),
                  child: Center(
                    child: Text(
                      '${'forgot_subTitle'.tr} ${controller.email.value}',
                      style: TextStyle(
                        color: theme.subTextColor,
                        fontWeight: FontWeight.normal,
                        fontSize: 15.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                SizedBox(height: 0.05.sh),

                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 0.1.sw),
                  child: OTPVerification(
                    length: 4,
                    obscureText: true,
                    onCompleted: (otp) {
                      controller.verifyOTP(otp);

                    },
                  ),
                ),
                SizedBox(height: 0.05.sh),

                Center(
                  child: Obx(() {
                    return controller.canResend.value
                        ? GestureDetector(
                      onTap: controller.resendOTP,
                      child: Text(
                        'Resend Code',
                        style: TextStyle(
                          color: theme.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                        ),
                      ),
                    )
                        : Text(
                      'Resend Code in ${controller.getFormattedCountdown()}',
                      style: TextStyle(
                        color: theme.subTextColor,
                        fontWeight: FontWeight.normal,
                        fontSize: 15.sp,
                      ),
                    );
                  }),
                ),


              ],
            ),
          ),
        ),
      );

  }
}