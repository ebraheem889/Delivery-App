import 'package:deliverapp/model/popuar_product_model.dart';

class CartModel {
  int? id;
  String? name;
  String? description;
  int? price;
  int? stars;
  int? quantity;
  String? time;
  bool? isExists;
  String? img;
  int? typeId;
  ProductModel? product;

  CartModel(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.stars,
      this.quantity,
      this.time,
      this.isExists,
      this.img,
      this.typeId,
      this.product});

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    stars = json['stars'];
    quantity = json['quantity'];
    time = json['time'];
    isExists = json['isExists'];
    img = json['img'];
    typeId = json['type_id'];
    product = ProductModel.fromJson(json["product"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "description": this.description,
      "price": this.price,
      "stars": this.stars,
      "quantity": this.quantity,
      "time": this.time,
      "isExists": this.isExists,
      "img": this.img,
      "typeId": this.typeId,
      "product": this.product!.toJson()
    };
  }
}
