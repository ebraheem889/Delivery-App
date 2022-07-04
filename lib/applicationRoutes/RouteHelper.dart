import 'package:deliverapp/pages/food/PopularFoodDetails.dart';
import 'package:deliverapp/pages/food/RecommendedFoodPage.dart';
import 'package:deliverapp/pages/home/MainFoodPage.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-Food";

  static String getInitialRoute() => '$initial';
  static String getPopularFoodRoute(int PageId) =>
      '$popularFood?PageId=$PageId';
  static String getrecommendedFoodRoute(int PageId) =>
      '$recommendedFood?PageId=$PageId';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => MainFoodPage()),
    GetPage(
        name: popularFood,
        page: () {
          var PageId = Get.parameters['PageId'];
          return PopularFoodDetails(PageId: int.parse(PageId!));
        },
        transition: Transition.fadeIn),
    GetPage(
        name: recommendedFood,
        page: () {
          var PageId = Get.parameters['PageId'];
          return RecommendedFoodPage(
            PageId: int.parse(PageId!),
          );
        },
        transition: Transition.fadeIn)
  ];
}
