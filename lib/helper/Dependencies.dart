import 'package:deliverapp/controller/cart_controller.dart';
import 'package:deliverapp/controller/popular_product_controller.dart';
import 'package:deliverapp/controller/recommended_product_controller.dart';
import 'package:deliverapp/data/Api.dart';
import 'package:deliverapp/data/reposetory/cart_repo.dart';
import 'package:deliverapp/data/reposetory/popular_product_repo.dart';
import 'package:deliverapp/data/reposetory/recommended_product_repo.dart';
import 'package:deliverapp/utilities/AppConstants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  // Obtain shared preferences.
  final prefs = await SharedPreferences.getInstance();
  Get.lazyPut(() => prefs);
  //api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

  // this for repo
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  // controller
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(
      () => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}
