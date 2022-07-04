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
      this.typeId});

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
  }
}
