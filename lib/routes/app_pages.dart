import 'package:assignment/BlankScreen.dart';
import 'package:assignment/app/modules/auth/forgot%20password/forgot_binding.dart';
import 'package:assignment/app/modules/auth/forgot%20password/forgot_password.dart';
import 'package:assignment/app/modules/auth/forgot%20password/otp_verify.dart';
import 'package:assignment/app/modules/auth/forgot%20password/reset_password.dart';
import 'package:assignment/app/modules/auth/signIn/SignInBinding.dart';
import 'package:assignment/app/modules/auth/signIn/SignInScreen.dart';
import 'package:assignment/app/modules/auth/signUp/SignUpBinding.dart';
import 'package:assignment/app/modules/auth/signUp/SignUpScreen.dart';
import 'package:assignment/app/modules/home/Home.dart';
import 'package:assignment/app/modules/home/HomeBinding.dart';
import 'package:assignment/app/modules/language/LanguageSelection.dart';
import 'package:assignment/app/modules/location%20permission/location_binding.dart';
import 'package:assignment/app/modules/location%20permission/location_controller.dart';
import 'package:assignment/app/modules/location%20permission/location_permission.dart';
import 'package:assignment/app/modules/onboard/OnboardScreen.dart';
import 'package:assignment/app/modules/onboard/onboard_binding.dart';
import 'package:assignment/app/modules/splash/splash_binding.dart';
import 'package:assignment/app/modules/splash/splash_view.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class AppPages {
  static const initial = AppRoutes.splash;

  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
        name: AppRoutes.onboard,
        page: ()=> const OnboardScreen(),
        binding: OnboardBinding(),
    ),

    GetPage(
      name: AppRoutes.welcome,
      page: () => const Blankscreen(),
    ),
    GetPage(
      name: AppRoutes.signin,
      page: () => const SignInScreen(),
      binding: SignInBinding()
    ),
    GetPage(
        name: AppRoutes.signup,
        page: () => const Signupscreen(),
        binding: SignUpBinding()
    ),

    GetPage(
        name: AppRoutes.forgot_password,
        page: () => const ForgotPassword(),
        binding: ForgotPassBinding()
    ),
    GetPage(
        name: AppRoutes.otp_verify,
        page: () => const OtpVerify(),
        binding: ForgotPassBinding()
    ),
    GetPage(
        name: AppRoutes.reset_password,
        page: () => const ResetPassword(),
        binding: ForgotPassBinding()
    ),

    GetPage(
        name: AppRoutes.location,
        page: () => const LocationPermission(),
        binding: LocationBinding()
    ),
    GetPage(
        name: AppRoutes.language,
        page: () => const Languageselection(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () =>  Home(),
      binding: HomeBinding()
    ),
  ];
}
