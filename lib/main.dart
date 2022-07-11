import 'dart:io';

import 'package:deliverapp/applicationRoutes/RouteHelper.dart';
import 'package:deliverapp/controller/cart_controller.dart';
import 'package:deliverapp/controller/recommended_product_controller.dart';
import 'package:deliverapp/data/Api.dart';
import 'package:deliverapp/helper/Dependencies.dart';
import 'package:deliverapp/pages/CartPage.dart';
import 'package:deliverapp/pages/food/PopularFoodDetails.dart';
import 'package:deliverapp/pages/food/RecommendedFoodPage.dart';
import 'package:deliverapp/pages/home/FoodPage.dart';
import 'package:deliverapp/utilities/AppConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'controller/popular_product_controller.dart';
import 'helper/Dependencies.dart' as dep;
import 'pages/home/MainFoodPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    Get.find<PopularProductController>().getpopularproductlist();
    Get.find<RecommendedProductController>().GetRecommendedProductlist();
    return GetMaterialApp(
      title: 'DeliveryApp',
      home: MainFoodPage(),
      debugShowCheckedModeBanner: false,
      initialRoute: RouteHelper.initial,
      getPages: RouteHelper.routes,
    );
  }
}
