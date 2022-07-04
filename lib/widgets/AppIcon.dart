import 'dart:ffi';

import 'package:deliverapp/utilities/AppColors.dart';
import 'package:deliverapp/utilities/Dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  late final IconData icon;
  late final double? size;
  late final Color? color;
  late final Color? CustomBackgroundColor;

  AppIcon(
      {required this.icon,
      this.size = 40,
      this.color = const Color(0xFF756d54),
      this.CustomBackgroundColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size! / 2),
          color: CustomBackgroundColor),
      child: Icon(
        icon,
        size: Dimensions.iconSize16,
        color: color,
      ),
    );
  }
}
