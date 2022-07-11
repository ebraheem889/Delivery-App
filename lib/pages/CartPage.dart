import 'package:deliverapp/applicationRoutes/RouteHelper.dart';
import 'package:deliverapp/controller/cart_controller.dart';
import 'package:deliverapp/controller/popular_product_controller.dart';
import 'package:deliverapp/controller/recommended_product_controller.dart';
import 'package:deliverapp/pages/home/MainFoodPage.dart';
import 'package:deliverapp/utilities/AppColors.dart';
import 'package:deliverapp/utilities/Dimensions.dart';
import 'package:deliverapp/widgets/AppIcon.dart';
import 'package:deliverapp/widgets/BigText.dart';
import 'package:deliverapp/widgets/CustomBottomNavigationBar.dart';
import 'package:deliverapp/widgets/SmallText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utilities/AppConstants.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var product = Get.find<PopularProductController>().popularproductlist;

    return Scaffold(
        body: Stack(
          children: [
            Positioned(
                top: Dimensions.Height45,
                left: Dimensions.Width20,
                right: Dimensions.Width20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (() {
                        Get.to(MainFoodPage());
                      }),
                      child: AppIcon(
                        Iconsize: Dimensions.iconSize24,
                        size: 45,
                        icon: Icons.arrow_back,
                        color: Colors.white,
                        CustomBackgroundColor: AppColors.mainColor,
                      ),
                    ),
                    SizedBox(
                      width: Dimensions.Width45 * 4,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(MainFoodPage());
                      },
                      child: AppIcon(
                        Iconsize: Dimensions.iconSize24,
                        size: 45,
                        icon: Icons.home_outlined,
                        color: Colors.white,
                        CustomBackgroundColor: AppColors.mainColor,
                      ),
                    ),
                    AppIcon(
                      Iconsize: Dimensions.iconSize24,
                      size: 45,
                      icon: Icons.shopping_cart_outlined,
                      color: Colors.white,
                      CustomBackgroundColor: AppColors.mainColor,
                    )
                  ],
                )),
            Positioned(
              top: Dimensions.Height45 * 2,
              left: Dimensions.Width20,
              right: Dimensions.Width20,
              bottom: 0,
              child: Container(
                  margin: EdgeInsets.only(top: Dimensions.Height15),
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: GetBuilder<CartController>(builder: (controller) {
                      var AllItems =
                          Get.find<CartController>().getAllCartItems();
                      return ListView.builder(
                          itemCount: AllItems.length,
                          itemBuilder: (_, index) {
                            return Container(
                              margin:
                                  EdgeInsets.only(bottom: Dimensions.Height10),
                              color: Colors.white,
                              height: Dimensions.Heigh120,
                              width: Dimensions.Width200,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      var popularIndex = product.indexWhere(
                                          (Element) =>
                                              Element.id == AllItems[index].id);

                                      if (popularIndex >= 0) {
                                        Get.toNamed(
                                            RouteHelper.getPopularFoodRoute(
                                                popularIndex, "CartPage"));
                                      } else {
                                        var recommendedIndex = Get.find<
                                                RecommendedProductController>()
                                            .recommendedproductlist
                                            .indexWhere((Element) =>
                                                Element.id ==
                                                AllItems[index].id);
                                        Get.toNamed(
                                            RouteHelper.getrecommendedFoodRoute(
                                                recommendedIndex, "CartPage"));
                                      }
                                    },
                                    child: Container(
                                      height: Dimensions.Heigh120,
                                      width: Dimensions.Width100 + 20,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.black,
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                AppConstants.BASE_URL +
                                                    "/uploads/" +
                                                    AllItems[index].img!),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: Dimensions.Width200 + 102,
                                    padding: EdgeInsets.only(top: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        BigText(
                                          text: AllItems[index].name!,
                                          color: Colors.black,
                                        ),
                                        SmallText(
                                          text: AllItems[index].description!,
                                          color: AppColors.textColor,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            BigText(
                                              text: AllItems[index]
                                                  .price
                                                  .toString(),
                                              color: Colors.red,
                                            ),
                                            Container(
                                                child: Row(
                                              children: [
                                                GestureDetector(
                                                    onTap: () {
                                                      controller.addItems(
                                                          AllItems[index]
                                                              .product!,
                                                          -1);
                                                    },
                                                    child: Icon(
                                                      Icons.remove,
                                                    )),
                                                BigText(
                                                  text: AllItems[index]
                                                      .quantity
                                                      .toString(),
                                                  color: Color.fromARGB(
                                                      255, 61, 60, 60),
                                                ),
                                                GestureDetector(
                                                    onTap: () {
                                                      controller.addItems(
                                                          AllItems[index]
                                                              .product!,
                                                          1);
                                                    },
                                                    child: Icon(Icons.add))
                                              ],
                                            ))
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                    }),
                  )),
            )
          ],
        ),
        bottomNavigationBar: Container(
          height: 100,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 224, 223, 219),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.raduis30),
              topRight: Radius.circular(Dimensions.raduis30),
            ),
          ),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Container(
              padding: EdgeInsets.all(15),
              height: Dimensions.Heigh60,
              width: Dimensions.Width100 + 20,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: GetBuilder<CartController>(builder: (controller) {
                return BigText(
                  text: "\$ ${controller.getTotalFees()}",
                  color: Color.fromARGB(255, 80, 78, 77),
                );
              }),
            ),
            Container(
              padding: EdgeInsets.all(15),
              height: Dimensions.Heigh60,
              width: Dimensions.Width100 + 40,
              decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: BigText(
                text: "Check Out",
                color: Color.fromARGB(255, 80, 78, 77),
              ),
            ),
          ]),
        ));
  }
}
