import 'dart:convert';

import 'package:app_food/models/foodStore_model.dart';
import 'package:get/get.dart';
import '../data/repository/foodOfStore_repo.dart';
import '../models/store_model.dart';
import 'package:http/http.dart' as http;
class FoodOfStoreController extends GetxController{
  final FoodOfStoreRepo foodOfStoreRepo;
  FoodOfStoreController({required this.foodOfStoreRepo});
  dynamic _foodsStore;
  dynamic get foodsStore=>_foodsStore;
   List<dynamic> _foodOfStoreList=[];
   List<dynamic> get foodOfStoreList=>_foodOfStoreList;
  bool _isLoaded=false;
  bool get isLoaded=>_isLoaded;
  Future<void> getAllFoodOfStore(id,lat,lng)async{
    http.Response response=(await foodOfStoreRepo.getAllFoodOfStore(id,lat,lng));
    print(response.statusCode);
    print("food");
    if(response.statusCode==200){
      _foodsStore=FoodStore.fromJson(jsonDecode(response.body));
      _foodOfStoreList.addAll(FoodStore.fromJson(jsonDecode(response.body)).foods);
      _isLoaded=true;
      update();
    }else{
      print("sai");
    }
  }
}