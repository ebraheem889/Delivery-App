import 'package:deliverapp/applicationRoutes/RouteHelper.dart';
import 'package:deliverapp/controller/cart_controller.dart';
import 'package:deliverapp/controller/popular_product_controller.dart';
import 'package:deliverapp/pages/CartPage.dart';
import 'package:deliverapp/pages/home/FoodPage.dart';
import 'package:deliverapp/pages/home/MainFoodPage.dart';
import 'package:deliverapp/utilities/AppColors.dart';
import 'package:deliverapp/widgets/AppIcon.dart';
import 'package:deliverapp/widgets/AppColumn.dart';
import 'package:deliverapp/widgets/ExpandedTextWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../../utilities/AppConstants.dart';
import '../../utilities/Dimensions.dart';
import '../../widgets/BigText.dart';
import '../../widgets/IconAndTextWidget.dart';
import '../../widgets/SmallText.dart';

class PopularFoodDetails extends StatelessWidget {
  int PageId;
  String Page;
  PopularFoodDetails({required this.PageId, required this.Page});

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    var Product =
        Get.find<PopularProductController>().popularproductlist[PageId];
    Get.find<PopularProductController>()
        .initProduct(Product, Get.find<CartController>());
    return Scaffold(
      body: Stack(children: [
        //  product image
        Positioned(
          height: Dimensions.Heigh300,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        AppConstants.BASE_URL + "/uploads/" + Product.img!))),
          ),
        ),

        // for back and add_to_cart buttons
        Positioned(
            left: Dimensions.Width30,
            right: Dimensions.Width30,
            top: Dimensions.Height45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    if (Page == "CartPage") {
                      Get.toNamed(RouteHelper.getrCartPageRoute());
                    } else {
                      Get.toNamed(RouteHelper.getInitialRoute());
                    }
                  },
                  child: AppIcon(
                    icon: Icons.arrow_back_ios,
                  ),
                ),
                Stack(children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.cartPage);
                    },
                    child: AppIcon(
                      icon: Icons.shopping_cart_outlined,
                    ),
                  ),
                  Positioned(
                    right: Dimensions.Width10,
                    top: 0,
                    child: GetBuilder<PopularProductController>(
                        builder: (controller) {
                      return controller.getTotalQuantity() >= 1
                          ? Container(
                              padding: EdgeInsets.only(left: 5, top: 1),
                              decoration: BoxDecoration(
                                  color: AppColors.mainColor,
                                  borderRadius: BorderRadius.circular(15)),
                              width: 18,
                              height: 18,
                              child: BigText(
                                size: 13,
                                text: controller.getTotalQuantity().toString(),
                                color: Colors.white,
                              ),
                            )
                          : Container();
                    }),
                  )
                ]),
              ],
            )),
        // product description
        Positioned(
          top: Dimensions.PopularFoodDetails_DescHeight,
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            padding: EdgeInsets.only(
                left: Dimensions.Width30,
                right: Dimensions.Width30,
                top: Dimensions.Height20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.raduis20),
                  topRight: Radius.circular(Dimensions.raduis20),
                )),
            // for introduce word and product description
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // starts and comments
                AppColumn(
                  numberOfproductStars: Product.stars!,
                  text: Product.name!,
                ),
                SizedBox(
                  height: Dimensions.Height10,
                ),
                BigText(
                  text: "Introduce",
                ),
                SizedBox(
                  height: Dimensions.Height10,
                ),
                // product Description
                Expanded(
                  child: SingleChildScrollView(
                    child: ExpandedTextWidget(text: Product.description!),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (popularProductController) {
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
                  width: Dimensions.Width100 + 30,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(Dimensions.raduis30)),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                            onTap: () {
                              popularProductController.setQuantity(false);
                            },
                            child: Icon(
                              Icons.remove,
                            )),
                        BigText(
                          text: popularProductController.inCartItems.toString(),
                          color: Color.fromARGB(255, 61, 60, 60),
                        ),
                        GestureDetector(
                            onTap: () {
                              popularProductController.setQuantity(true);
                            },
                            child: Icon(Icons.add))
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
                  child: GestureDetector(
                    onTap: () {
                      popularProductController.addItemsTocart(
                        Product,
                      );
                    },
                    child: BigText(
                      text: "\$ ${Product.price} Add to cart",
                      color: Color.fromARGB(255, 235, 231, 229),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
