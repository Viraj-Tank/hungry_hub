import 'package:get/get.dart';
import 'package:hungry_hub/controller/home_controller.dart';

import '../controller/auth_controller.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
    Get.put(HomeController());
  }
}
