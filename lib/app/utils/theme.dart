import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Typography
TextStyle regular12_5 =
    const TextStyle(fontFamily: 'SF-Pro-Display', fontSize: 12.5);
TextStyle regular14 = regular12_5.copyWith(fontSize: 14);
TextStyle semiBold12_5 = regular12_5.copyWith(fontWeight: FontWeight.w600);
TextStyle semiBold14 = semiBold12_5.copyWith(fontSize: 14, letterSpacing: 0.1);

TextStyle bold16 = regular12_5.copyWith(
    fontWeight: FontWeight.w700, fontSize: 16, letterSpacing: 0.1);
TextStyle bold18 = bold16.copyWith(fontSize: 18, letterSpacing: -0.5);


double height = 825.h;
double width = 375.w;