import 'package:flw_mobile/app/services/auth_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final AuthService _authService = Get.find();
  // You can include any other state variables or methods needed for the home screen logic.

  void signOut() async {
    try {
      await _authService.signOut();
      // Sign-out successful
      Get.offAllNamed('/login');

    } catch (e) {
      // Handle sign-out errors

      print("Error during sign-out: $e");
    }
  }
}
