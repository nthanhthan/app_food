import 'dart:ffi';

import 'package:app_food/data/repository/cart_repo.dart';
import 'package:app_food/models/food_model.dart';
import 'package:get/get.dart';

import '../models/cart_model.dart';
import '../models/foodStore_model.dart';

class CartController extends GetxController{
  final CartRepo cartRepo;
  CartController({required this.cartRepo});
  Map<String,CartModel> _items={};
  Map<String,CartModel> get items=>_items;
  void addItem(FoodTopping food,int quantity){
    var totalQuantity=0;
    if(_items.containsKey(food.foodId!)){
      _items.update(food.foodId!, (value) {
        totalQuantity=value.quantity!+quantity;
        return CartModel(
          foodId:value.foodId,
          foodName:value.foodName,
          price:value.price,
          imageUrl:value.imageUrl,
          quantity:value.quantity!+quantity,
          isExist:true,
          time:DateTime.now().toString(),
        );
      });
      if(totalQuantity<=0){
        _items.remove(food.foodId);
      }
    }else{
    _items.putIfAbsent(food.foodId!, () {
      return CartModel(
        foodId:food.foodId,
        foodName:food.name,
        price:food.price,
        imageUrl:food.urlImage,
        quantity:quantity,
        isExist:true,
        time:DateTime.now().toString(),
    );});}
  }
  existInCart(FoodTopping food){
    if(_items.containsKey(food.foodId)){
      return true;
    }
    return false;
  }
  getQuantity(FoodTopping food){
    var quantity=0;
    if(_items.containsKey(food.foodId)){
      _items.forEach((key, value) {
        if(key==food.foodId){
          quantity=value.quantity!;
        }
      });

    }
    return quantity;
  }
  int get totalItems{
    var totalQuantity=0;
    _items.forEach((key, value) {
      totalQuantity+=value.quantity!;
    });
    return totalQuantity;
  }

}