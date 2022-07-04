import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utilities/AppColors.dart';
import '../utilities/Dimensions.dart';
import 'BigText.dart';
import 'IconAndTextWidget.dart';
import 'SmallText.dart';

class AppColumn extends StatelessWidget {
  final String text;
  int numberOfproductStars;
  AppColumn({required this.text, required this.numberOfproductStars});
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      BigText(
        text: text,
        color: Colors.black,
      ),
      SizedBox(
        height: Dimensions.Height10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Wrap(
            children: List.generate(numberOfproductStars, (index) {
              return const Icon(
                Icons.star,
                color: AppColors.mainColor,
              );
            }),
          ),
          SizedBox(
            width: Dimensions.Height10,
          ),
          SmallText(
            text: "${numberOfproductStars}",
            color: AppColors.textColor,
          ),
          SizedBox(
            width: Dimensions.Height10,
          ),
          SmallText(
            text: "1207 comment",
            color: AppColors.textColor,
          ),
        ],
      ),
      SizedBox(height: Dimensions.Height10),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        IconAndTextWidet(
          icon: Icons.circle,
          text: "Normal",
          Iconcolor: Colors.amber,
          Textcolor: AppColors.textColor,
        ),
        IconAndTextWidet(
          icon: Icons.location_on,
          text: "1.7 km",
          Iconcolor: Colors.blue,
          Textcolor: AppColors.textColor,
        ),
        IconAndTextWidet(
          icon: Icons.access_time_rounded,
          text: "55min",
          Iconcolor: Colors.red,
          Textcolor: AppColors.textColor,
        ),
      ])
    ]); // to be a seperated widget so that we can use it on more time later
  }
}
