import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flw_mobile/firebase_options.dart';
import 'package:flw_mobile/main_bindings.dart';
import 'package:get/get.dart';
import 'dependencies.dart' as dependencies;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dependencies.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FLW',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: null,
      initialBinding: MainBindings(),
    );
  }
}