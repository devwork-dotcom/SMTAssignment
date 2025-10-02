import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageController extends GetxController {
  String? selectedLanguage;
  final storage = GetStorage();


  final List<Map<String, String>> languages = [
    {"name": "English (US)", "flag": "🇺🇸"},
    {"name": "Bangladesh", "flag": "🇧🇩"},
    {"name": "Indonesia", "flag": "🇮🇩"},
    {"name": "Afghanistan", "flag": "🇦🇫"},
    {"name": "Algeria", "flag": "🇩🇿"},
    {"name": "Malaysia", "flag": "🇲🇾"},
    {"name": "Arabic", "flag": "🇸🇦"},
  ];

  void navigateToHome() {
    Get.toNamed('/home');
  }

  void navigateToLocation() {
    Get.toNamed('/location-permission');
  }

  @override
  void onInit() {
    super.onInit();
    _loadLanguage();
  }


  void _loadLanguage() {
    selectedLanguage = storage.read('language');


    if (selectedLanguage == "English (US)") {
      Get.updateLocale(const Locale('en', 'US'));
    } else if (selectedLanguage == "Bangladesh") {
      Get.updateLocale(const Locale('bn', 'BD'));
    }else if (selectedLanguage == "Indonesia") {
      Get.updateLocale(const Locale('id', 'ID'));
    } else if (selectedLanguage == "Afghanistan") {
      Get.updateLocale(const Locale('ps', 'AF'));
    } else if (selectedLanguage == "Algeria") {
      Get.updateLocale(const Locale('ar', 'DZ'));
    } else if (selectedLanguage == "Malaysia") {
      Get.updateLocale(const Locale('ms', 'MY'));
    } else if (selectedLanguage == "Arabic") {
      Get.updateLocale(const Locale('ar', 'SA'));
    }

    update();
  }

  void selectLanguage(String language) {
    selectedLanguage = language;
    storage.write('language', language);


    if (language == "English (US)") {
      Get.updateLocale(const Locale('en', 'US'));
    }else if (selectedLanguage == "Bangladesh") {
      Get.updateLocale(const Locale('bn', 'BD'));
    } else if (language == "Indonesia") {
      Get.updateLocale(const Locale('id', 'ID'));
    } else if (language == "Afghanistan") {
      Get.updateLocale(const Locale('ps', 'AF'));
    } else if (language == "Algeria") {
      Get.updateLocale(const Locale('ar', 'DZ'));
    } else if (language == "Malaysia") {
      Get.updateLocale(const Locale('ms', 'MY'));
    } else if (language == "Arabic") {
      Get.updateLocale(const Locale('ar', 'SA'));
    }

    update(); // Notify UI to rebuild
  }

  bool get isLanguageSelected => selectedLanguage != null;
}