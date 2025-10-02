import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

class LocationPermissionController extends GetxController {

  Future<void> requestLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar('Error'.tr, 'Location services are disabled.');
      return;
    }


    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar('Error'.tr, 'Location permission denied');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar('Error'.tr,
          'Permission permanently denied. Enable it from settings.');
      return;
    }

    navigateToLanguageSelection();
  }

  void navigateToLanguageSelection() {
    Get.toNamed('/language');
  }

  void navigateToHome() {
    Get.toNamed('/home');
  }
}
