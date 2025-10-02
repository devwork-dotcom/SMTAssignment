import 'package:assignment/app/modules/auth/signUp/SignUpController.dart';
import 'package:assignment/theme/ThemeController.dart';
import 'package:assignment/widgets/button/circular_back_button.dart';
import 'package:assignment/widgets/button/elevated_button.dart';
import 'package:assignment/widgets/input/CustomTextField.dart';
import 'package:assignment/widgets/input/PasswordIndicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Signupscreen extends GetView<SignUpController> {
  const Signupscreen({super.key});

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
                  child: Text(
                    'signUp_title'.tr,
                    style: TextStyle(
                      color: theme.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 28.sp,
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w,),
                  child: Text(
                    'signUp_subTitle'.tr,
                    style: TextStyle(
                      color: theme.subTextColor,
                      fontWeight: FontWeight.normal,
                      fontSize: 15.sp,
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

                CustomTextField(
                  controller: controller.nameController,
                  title: "full_name".tr,
                  hint: "Enter Your Name",
                  keyboardType: TextInputType.name,
                ),


                CustomTextField(
                  controller: controller.passwordController,
                  title: "password".tr,
                  hint: "Enter Your Password",
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !controller.isPasswordVisible.value,
                  showPasswordToggle: true,
                ),

                SizedBox(height: 8.h),


                PasswordStrengthIndicator(
                  score: controller.passwordScore.value,
                  status: controller.getPasswordStatusText(),
                ),


                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Obx(() {
                    final score = controller.passwordScore.value;
                    final showCheckMark = score >= 2;

                    return AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          if (showCheckMark)
                            Container(
                              width: 16.w,
                              height: 16.w,
                              margin: EdgeInsets.only(right: 8.w),
                              decoration: BoxDecoration(

                                shape: BoxShape.circle,
                                border: Border.all(width: 1.r,color: theme.offGreen),
                              ),
                              child: Icon(
                                Icons.check,
                                color: theme.offGreen,
                                size: 12.w,
                              ),
                            ),


                          Flexible(
                            child: Text(
                              'password_status'.tr,
                              style: TextStyle(
                                color: showCheckMark ? theme.offGreen : theme.subTextColor,
                                fontWeight: FontWeight.normal,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),


                SizedBox(height: 20.h),

                elevatedButton(
                  text: "label".tr,
                  onTap: controller.signUp,
                ),

                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "already_account".tr,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: theme.subTextColor,
                      ),
                    ),
                    SizedBox(width: 14.w),
                    GestureDetector(
                      onTap: controller.navigateToSignIn,
                      child: Text(
                        "sign_in".tr,
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