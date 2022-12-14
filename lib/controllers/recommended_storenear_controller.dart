import 'dart:convert';

import 'package:app_food/base/show_custom_snackbar.dart';
import 'package:app_food/data/repository/recommended_storenear_repo.dart';
import 'package:app_food/models/store_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
class RecommendedStoreNearController extends GetxController{
  final RecommendedStoreNearRepo recommendedStoreNearRepo;
  RecommendedStoreNearController({required this.recommendedStoreNearRepo});
  List<dynamic> _storeNearList=[];
  List<dynamic> get storeNearList=>_storeNearList;
  bool _isLoaded=false;
  bool get isLoaded=>_isLoaded;
  Future<void> getRecommendedStoreNearList(data)async{
    _isLoaded=false;
    http.Response response=(await recommendedStoreNearRepo.getRecommendedStoreNearList(data));
    _storeNearList=[];
    if(response.statusCode==200){
      List<dynamic>  decodedList = json.decode(response.body);
      List<Store> posts = List<Store>.from(decodedList.map((model)=> Store.fromJson(model)));
      print(posts.length);
     _storeNearList.addAll(posts);
     print(_storeNearList);
     _isLoaded=true;
      update();
    }else{

     //showCustomSnackBar("Thử lại sau",title: "Lỗi");
    }
  }
}