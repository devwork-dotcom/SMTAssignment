import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  final rememberMe = false.obs;
  final isLoading = false.obs;
  final isPasswordVisible = false.obs;


  void toggleRememberMe(bool? value) {
    rememberMe.value = value ?? false;
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

  void navigateToForgotPassword() {
    Get.toNamed('/forgot-password');
  }

  void navigateToSignUp() {
    Get.toNamed('/signup');
  }

  Future<void> signin() async {

    if (emailController.text.isEmpty) {
      Get.snackbar('Error'.tr, 'Please enter your email');
      return;
    }
    if (!GetUtils.isEmail(emailController.text)) {
      Get.snackbar('Error'.tr, 'Please enter valid email');
      return;
    }


    if (passwordController.text.isEmpty) {
      Get.snackbar('Error'.tr, 'Please enter password');
      return;
    }

    Get.offAllNamed('/location-permission');

  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}