import 'dart:ffi';

import 'package:deliverapp/applicationRoutes/RouteHelper.dart';
import 'package:deliverapp/controller/popular_product_controller.dart';
import 'package:deliverapp/controller/recommended_product_controller.dart';
import 'package:deliverapp/pages/food/PopularFoodDetails.dart';
import 'package:deliverapp/utilities/AppColors.dart';
import 'package:deliverapp/utilities/AppConstants.dart';
import 'package:deliverapp/utilities/Dimensions.dart';
import 'package:deliverapp/widgets/BigText.dart';
import 'package:deliverapp/widgets/IconAndTextWidget.dart';
import 'package:deliverapp/widgets/SmallText.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../../widgets/AppColumn.dart';

class FoodPage extends StatefulWidget {
  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  PageController pageController = PageController(viewportFraction: 0.85);

  var _currPageValue = 0.0;

  // we use it so that we initialize some staff
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  // we use it so that we let the memory know that we are not need these page or the things we put inside this function
  // it's a better for the performance
  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // Slider Section
      GetBuilder<PopularProductController>(builder: (popularproductcontroller) {
        return popularproductcontroller.isLoaded
            ? Container(
                height: Dimensions.PageView,
                child: PageView.builder(
                    controller: pageController,
                    itemCount:
                        popularproductcontroller.popularproductlist.length,
                    itemBuilder: (ctx, position) {
                      return _buildPageItem(position, popularproductcontroller);
                    }),
              )
            : const CircularProgressIndicator(
                color: AppColors.mainColor,
                backgroundColor: Colors.white,
              );
      }),
      // Dots Indicator
      GetBuilder<PopularProductController>(builder: (popularproductcontroller) {
        return Center(
            child: DotsIndicator(
          dotsCount: popularproductcontroller.popularproductlist.isEmpty
              ? 1
              : popularproductcontroller.popularproductlist.length,
          position: _currPageValue,
          decorator: DotsDecorator(
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeColor: AppColors.mainColor,
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        ));
      }),

      SizedBox(
        height: Dimensions.Height15,
      ),

      // recommended Text
      Container(
        margin: EdgeInsets.only(
            left: Dimensions.Height30, right: Dimensions.Height30),
        child: Row(
          children: [
            BigText(
              text: "Recommended",
              color: Colors.black,
            ),
          ],
        ),
      ),
      SizedBox(
        height: Dimensions.Height15,
      ),
      // popular Lists
      GetBuilder<RecommendedProductController>(
          builder: (recommendedProductController) {
        return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount:
                recommendedProductController.recommendedproductlist.length,
            itemBuilder: (ctx, index) {
              return GestureDetector(
                onTap: () =>
                    (Get.toNamed(RouteHelper.getrecommendedFoodRoute(index))),
                child: Container(
                    child: Row(
                  children: [
                    // container for recommended product img
                    recommendedProductController.isLoaded
                        ? Container(
                            margin: EdgeInsets.only(
                                left: Dimensions.Height20,
                                bottom: Dimensions.Height10),
                            height: Dimensions.Heigh120,
                            width: Dimensions.Heigh120,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.Height30),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(AppConstants.BASE_URL +
                                    "/uploads/" +
                                    recommendedProductController
                                        .recommendedproductlist[index].img!),
                              ),
                            ),
                          )
                        : const CircularProgressIndicator(
                            color: AppColors.mainColor,
                          ),
                    Container(
                      padding: EdgeInsets.all(10),
                      height: Dimensions.Heigh120,
                      width: Dimensions.Width200 + 100,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(Dimensions.Height30),
                              bottomRight:
                                  Radius.circular(Dimensions.Height30))),
                      // column for right cart and it contains name and description
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BigText(
                            text: recommendedProductController
                                .recommendedproductlist[index].name!,
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: Dimensions.Height10,
                          ),
                          SmallText(
                            text: recommendedProductController
                                .recommendedproductlist[index].description!,
                            color: AppColors.textColor,
                            maxLinesToShow: 1,
                          ),
                          SizedBox(
                            height: Dimensions.Height10,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
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
                              ]),
                        ],
                      ),
                    )
                  ],
                )),
              );
            });
      }),
    ]);
  }

  Widget _buildPageItem(
      int position, PopularProductController popularproductcontroller) {
    return GestureDetector(
      onTap: () => {Get.toNamed(RouteHelper.getPopularFoodRoute(position))},
      child: Stack(
        children: [
          Container(
            height: Dimensions.PageViewContainer,
            margin: EdgeInsets.only(
                left: Dimensions.Width5,
                right: Dimensions.Width5,
                top: Dimensions.Height5),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(AppConstants.BASE_URL +
                        "/uploads/" +
                        popularproductcontroller
                            .popularproductlist[position].img!),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(Dimensions.Height30),
                color: AppColors.iconColor2),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.Height20,
                    left: Dimensions.Height20,
                    right: Dimensions.Width15),
                height: Dimensions.PageViewTextContainer,
                margin: EdgeInsets.only(
                    left: Dimensions.Width30,
                    right: Dimensions.Width30,
                    bottom: Dimensions.Height10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.Height30),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        color: Color.fromARGB(255, 204, 200, 200),
                        blurRadius: 5.0,
                        offset: Offset(0, 5)),
                  ],
                ),
                child: AppColumn(
                  numberOfproductStars: popularproductcontroller
                      .popularproductlist[position].stars!,
                  text: popularproductcontroller
                      .popularproductlist[position].name!,
                )),
          ),
        ],
      ),
    );
  }
}
