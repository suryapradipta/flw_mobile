import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class HomeView extends StatelessWidget {
  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              // Call the signOut method in the HomeController
              _homeController.signOut();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to the Food Waste Reduction App!',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Add logic for navigating to another screen or performing an action
              },
              child: Text('Some Action'),
            ),
          ],
        ),
      ),
    );
  }
}
