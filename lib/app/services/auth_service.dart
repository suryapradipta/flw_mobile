import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flw_mobile/app/routes/routes.dart';
import 'package:flw_mobile/app/services/api_client.dart';
import 'package:flw_mobile/app/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthService extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ApiClient _apiClient = ApiClient(AppConstants.baseUrl);
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();


  Rx<User?> user = Rx<User?>(null);
  RxString? accessToken = ''.obs;
  RxString? refreshToken = ''.obs;


  @override
  void onInit() {
    super.onInit();

    // Check if the user is already signed in
    user.bindStream(_auth.authStateChanges());
    _retrieveTokens();
  }

  Future<void> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      // Handle registration errors
      print("Error during registration: $e");
      throw Exception("Registration failed");
    }
  }

  Future<void> registerUserOnServer(String email, String username, String password) async {
    try {
      final response = await _apiClient.post('api/v1/users/register', {
        'email': email,
        'username': username,
        'password': password,
      });

      print(response.statusCode);
      // if (response.statusCode == 201) {
      //   print('User registered on the server successfully');
      // }
    } catch (e) {
      print('Error registering user on the server: $e');
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      await _fetchTokens(email, password);
    } catch (e) {
      // Handle login errors
      print("Error during login: $e");
      throw Exception("Login failed");
    }
  }

  Future<void> _fetchTokens(String email, String password) async {
    try {
      final response = await _apiClient.post('api/v1/users/login', {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        accessToken = data['access_token'].toString().obs;
        refreshToken = data['refresh_token'].toString().obs;

        // Save tokens to secure storage
        await _secureStorage.write(key: 'access_token', value: accessToken?.value);
        await _secureStorage.write(key: 'refresh_token', value: refreshToken?.value);

        print('Access Token: $accessToken');
        print('Refresh Token: $refreshToken');
      } else {
        Get.snackbar('Error', 'Failed to fetch tokens from the server');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch tokens: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      accessToken = ''.obs;
      refreshToken = ''.obs;

      // Clear tokens from secure storage
      await _secureStorage.delete(key: 'access_token');
      await _secureStorage.delete(key: 'refresh_token');
    } catch (e) {
      Get.snackbar('Error', 'Failed to sign out: $e');
    }
  }

  Future<void> _retrieveTokens() async {
    // Retrieve tokens from secure storage during initialization
    accessToken = (await _secureStorage.read(key: 'access_token'))?.obs;
    refreshToken = (await _secureStorage.read(key: 'refresh_token'))?.obs;

    print('Access Token: $accessToken');
    print('Refresh Token: $refreshToken');

    if (await _isTokenExpired(accessToken)) {
      if(await _tryRefreshToken()) {
      }else {
        print("SIGN OUT");
        // Refresh token is also expired, sign out
        await signOut(); // await added here to make sure signOut completes before navigation
      }
    }

    // Navigate to the appropriate screen based on the authentication state
    if (_auth.currentUser != null) {
      Get.offAllNamed(AppRoutes.INITIAL); // Navigate to home screen
    } else {
      Get.offAllNamed(AppRoutes.LOGIN); // Navigate to login screen
    }
  }

  Future<void> _checkAuthStatus() async {
    ever<User?>(user, (User? user ) async {
        if (user == null) {
          // No user is signed in
          accessToken = ''.obs;
          refreshToken = ''.obs;
          Get.offAllNamed('/login'); // Navigate to login page
        }


        else {
          // User is signed in
          if (await _isTokenExpired(accessToken)) {
            // Access token has expired, try to refresh
            if (await _tryRefreshToken()) {
              // Successfully refreshed, do nothing (user is still signed in)
            } else {
              // Refresh token is also expired, sign out
              await signOut(); // await added here to make sure signOut completes before navigation
            }
          }
          // Access token is still valid, user is signed in
          Get.offAllNamed('/'); // Navigate to home screen
        }
      },
    );
  }

  Future<bool> _tryRefreshToken() async {
    try {


      print('CHECK');
      final response = await _apiClient.post('api/v1/users/refresh', {
        'refresh_token': refreshToken!.value,
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        accessToken = data['access_token'].toString().obs;

        // Save the new access token to secure storage
        await _secureStorage.write(key: 'access_token', value: accessToken!.value);

        print('Access Token Refreshed: $accessToken');
        return true;
      } else {
        Get.snackbar('Error', 'Failed to refresh access token');
        return false;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to refresh access token: $e');
      return false;
    }
  }

  Future<bool> _isTokenExpired(RxString? token) async {
    if (token == null || token.isEmpty) {
      return true; // Token is considered expired if empty or null
    }

    final Map<String, dynamic> decodedToken = JwtDecoder.decode(token.value);
    final int? exp = decodedToken['exp'];

    if (exp != null) {
      final int currentTimestamp = DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000;
      return exp < currentTimestamp;
    } else {
      return true; // Unable to determine expiration, consider it expired
    }
  }
}
