import 'package:deliverapp/pages/CartPage.dart';
import 'package:deliverapp/pages/food/PopularFoodDetails.dart';
import 'package:deliverapp/pages/food/RecommendedFoodPage.dart';
import 'package:deliverapp/pages/home/MainFoodPage.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-Food";
  static const String cartPage = "/food-page";

  static String getInitialRoute() => '$initial';
  static String getPopularFoodRoute(int PageId, String Page) =>
      '$popularFood?PageId=$PageId&Page=$Page';
  static String getrecommendedFoodRoute(int PageId, String Page) =>
      '$recommendedFood?PageId=$PageId&Page=$Page';
  static String getrCartPageRoute() => '$cartPage';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => MainFoodPage()),
    GetPage(
        name: popularFood,
        page: () {
          var PageId = Get.parameters['PageId'];
          var Page = Get.parameters["Page"];
          return PopularFoodDetails(
              PageId: int.parse(PageId!), Page: Page.toString());
        },
        transition: Transition.fadeIn),
    GetPage(
        name: recommendedFood,
        page: () {
          var PageId = Get.parameters['PageId'];
          var Page = Get.parameters["Page"];
          return RecommendedFoodPage(
            PageId: int.parse(
              PageId!,
            ),
            Page: Page.toString(),
          );
        },
        transition: Transition.fadeIn),
    GetPage(
        name: cartPage,
        page: () {
          return CartPage();
        },
        transition: Transition.fadeIn)
  ];
}
