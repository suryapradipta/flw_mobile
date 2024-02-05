import 'package:flw_mobile/app/modules/auth/binding.dart';
import 'package:flw_mobile/app/modules/auth/login_view.dart';
import 'package:flw_mobile/app/modules/auth/register_view.dart';
import 'package:flw_mobile/app/modules/home/index.dart';
import 'package:flw_mobile/app/modules/main/entrypoint.dart';
import 'package:flw_mobile/app/routes/names.dart';
import 'package:get/get.dart';

import 'routes.dart';


class AppPages {
  static const INITIAL = AppRoutes.INITIAL;
  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.INITIAL,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.REGISTER,
      page: () => RegisterView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.MAIN,
      page: () => MainScreen(),
    ),
  ];
}