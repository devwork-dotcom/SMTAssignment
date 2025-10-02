import 'dart:async';

import 'package:assignment/widgets/pop%20up%20dailog/PopUpDailog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPassController extends GetxController {
  final emailController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final email = ''.obs;

  final rememberMe = false.obs;
  final isLoading = false.obs;
  final isPasswordVisible = false.obs;

  final passwordStrength = ''.obs;
  final passwordScore = 0.obs;

  final countdown = 60.obs;
  final canResend = false.obs;
  Timer? _timer;


  @override
  void onInit() {
    super.onInit();
    newPasswordController.addListener(_checkPasswordStrength);

    final arguments = Get.arguments;
    if (arguments != null && arguments is Map) {
      email.value = arguments['email'] ?? '';
    }

    startCountdown();
  }

  //Send OTP
  void sendOTP() async {
    if (emailController.text.isEmpty) {
      Get.snackbar('Error'.tr, 'Please enter your email');
      return;
    }
    if (!GetUtils.isEmail(emailController.text)) {
      Get.snackbar('Error'.tr, 'Please enter valid email');
      return;
    }

    email.value = emailController.text.trim();
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      //Add your OTP API call here
      await Future.delayed(Duration(seconds: 2));

      Get.back();
      Get.toNamed(
        '/otp-verify',
        arguments: {
          'email': email.value,
        },
      );

    } catch (e) {
      Get.back();
      Get.snackbar('Error'.tr, 'Failed to send OTP. Please try again.');
    }
  }

  //OTP Verify
  void startCountdown() {

    countdown.value = 60;
    _timer?.cancel();

    canResend.value = false;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdown.value > 0) {
        countdown.value--;
      } else {
        canResend.value = true;
        timer.cancel();
      }
    });
  }

  void resendOTP() async {
    if (!canResend.value) return;
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      //  Add your resend OTP API call here
      await Future.delayed(Duration(seconds: 2));

      Get.back();

      Get.snackbar('Success'.tr, 'OTP sent successfully!');
      startCountdown();

    } catch (e) {
      Get.back();
      Get.snackbar('Error'.tr, 'Failed to resend OTP. Please try again.');
    }
  }

  void verifyOTP(String otp) async {
    if (otp.isEmpty || otp.length != 4) {
      Get.snackbar('Error'.tr, 'Please enter valid 4-digit OTP');
      return;
    }


    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      // Add your OTP verification API call here

      await Future.delayed(Duration(seconds: 2));

      Get.back();
      Get.toNamed('/reset-password');

    } catch (e) {
      Get.back();
      Get.snackbar('Error'.tr, 'Invalid OTP. Please try again.');
    }
  }
  void navigateToForgotPassword() {
    emailController.clear();
    Get.toNamed('/forgot-password');
  }


  //Reset Password
  void _checkPasswordStrength() {
    final password = newPasswordController.text;

    if (password.isEmpty) {
      passwordStrength.value = '';
      passwordScore.value = 0;
      return;
    }

    int score = 0;
    if (password.length >= 8) score += 1;
    if (password.contains(RegExp(r'[0-9]'))) score += 1;
    if (password.contains(RegExp(r'[a-z]'))) score += 1;
    if (password.contains(RegExp(r'[A-Z]'))) score += 1;

    passwordScore.value = score;

    if (password.length < 8) {
      passwordStrength.value = 'weak';
    } else if (score <= 2) {
      passwordStrength.value = 'medium';
    } else if (score <= 3) {
      passwordStrength.value = 'strong';
    } else {
      passwordStrength.value = 'very_strong';
    }
  }

  String getPasswordStatusText() {
    return passwordStrength.value.tr;
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void login() async {
    if (isLoading.value) return;
    isLoading.value = true;
    await Future.delayed(Duration(seconds: 2));
    isLoading.value = false;
    Get.offAllNamed('/home');
  }

  void navigateToSignIn() {
    newPasswordController.clear();
    confirmPasswordController.clear();
    emailController.clear();
    Get.toNamed('/signin');
  }

  void navigateToOTPVerify() {
    emailController.clear();
    Get.toNamed('/otp-verify');
  }


  void resetPassword (){


    if (newPasswordController.text.isEmpty) {
      Get.snackbar('Error'.tr, 'Please enter new password');
      return;
    }
    if (confirmPasswordController.text.isEmpty) {
      Get.snackbar('Error'.tr, 'Please enter confirm password');
      return;
    }
    if (newPasswordController.text.trim() != confirmPasswordController.text.trim()) {
      Get.snackbar('Error'.tr, 'Password not match');
      return;
    }

    if (passwordScore.value < 3) {
      Get.snackbar('Error'.tr, 'Please use stronger password');
      return;
    }


    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );

    try {
      Get.back();
      successPopUp();

    } catch (e) {
      Get.back();
      final errorMessage = e.toString();
      Get.snackbar('Error'.tr, errorMessage.replaceFirst('Exception: ', ''));
    }
  }

  void successPopUp(){
    CustomDialog.show(
      imagePath: "assets/success.png",
      title: "reset_pop_title".tr,
      subtitle: "reset_pop_subTitle".tr,
      buttonText: "reset_pop_btn".tr,
      onButtonPressed: (){
        Get.offAllNamed('/location-permission');
      },
    );
  }


  String getFormattedCountdown() {
    int minutes = countdown.value ~/ 60;
    int seconds = countdown.value % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void onClose() {
    _timer?.cancel();
    emailController.removeListener(_checkPasswordStrength);
    emailController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}