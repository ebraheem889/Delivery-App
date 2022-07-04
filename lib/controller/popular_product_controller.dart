import 'package:deliverapp/controller/cart_controller.dart';
import 'package:deliverapp/data/reposetory/popular_product_repo.dart';
import 'package:deliverapp/model/cart_model.dart';
import 'package:deliverapp/model/popuar_product_model.dart';
import 'package:deliverapp/utilities/AppColors.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  late final PopularProductRepo popularProductRepo;
  List<ProductModel> _poularproductlist = [];
  List<ProductModel> get popularproductlist => _poularproductlist;
  bool isLoaded = false;
  int quantity = 0; // we use this var to increase and decrease
  int _inCartItems =
      0; // this var for quantity that comes from cart controller and it's the prev quantity
  Map<int, CartModel> cart = {};
  int get inCartItems =>
      _inCartItems +
      quantity; // this var for life quantity that show in front of user
  late CartController cartController;
  PopularProductController({required this.popularProductRepo});

  // return all popular product list
  Future<void> getpopularproductlist() async {
    Response response = await popularProductRepo.GetPopularProductList();
    if (response.statusCode == 200) {
      print("got Popular");
      _poularproductlist.clear();
      _poularproductlist.addAll(Product.fromJson(response.body).products!);
      isLoaded = true;
      update();
    } else {
      print("could not got Popular ${response.statusText}");
    }
  }

  initProduct(ProductModel Product, CartController cart) {
    quantity = 0;
    _inCartItems = 0;
    cartController = cart;
    var Exist = false;
    Exist = cartController.existInCart(Product);
    if (Exist) {
      _inCartItems = cartController.getQuentity(Product);
      // print("The Item Exits And It's Quantity Is " + inCartItems.toString());
    }
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      quantity = checkQuantity(quantity + 1);
      update();
    } else {
      quantity = checkQuantity(quantity - 1);
      update();
    }
  }

  int checkQuantity(int quantity) {
    if ((_inCartItems + quantity) < 0) {
      Get.snackbar(
        "Item Count",
        "You Can't Reduce More",
        backgroundColor: AppColors.mainColor,
        duration: Duration(seconds: 2),
      );
      if (_inCartItems > 0) {
        quantity = -_inCartItems;
        return quantity;
      }
      return 0;
    } else if ((_inCartItems + quantity) > 20) {
      Get.snackbar("Item Count", "You Can't Add More!",
          backgroundColor: AppColors.mainColor, duration: Duration(seconds: 2));
      return 20;
    } else {
      return quantity;
    }
  }

  void addItemsTocart(ProductModel productModel) {
    cartController.addItems(productModel, quantity);
    quantity = 0;
    _inCartItems = cartController.getQuentity(productModel);
    update();
  }

  int getTotalQuantity() {
    return cartController.getTotalQuantity();
  }
}
