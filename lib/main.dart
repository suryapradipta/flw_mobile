import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flw_mobile/app/routes/routes.dart';
import 'package:flw_mobile/app/utils/colors.dart';
import 'package:flw_mobile/global.dart';
import 'package:get/get.dart';

Future<void> main() async {
  await Global.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 825),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Food Waste Reduction App',
          /*theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),*/
          theme: ThemeData(
              scaffoldBackgroundColor: kOffWhite,
              iconTheme: const IconThemeData(color: kDark),
              primarySwatch: Colors.grey),
          // initialBinding: MainBindings(),
          initialRoute: AppRoutes.MAIN,
          getPages: AppPages.routes,
        );
      },
    );
  }
}
