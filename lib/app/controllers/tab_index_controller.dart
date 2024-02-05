import 'package:flutter/material.dart';
import 'package:flw_mobile/app/modules/main/cart/cart_page.dart';
import 'package:flw_mobile/app/modules/main/home/home_page.dart';
import 'package:flw_mobile/app/modules/main/profile/profile_page.dart';
import 'package:flw_mobile/app/modules/main/search/search_page.dart';
import 'package:get/get.dart';

class TabIndexController extends GetxController {
  final RxInt _currentIndex = 0.obs;

  List<Widget> pages = [
    HomePage(),
    SearchPage(),
    CartPage(),
    ProfilePage()
  ];

  int get currentIndex => _currentIndex.value;

  Widget get currentScreen => pages[_currentIndex.value];

  set currentIndex(int value) {
    _currentIndex.value = value;
  }
}
