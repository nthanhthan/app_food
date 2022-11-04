import 'dart:convert';

import 'package:app_food/controllers/cart_controller.dart';
import 'package:app_food/models/foodStore_model.dart';
import 'package:app_food/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

import '../data/repository/foodDetail_repo.dart';
import '../models/food_model.dart';

class FoodDetailController extends GetxController {
  final FoodDetailRepo foodDetailRepo;
  FoodDetailController({required this.foodDetailRepo});
  dynamic _foodsDetail;
  dynamic get foodsDetail => _foodsDetail;
  List<dynamic> _toppingFood = [];
  List<dynamic> get toppingFood => _toppingFood;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  late Foods food;
  int get inCartItems => _inCartItems+_quantity;
  List<dynamic> _listTopping=[];
  List<dynamic> get listTopping=>_listTopping;
  late CartController _cart;
  late List<String> _topping;
   List<String> get  topping=>_topping;


  Future<bool> getFoodDetailById(id) async {
    http.Response response = (await foodDetailRepo.getFoodDetail(id));
    if (response.statusCode == 200) {
      _foodsDetail = null;
      _foodsDetail = FoodTopping.fromJson(jsonDecode(response.body));
      _toppingFood = [];
      _toppingFood.addAll(FoodTopping.fromJson(jsonDecode(response.body)).listTopping);
      _isLoaded = true;
      print(_foodsDetail.name);
      update();
      initFood(_foodsDetail, Get.find<CartController>());
     // return _foodsDetail;
      return true;
    } else {
      return false;
      // return false;
    }
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = _quantity + 1;
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  int checkQuantity(int quantity) {
    if ((_inCartItems+quantity) < 0) {
      Get.snackbar("Không hợp lệ", "Bạn không thể xóa thêm",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      return 0;
    }
    return quantity;
  }

  void initFood(FoodTopping food, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(food);
    if(exist){
      _inCartItems=_cart.getQuantity(food);
      _listTopping=_cart.getListTopping(food);
      print(_listTopping.length);
    }
  }

  void addItem(FoodTopping food,List<ListTopping> topping) {
    if (inCartItems>= 0) {
      _cart.addItem(food, _quantity,topping);
      _quantity = 0;
      _inCartItems=_cart.getQuantity(food);
    } else {
      Get.snackbar("Không hợp lệ", "Bạn chưa chọn số lượng",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
    }
    update();
  }
  int get totalItems{
    return _cart.totalItems;
  }
  var check=false;
  void addTopping(isSelected, toppingID){
    if(isSelected){
      _topping.add(toppingID);
    }else{
      _topping.remove(toppingID);
    }
    print(topping);
  }
}
