import 'package:deliverapp/utilities/Dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utilities/AppColors.dart';

class BigText extends StatelessWidget {
  Color? color;
  final String text;
  final double size;
  // ignore: deprecated_member_use
  final TextOverflow overflow;

  BigText({
    required this.text,
    this.color = AppColors.mainColor,
    this.size = 20,
    this.overflow = TextOverflow.ellipsis,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style:
          TextStyle(color: color, fontSize: size, fontWeight: FontWeight.w400),
    );
  }
}
