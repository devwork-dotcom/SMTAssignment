import 'package:assignment/app/modules/auth/forgot%20password/forgot_controller.dart';
import 'package:get/get.dart';

class ForgotPassBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ForgotPassController>(()=>ForgotPassController());
  }
}