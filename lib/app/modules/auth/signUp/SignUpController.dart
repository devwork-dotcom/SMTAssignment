import 'package:assignment/app/data/services/authServices.dart';
import 'package:assignment/widgets/pop%20up%20dailog/PopUpDailog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  final rememberMe = false.obs;
  final isLoading = false.obs;
  final isPasswordVisible = false.obs;

  // Password strength related
  final passwordStrength = ''.obs;
  final passwordScore = 0.obs;

  @override
  void onInit() {
    super.onInit();
    passwordController.addListener(_checkPasswordStrength);
  }

  void _checkPasswordStrength() {
    final password = passwordController.text;

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

  Future<void> signUp() async {



    if (emailController.text.isEmpty) {
      Get.snackbar('Error'.tr, 'Please enter your email');
      return;
    }
    if (!GetUtils.isEmail(emailController.text)) {
      Get.snackbar('Error'.tr, 'Please enter valid email');
      return;
    }

    if (nameController.text.isEmpty) {
      Get.snackbar('Error'.tr, 'Please enter your name');
      return;
    }


    if (passwordController.text.isEmpty) {
      Get.snackbar('Error'.tr, 'Please enter password');
      return;
    }

    if (passwordScore.value < 2) {
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
      final result = await AuthService.signUp(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      Get.back();

      if (result['success'] == true) {
        clearForm();
        successPopUp();
      }
    } catch (e) {
      Get.back();
      final errorMessage = e.toString();
      if (errorMessage.contains('User already exists')) {
        Get.snackbar('Error'.tr, 'User already exists with this email');
      } else if (errorMessage.contains('Failed to create user')) {
        Get.snackbar('Error'.tr, 'Failed to create user account');
      } else {
        Get.snackbar('Error'.tr, errorMessage.replaceFirst('Exception: ', ''));
      }
    }
  }


  void clearForm() {
    passwordController.clear();
    nameController.clear();
    emailController.clear();
    passwordScore.value = 0;
    passwordStrength.value = '';
  }

  void navigateToSignIn() {
    clearForm();
    Get.toNamed('/signin');
  }

  void successPopUp() {
    CustomDialog.show(
      imagePath: "assets/register_popUp.png",
      title: "success_register".tr,
      subtitle: "success_sub_register".tr,
      buttonText: "continue".tr,
      onButtonPressed: () {
        Get.toNamed('/signin');
      },
    );
  }

  @override
  void onClose() {
    emailController.removeListener(_checkPasswordStrength);
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}