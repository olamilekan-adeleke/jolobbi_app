import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

/// return a percentage of thr screen height in respect to the  value given
double sh(double value) => value.h;

/// return a percentage of thr screen width in respect to the  value given
double sw(double value) => value.w;

/// Calculates the sp (Scalable Pixel) depending on the device's screen size
double sp(double value) => value.sp;

SizedBox verticalSpace([double value = 10]) => SizedBox(height: value.sp);

SizedBox horizontalSpace([double value = 10]) => SizedBox(width: value.sp);


