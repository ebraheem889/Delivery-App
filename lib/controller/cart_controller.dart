import 'package:deliverapp/data/reposetory/cart_repo.dart';
import 'package:deliverapp/model/cart_model.dart';
import 'package:deliverapp/model/popuar_product_model.dart';
import 'package:get/get.dart';

import '../utilities/AppColors.dart';

class CartController extends GetxController {
  CartRepo cartRepo;
  Map<int, CartModel> Items = {};

  CartController({required this.cartRepo});

  // it responsible for adding Elements to the items
  void addItems(ProductModel productToAdd, int quantity) {
    var totalquantity = 0;
    // check first if this very product in the Items(the map we declare up there ) and if it's then we will update it
    if (Items.containsKey(productToAdd.id!)) {
      Items.update(productToAdd.id!, (value) {
        totalquantity = value.quantity! + quantity;
        return CartModel(
            id: value.id,
            name: value.name,
            description: value.description,
            price: value.price,
            stars: value.stars,
            quantity: value.quantity! + quantity,
            time: DateTime.now().toString(),
            isExists: true,
            img: value.img,
            typeId: value.typeId,
            product: value.product);
      });
      // to remove the product if it's quantity equal zero
      removeIf(productToAdd, totalquantity);
    } else {
      //if the scenario got here that means the product is not in the Items(the map we declare up there ) so we will add it but first
      //1- check if the quantity of the item that we are going to add greater than zero or ont,
      //2- if it's then we weill add it if not we will send a message to the user let him know that it's not allowed
      if (quantity > 0) {
        Items.putIfAbsent(productToAdd.id!, () {
          return CartModel(
              id: productToAdd.id,
              name: productToAdd.name,
              description: productToAdd.description,
              price: productToAdd.price,
              stars: productToAdd.stars,
              quantity: quantity,
              time: DateTime.now().toString(),
              isExists: true,
              img: productToAdd.img,
              typeId: productToAdd.typeId,
              product: productToAdd);
        });
      } else {
        Get.snackbar("Item Count", "You Can't Add Less Than One Item ",
            backgroundColor: AppColors.mainColor);
      }
    }

    cartRepo.addItemToLocaleStorage(getAllCartItems());

    update();
  }

  // this function check if a specific product exist in the Items(the map we declare up there ) or not
  bool existInCart(ProductModel productModel) {
    if (Items.containsKey(productModel.id)) {
      return true;
    }
    return false;
  }

  // return the quantity of a specific product
  int getQuentity(ProductModel Product) {
    var quantity = 0;
    if (Items.containsKey(Product.id!)) {
      Items.forEach((key, value) {
        if (Product.id! == key) {
          quantity = value.quantity!;
        }
      });
    }

    return quantity;
  }

  // return the total quantity of all products
  int getTotalQuantity() {
    var totalquantity = 0;
    Items.forEach((key, value) {
      totalquantity += value.quantity!;
    });
    return totalquantity;
  }

// return the total Fees of product that have been added to cart
  int getTotalFees() {
    var totalFees = 0;
    Items.forEach((key, value) {
      totalFees = totalFees + (value.price! * value.quantity!);
    });
    return totalFees;
  }

  // it remove an item if it's quantity equal to zero
  void removeIf(ProductModel product, int totalquantity) {
    if (totalquantity <= 0) {
      if (totalquantity <= 0) {
        Items.remove(product.id!);
      }
    }
  }

  List<CartModel> getAllCartItems() {
    List<CartModel> allInCart = Items.entries.map((e) {
      return e.value;
    }).toList();

    return allInCart;
  }

// responsible for gettig cart list from local storage
  List<CartModel> getCartData() {
    var StorageCartList = cartRepo.getCartList();

    print("Getting Storage Cart List " + StorageCartList.toString());
    return StorageCartList;
  }

// resposible for set Items List Again after the app been killed
  void SetCarListFromLocalStorage() {
    var StorageCartList = getCartData();

    for (int i = 0; i < StorageCartList.length; i++) {
      Items.putIfAbsent(
          StorageCartList[i].product!.id!, () => StorageCartList[i]);
    }
  }
}
