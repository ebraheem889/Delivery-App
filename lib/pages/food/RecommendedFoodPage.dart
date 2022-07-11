import 'package:deliverapp/applicationRoutes/RouteHelper.dart';
import 'package:deliverapp/controller/popular_product_controller.dart';
import 'package:deliverapp/data/reposetory/recommended_product_repo.dart';
import 'package:deliverapp/pages/CartPage.dart';
import 'package:deliverapp/utilities/AppColors.dart';
import 'package:deliverapp/utilities/Dimensions.dart';
import 'package:deliverapp/widgets/AppIcon.dart';
import 'package:deliverapp/widgets/BigText.dart';
import 'package:deliverapp/widgets/ExpandedTextWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/cart_controller.dart';
import '../../controller/recommended_product_controller.dart';
import '../../utilities/AppConstants.dart';
import '../../widgets/CustomBottomNavigationBar.dart';

class RecommendedFoodPage extends StatelessWidget {
  final int PageId;
  String Page;
  RecommendedFoodPage({Key? key, required this.PageId, required this.Page})
      : super(key: key);

  // var Product = Get.find<RecommendedProductController>().recommendedproductlist[PageId];

  @override
  Widget build(BuildContext context) {
    //var Product = Get.find<RecommendedProductController>();
    var Product =
        Get.find<RecommendedProductController>().recommendedproductlist[PageId];
    Get.find<PopularProductController>()
        .initProduct(Product, Get.find<CartController>());

    return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              title: Row(
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
                      child: AppIcon(icon: Icons.clear)),
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
                                  text:
                                      controller.getTotalQuantity().toString(),
                                  color: Colors.white,
                                ),
                              )
                            : Container();
                      }),
                    )
                  ]),
                ],
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(Dimensions.Height45),
                child: Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  width: double.maxFinite,
                  child: Center(
                    child: BigText(
                      text: Product.name!,
                      color: Colors.black,
                    ),
                  ),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                ),
              ),
              backgroundColor: AppColors.mainColor,
              pinned: true,
              expandedHeight: Dimensions.PageViewContainer + 50,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                    AppConstants.BASE_URL + "/uploads/" + Product.img!,
                    fit: BoxFit.cover,
                    width: double.maxFinite),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(children: [
                Container(
                    margin: EdgeInsets.only(
                        bottom: Dimensions.Height10,
                        top: Dimensions.Height10,
                        left: Dimensions.Width20,
                        right: Dimensions.Width20),
                    child: ExpandedTextWidget(
                      text: Product.description!,
                    )),
              ]),
            )
          ],
        ),
        bottomNavigationBar:
            GetBuilder<PopularProductController>(builder: (controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: Dimensions.Height10,
                    left: Dimensions.Width20,
                    right: Dimensions.Width20,
                    bottom: Dimensions.Height10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.setQuantity(false);
                      },
                      child: AppIcon(
                        icon: Icons.remove,
                        CustomBackgroundColor: AppColors.mainColor,
                      ),
                    ),
                    BigText(
                        text:
                            "\$ ${Product.price} X ${controller.inCartItems} "),
                    GestureDetector(
                        onTap: () {
                          controller.setQuantity(true);
                        },
                        child: AppIcon(
                          icon: Icons.add,
                          CustomBackgroundColor: AppColors.mainColor,
                        ))
                  ],
                ),
              ),
              // end of first container
              Container(
                height: Dimensions.Heigh60 + 40,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 228, 231, 230),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.raduis30),
                      topRight: Radius.circular(Dimensions.raduis30)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: Dimensions.Heigh60,
                      width: Dimensions.Width45 + 15,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(Dimensions.raduis30)),
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
                      child: GestureDetector(
                        onTap: () {
                          controller.addItemsTocart(Product);
                        },
                        child: BigText(
                          text: " \$ ${Product.price!} Add to cart",
                          color: Color.fromARGB(255, 235, 231, 229),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        }));
  }
}
