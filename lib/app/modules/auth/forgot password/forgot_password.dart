import 'package:assignment/app/modules/auth/forgot%20password/forgot_controller.dart';
import 'package:assignment/theme/ThemeController.dart';
import 'package:assignment/widgets/button/circular_back_button.dart';
import 'package:assignment/widgets/button/elevated_button.dart';
import 'package:assignment/widgets/input/CustomTextField.dart';
import 'package:assignment/widgets/input/PasswordIndicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ForgotPassword extends GetView<ForgotPassController> {
  const ForgotPassword({super.key});

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
                  controller.navigateToSignIn();
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
                      'forgot_subTitle'.tr,
                      style: TextStyle(
                        color: theme.subTextColor,
                        fontWeight: FontWeight.normal,
                        fontSize: 15.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                SizedBox(height: 0.03.sh),





                CustomTextField(
                  controller: controller.emailController,
                  title: "email_address".tr,
                  hint: "Enter Your Email",
                  keyboardType: TextInputType.emailAddress,
                ),




                elevatedButton(
                  text: "continue".tr,
                  onTap: controller.sendOTP,
                ),



              ],
            ),
          ),
        ),
      );
    });
  }
}