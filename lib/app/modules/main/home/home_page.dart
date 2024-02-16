import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flw_mobile/app/common/custom_container.dart';
import 'package:flw_mobile/app/utils/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(130.h),
        child: Container(
          height: 130.h,
        ),
      ),
      body: SafeArea(child: CustomContainer(containerContent: Container())),
    );
  }
}
