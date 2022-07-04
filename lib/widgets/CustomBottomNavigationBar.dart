import 'package:deliverapp/widgets/AppIcon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utilities/AppColors.dart';
import '../utilities/Dimensions.dart';
import 'BigText.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final IconData icon;
  Color? iconColor;
  String priceText;
  CustomBottomNavigationBar(
      {required this.icon, this.iconColor, this.priceText = ""});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.BottomNavigationBarHeight,
      decoration: BoxDecoration(
          color: AppColors.bottomNavigationColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.Height30),
            topRight: Radius.circular(Dimensions.Height30),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: Dimensions.Heigh60,
            width: Dimensions.Width45 + 15,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Dimensions.raduis30)),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.favorite,
                    color: AppColors.mainColor,
                    size: 30,
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            height: Dimensions.Heigh60,
            width: Dimensions.Width200 + 50,
            decoration: BoxDecoration(
              color: AppColors.mainColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: BigText(
              text: priceText,
              color: Color.fromARGB(255, 235, 231, 229),
            ),
          )
        ],
      ),
    );
  }
}
