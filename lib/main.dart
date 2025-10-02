import 'package:assignment/BlankScreen.dart';
import 'package:assignment/app/modules/language/LanguageSelection.dart';
import 'package:assignment/app/modules/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'localization/Language.dart';
import 'localization/language_controller.dart';
import 'routes/app_pages.dart';
import 'theme/ThemeController.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put(ThemeController());
  Get.put(LanguageController());
  Locale initialLocale = Locale('en', 'US');

  runApp(MyApp(initialLocale: initialLocale));
}

class MyApp extends StatelessWidget {

  final Locale initialLocale;
  const MyApp({super.key, required this.initialLocale});


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_ , child){

        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: AppPages.initial,
          getPages: AppPages.routes,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: Get.find<ThemeController>().isDark.value
              ? ThemeMode.dark
              : ThemeMode.light,
          translations: Languages(),
          locale: initialLocale,
          fallbackLocale: const Locale('en','US'),
          home: SplashView(),
        );
      },
    );


  }
}

