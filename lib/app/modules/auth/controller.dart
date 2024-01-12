import 'package:flw_mobile/app/services/auth_service.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final AuthService _authService = Get.find();

  RxBool isLoading = false.obs;
  RxBool isLoggedIn = false.obs;

  RxString email = ''.obs;
  RxString password = ''.obs;
  RxString username = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // ever(isLoggedIn, handleAuthChanged);
    // checkUser(); // Check user login status on app startup
  }

  /*void handleAuthChanged(bool isLoggedIn) {
    if (isLoggedIn) {
      // Get.offAllNamed('/');
    } else {
      // Get.offAllNamed('/login');
    }
  }*/

  /*void checkUser() {
    // Check if the user is already logged in
    User? user = _auth.currentUser;
    isLoggedIn(user != null);
  }*/

  void signUp() async {
    try {
      isLoading(true);
      await _authService.signUp(email.value,  password.value);
      await _authService.registerUserOnServer(email.value, username.value, password.value);
      Get.offAllNamed('/login');
      isLoggedIn(true);
    } catch (e) {
      // Handle registration errors
      print("Error during registration: $e");
      // You may want to show an error message to the user
    } finally {
      isLoading(false);
    }
  }

  void signIn() async {
    try {
      isLoading(true);
      await _authService.signIn(email.value,  password.value);
      // Login successful
      isLoggedIn(true);
      Get.offAllNamed('/');
    } catch (e) {
      // Handle login errors
      print("Error during login: $e");
      // You may want to show an error message to the user
    } finally {
      isLoading(false);
    }
  }

  void signOut() async {
    try {
      await _authService.signOut();
      // Sign-out successful
      isLoggedIn(false);
      Get.offAllNamed('/login');

    } catch (e) {
      // Handle sign-out errors

      print("Error during sign-out: $e");
    }
  }
}
