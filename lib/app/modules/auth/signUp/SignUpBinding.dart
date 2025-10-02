import 'package:assignment/app/modules/auth/signUp/SignUpController.dart';
import 'package:get/get.dart';

class SignUpBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SignUpController>(()=>SignUpController());
  }
}