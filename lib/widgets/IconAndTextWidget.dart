import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utilities/AppColors.dart';
import 'SmallText.dart';

class IconAndTextWidet extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color Iconcolor;
  final Color Textcolor;

  IconAndTextWidet(
      {required this.icon,
      required this.text,
      required this.Iconcolor,
      required this.Textcolor});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Iconcolor),
        SmallText(
          text: text,
          color: Textcolor,
        ),
      ],
    );
  }
}
