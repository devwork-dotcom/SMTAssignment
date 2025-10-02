import 'package:assignment/theme/ThemeController.dart';
import 'package:assignment/widgets/button/elevated_button.dart';
import 'package:assignment/widgets/input/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'SignInController.dart';

class SignInScreen extends GetView<SignInController> {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Get.find<ThemeController>();

    return Obx(() {
      theme.updateSystemUI();

      return Scaffold(
        backgroundColor: theme.background,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 0.04.sh),

                Center(child: Image.asset("assets/bulb_1.png")),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0.02.sw),
                  child: Text(
                    'signIn_title'.tr,
                    style: TextStyle(
                      color: theme.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 28.sp,
                    ),
                  ),
                ),

                Text(
                  'signIn_subTitle'.tr,
                  style: TextStyle(
                    color: theme.subTextColor,
                    fontWeight: FontWeight.normal,
                    fontSize: 14.sp,
                  ),
                ),

                SizedBox(height: 0.04.sh),

                CustomTextField(
                  controller: controller.emailController,
                  title: "email_address".tr,
                  hint: "Enter Your Email",
                  keyboardType: TextInputType.emailAddress,
                ),

                CustomTextField(
                  controller: controller.passwordController,
                  title: "password".tr,
                  hint: "Enter Your Password",
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !controller.isPasswordVisible.value,
                  showPasswordToggle: true,
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Checkbox(
                              value: controller.rememberMe.value,
                              onChanged: controller.toggleRememberMe,
                              visualDensity: VisualDensity.compact,
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              checkColor: theme.white,
                              activeColor: theme.blue,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              "remember_me".tr,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: theme.textColor,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Forgot password
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: controller.navigateToForgotPassword,
                            child: Text(
                              "forgot_password".tr,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: theme.textColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24.h),

                elevatedButton(
                  text: "sign_in".tr,
                  onTap: controller.signin,
                ),

                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "new_theory".tr,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: theme.subTextColor,
                      ),
                    ),
                    SizedBox(width: 14.w),
                    GestureDetector(
                      onTap: controller.navigateToSignUp,
                      child: Text(
                        "create_account".tr,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: theme.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      );
    });
  }
}