import 'dart:convert';

import 'package:deliverapp/model/popuar_product_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/cart_model.dart';

class CartRepo extends GetxService {
  SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});
  List<String> Cart = [];

  void addItemToLocaleStorage(List<CartModel> CartList) {
    Cart = [];
    CartList.forEach((element) {
      return Cart.add(jsonEncode(element));
    });

    sharedPreferences.setStringList("Cart-List", Cart);
  }

  List<CartModel> getCartList() {
    List<CartModel> CartItems = [];

    if (sharedPreferences.containsKey("Cart-List")) {
      var Items = sharedPreferences.getStringList("Cart-List");
      Items!.map((element) {
        return CartItems.add(CartModel.fromJson(jsonDecode(element)));
      }).toList();
    }

    return CartItems;
  }
}
