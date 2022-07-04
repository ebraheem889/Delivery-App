import 'package:deliverapp/utilities/AppColors.dart';
import 'package:deliverapp/utilities/Dimensions.dart';
import 'package:deliverapp/widgets/SmallText.dart';
import 'package:deliverapp/widgets/bigText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../home/FoodPage.dart';

class MainFoodPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Padding(
          padding: EdgeInsets.only(
              top: Dimensions.Height45,
              left: Dimensions.Height20,
              right: Dimensions.Height20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  BigText(
                    text: "Egypte",
                    color: AppColors.mainColor,
                  ),
                  Row(
                    children: [
                      SmallText(
                        text: "Cairo",
                        color: Colors.black54,
                      ),
                      Icon(Icons.arrow_drop_down_rounded),
                    ],
                  )
                ],
              ),
              Container(
                width: Dimensions.Height45,
                height: Dimensions.Height45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.mainColor,
                ),
                child: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
        Expanded(
            child: SingleChildScrollView(
          child: FoodPage(),
        )),
      ]),
    );
  }
}
