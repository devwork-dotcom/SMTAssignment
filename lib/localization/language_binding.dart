
import 'package:assignment/localization/language_controller.dart';
import 'package:get/get.dart';

class LanguageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<LanguageController>(() => LanguageController());
  }
}