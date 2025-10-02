import 'package:assignment/routes/app_routes.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    Future.delayed(Duration(seconds: 5), () {
      Get.offAllNamed(AppRoutes.onboard);
    });
  }
}
