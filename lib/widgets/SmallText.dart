import 'package:deliverapp/utilities/AppColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  Color? color;
  String text;
  double size;
  double height;
  TextOverflow overflow;
  int maxLinesToShow;

  SmallText(
      {required this.text,
      this.height = 1.2,
      this.color = AppColors.mainColor,
      this.size = 13,
      this.overflow = TextOverflow.ellipsis,
      this.maxLinesToShow = 3});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLinesToShow,
      overflow: overflow,
      style: TextStyle(
        color: color,
        fontSize: size,
      ),
    );
  }
}
