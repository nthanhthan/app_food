import 'dart:convert';
import 'package:app_food/base/show_custom_snackbar.dart';
import 'package:app_food/models/review_model.dart';
import 'package:get/get.dart';
import '../data/repository/foodOfStore_repo.dart';
import 'package:http/http.dart' as http;

import '../models/foodStore_model.dart';
class FoodOfStoreController extends GetxController{
  final FoodOfStoreRepo foodOfStoreRepo;
  FoodOfStoreController({required this.foodOfStoreRepo});
  dynamic _foodsStore;
  dynamic get foodsStore=>_foodsStore;
   List<dynamic> _foodOfStoreList=[];
   List<dynamic> listCommentStore=[];
   List<dynamic> get foodOfStoreList=>_foodOfStoreList;
  bool _isLoaded=false;
  bool get isLoaded=>_isLoaded;
  Future<bool> getAllFoodOfStore(id,lat,lng)async{
    _isLoaded=false;
    http.Response response=(await foodOfStoreRepo.getAllFoodOfStore(id,lat,lng));
    _foodOfStoreList=[];
    if(response.statusCode==200){
      _foodsStore=null;
      _foodsStore=FoodStore.fromJson(jsonDecode(response.body));
      _foodOfStoreList.addAll(FoodStore.fromJson(jsonDecode(response.body)).foods);
      _isLoaded=true;
      update();
      return true;
    }else{
      showCustomSnackBar("Vui lòng thử lại",);
      return false;
    }
  }
  getAllComment(id) async {
    _isLoaded=false;
    List<Review> reviews=[];
    listCommentStore=[];
    for(int i=0;;i++){
      http.Response response=await foodOfStoreRepo.getAllCommentStore(id, i);
      if(response.statusCode==200){
        List<dynamic>  decodedList = json.decode(response.body);
        reviews=[];
        reviews=List<Review>.from(decodedList.map((e) => Review.fromJson(e)));
        listCommentStore.addAll(reviews);
         _isLoaded=true;
         update();
        if(reviews.isEmpty){
          break;
        }
      }
    }

  }
}