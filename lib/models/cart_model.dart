import 'food_model.dart';

class CartModel {
  String? foodId;
  String? foodName;
  int? price;
  String? imageUrl;
  int? quantity;
  bool? isExist;
  String? time;
  late List<ListTopping> _listFoodTopping;
  List<ListTopping> get listFoodTopping=>_listFoodTopping;


  CartModel({
    this.foodId,
    this.foodName,
    this.price,
    this.imageUrl,
    this.quantity,
    this.isExist,
    this.time,
    required listFoodTopping,
  }
  ){
    _listFoodTopping=listFoodTopping;
  }

  CartModel.fromJson(Map<String, dynamic> json) {
    foodId = json['foodId'];
    foodName = json['foodName'];
    price = json['price'];
    imageUrl = json['imageUrl'];
    quantity=json['quantity'];
    isExist=json['isExist'];
    time=json['time'];
    if (json['ListTopping'] != null) {
      _listFoodTopping = <ListTopping>[];
      json['ListTopping'].forEach((v) {
        listFoodTopping!.add(new ListTopping.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['foodId'] = this.foodId;
    data['foodName'] = this.foodName;
    data['price'] = this.price;
    data['imageUrl'] = this.imageUrl;
    if (this.listFoodTopping != null) {
      data['ListTopping'] = this.listFoodTopping!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}