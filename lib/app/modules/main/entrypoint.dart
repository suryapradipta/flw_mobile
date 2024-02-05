import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flw_mobile/app/controllers/tab_index_controller.dart';
import 'package:flw_mobile/app/utils/colors.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TabIndexController controller = Get.put(TabIndexController());

    return Scaffold(
      body: Obx(
        () => controller.currentScreen,
      ),
      bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(canvasColor: kPrimary),
          child: Obx(
            () => BottomNavigationBar(
              currentIndex: controller.currentIndex,
              onTap: (index) {
                controller.currentIndex = index;
              },
              /*showSelectedLabels: false,
              showUnselectedLabels: false,
              unselectedIconTheme: const IconThemeData(
                color: Colors.black38,
              ),
              selectedIconTheme: const IconThemeData(
                color: kSecondary,
              ),*/
              items: [
                BottomNavigationBarItem(
                  icon: controller.currentIndex == 0
                      ? const Icon(AntDesign.appstore1)
                      : const Icon(AntDesign.appstore_o),
                  label: 'Home',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
                const BottomNavigationBarItem(
                  icon: Badge(
                    label: Text('1'),
                    child: Icon(FontAwesome.opencart),
                  ),
                  label: 'Cart',
                ),
                BottomNavigationBarItem(
                  icon: controller.currentIndex == 3
                      ? const Icon(FontAwesome.user_circle)
                      : const Icon(FontAwesome.user_circle_o),
                  label: 'Profile',
                ),
              ],
            ),
          )),
    );
  }
}
