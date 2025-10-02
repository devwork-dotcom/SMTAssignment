import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  var isDark = false.obs;
  final box = GetStorage();


  Color get iconColor => isDark.value ? Color(0xff00A249) : Color(0xff575757);
  Color get textColor => isDark.value ? Color(0xffF5F5F5) : Color(0xff2d2d2d);
  Color get subTextColor => isDark.value ? Color(0xffF5F5F5) : Color(0xff868e9e);
  Color get background => isDark.value ? Color(0xff111627) : Color(0xffffffff);
  Color get blue => isDark.value ? Color(0xff38bdf8) : Color(0xff1b6ef7);
  Color get greyWhite => isDark.value ? Color(0xffecf0f3) : Color(0xffecf0f3);
  Color get white => isDark.value ? Color(0xff111627) : Color(0xffffffff);
  Color get button_text_color => isDark.value ? Color(0xffEAEAEA) : Color(0xffffffff);

  Color get offWhite => isDark.value ? Color(0xffB0B0B0) : Color(0xff8B8C93);
  Color get red => isDark.value ? Color(0xffB0B0B0) : Color(0xffe30707);
  Color get offGreen => isDark.value ? Color(0xff2fcd35) : Color(0xff2fa131);



  Color get offGreyWhite => isDark.value ? Color(0xff2E2E2E) : Color(0xd5d3d3d6);
  Color get deepBlue => isDark.value ? Color(0xff121212) : Color(0xff030C29);
  Color get black => isDark.value ? Color(0xff000000) : Color(0xff000000);

  // Unified Color Names
  Color get secondaryGreen => isDark.value ? Color(0xff4CAF50) : Color(0xb268b68c);
  Color get surface => isDark.value ? Color(0xff2E2E2E) : Color(0xd5d3d3d6);
  Color get deepBackground => isDark.value ? Color(0xfc121d45) : Color(0xfc101832);
  Color get appBarButton => isDark.value ? Color(0xff374151) : Color(0xFF7096B5);
  Color get onBackground => isDark.value ? Color(0xffEAEAEA) : Color(0xffecf0f3);
  Color get modeIcon => isDark.value ? Color(0xffecf0f3) : Color(0xff000000);
  Color get secondaryText => isDark.value ? Color(0xffB0B0B0) : Color(0xff8B8C93);
  Color get textColorPrimary => isDark.value ? Color(0xffF5F5F5) : Color(0xff333333);

  @override
  void onInit() {
    super.onInit();
    _loadTheme();
  }

  void toggleTheme() {
    isDark.value = !isDark.value;
    Get.changeThemeMode(isDark.value ? ThemeMode.dark : ThemeMode.light);
    box.write('isDark', isDark.value);
    updateSystemUI();
  }

  void _loadTheme() {
    isDark.value = box.read('isDark') ?? false;
    Get.changeThemeMode(isDark.value ? ThemeMode.dark : ThemeMode.light);
    updateSystemUI();
  }


  void updateSystemUI() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: background,
      statusBarIconBrightness: isDark.value ? Brightness.light : Brightness.dark,
      systemNavigationBarColor: background,
      systemNavigationBarIconBrightness: isDark.value ? Brightness.light : Brightness.dark,
    ));
  }
}
