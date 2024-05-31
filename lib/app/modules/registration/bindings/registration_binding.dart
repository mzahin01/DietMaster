import 'package:diet_master/app/modules/registration/controllers/registration_controller.dart';
import 'package:get/get.dart';

class RegistrationPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegistrationPageController>(
      () => RegistrationPageController(),
    );
  }
}
