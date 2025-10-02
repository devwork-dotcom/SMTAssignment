import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardController extends GetxController {
  final pageController = PageController();
  final currentPageIndex = 0.obs;

  void onPageChanged(int index) {
    currentPageIndex.value = index;
  }

  void navigateToNext() {
    if (currentPageIndex.value == 0) {
      pageController.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    } else {
      Get.offAllNamed('/signin');
    }
  }


  Future<bool> onWillPop() async {
    if (currentPageIndex.value > 0) {
      pageController.previousPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
      return false;
    } else {
      return true;
    }
  }

  String get buttonText {
    return currentPageIndex.value == 0 ? "onboard_btn_next".tr : "onboard_btn_getStarted".tr;
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}