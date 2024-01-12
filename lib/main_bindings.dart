import 'package:flw_mobile/app/services/auth_service.dart';
import 'package:get/get.dart';

class MainBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthService());
  }
}
