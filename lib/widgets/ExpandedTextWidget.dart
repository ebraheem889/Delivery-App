import 'dart:ffi';

import 'package:deliverapp/utilities/AppColors.dart';
import 'package:deliverapp/utilities/Dimensions.dart';
import 'package:deliverapp/widgets/SmallText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpandedTextWidget extends StatefulWidget {
  late final String text;

  ExpandedTextWidget({required this.text});
  @override
  State<ExpandedTextWidget> createState() => _ExpandedTextWidgetState();
}

class _ExpandedTextWidgetState extends State<ExpandedTextWidget> {
  bool HiddenText = true;
  late final String FirstHalf;
  late final String SecondHalf;
  double textHeight = Dimensions.ScreenHeight / 5.63;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      FirstHalf = widget.text.substring(0, textHeight.toInt());
      SecondHalf =
          widget.text.substring((textHeight + 1).toInt(), widget.text.length);
    } else {
      FirstHalf = widget.text;
      SecondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SecondHalf.isEmpty
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SmallText(
                    text: FirstHalf,
                    color: AppColors.PopularFoodDetailsColor,
                  )
                ],
              )
            : Column(
                children: [
                  HiddenText
                      ? SmallText(
                          text: FirstHalf + "....",
                          color: AppColors.PopularFoodDetailsColor,
                        )
                      : SmallText(
                          text: FirstHalf + SecondHalf,
                          color: AppColors.PopularFoodDetailsColor,
                          maxLinesToShow: 100,
                        ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        HiddenText = !HiddenText;
                      });
                    },
                    child: Row(children: [
                      HiddenText
                          ? Row(
                              children: [
                                SmallText(
                                  text: "show more",
                                  color: AppColors.mainColor,
                                ),
                                Icon(Icons.arrow_drop_down)
                              ],
                            )
                          : Row(
                              children: [
                                SmallText(
                                  text: "show less",
                                  color: AppColors.mainColor,
                                ),
                                Icon(Icons.arrow_drop_up)
                              ],
                            )
                    ]),
                  )
                ],
              ));
  }
}
