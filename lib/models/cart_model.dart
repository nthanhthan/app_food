class CartModel {
  String? foodId;
  String? foodName;
  int? price;
  String? imageUrl;
  int? quantity;
  bool? isExist;
  String? time;

  CartModel({
    this.foodId,
    this.foodName,
    this.price,
    this.imageUrl,
    this.quantity,
    this.isExist,
    this.time
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    foodId = json['foodId'];
    foodName = json['foodName'];
    price = json['price'];
    imageUrl = json['imageUrl'];
    quantity=json['quantity'];
    isExist=json['isExist'];
    time=json['time'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['foodId'] = this.foodId;
    data['foodName'] = this.foodName;
    data['price'] = this.price;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}