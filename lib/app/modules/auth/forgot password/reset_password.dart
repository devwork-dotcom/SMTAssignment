import 'package:assignment/app/modules/auth/forgot%20password/forgot_controller.dart';
import 'package:assignment/theme/ThemeController.dart';
import 'package:assignment/widgets/button/circular_back_button.dart';
import 'package:assignment/widgets/button/elevated_button.dart';
import 'package:assignment/widgets/input/CustomTextField.dart';
import 'package:assignment/widgets/input/PasswordIndicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ResetPassword extends GetView<ForgotPassController> {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Get.find<ThemeController>();

    return Obx(() {
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
                      'reset_password'.tr,
                      style: TextStyle(
                        color: theme.textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 28.sp,
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w,),
                  child: Text(
                    'reset_subTitle'.tr,
                    style: TextStyle(
                      color: theme.subTextColor,
                      fontWeight: FontWeight.normal,
                      fontSize: 15.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                SizedBox(height: 0.03.sh),










                CustomTextField(
                  controller: controller.newPasswordController,
                  title: "new_password".tr,
                  hint: "New Password",
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !controller.isPasswordVisible.value,
                  showPasswordToggle: true,
                ),
                CustomTextField(
                  controller: controller.confirmPasswordController,
                  title: "confirm_password".tr,
                  hint: "Confirm Password",
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !controller.isPasswordVisible.value,
                  showPasswordToggle: true,
                ),




                SizedBox(height: 20.h),

                elevatedButton(
                  text: "Submit".tr,
                  onTap: controller.resetPassword,
                ),


              ],
            ),
          ),
        ),
      );
    });
  }
}