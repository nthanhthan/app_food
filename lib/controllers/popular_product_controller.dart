import 'dart:convert';

import 'package:app_food/data/repository/popular_product_repo.dart';
import 'package:app_food/models/user_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PopularProductController extends GetxController{
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  final List<dynamic> _popularProductList=[];
  List<dynamic> get popularProductList=>_popularProductList;
  // Future<void> getPopularProductList()async{
  //  Response response= await popularProductRepo.getPopularProductList();
  //  if(response.statusCode==200){
  //    _popularProductList=[];
  //   // _popularProductList.addAll();
  //    update();
  //
  //  }else{
  //
  //  }
  // }
  Future<bool> SignUp(data,url) async{
    http.Response response=(await popularProductRepo.SignUp(data, url));
    if(response.statusCode==200){
     print("Register success");
     return true;
    }else{
      print("Failed Register");
      return false;
    }
  }
  bool LogOut(){
    return popularProductRepo.LogOut();
  }
  Future<bool> SignIn(data,url) async{
    http.Response response=(await popularProductRepo.SignIn(data, url));
    String? allSetCookie=response.headers['set-cookie'];
    print(allSetCookie);

    print(response.statusCode);
    if(response.statusCode==200){
      Map<String,dynamic> output=json.decode(response.body);
      print(output);
      User user=User.fromJson(jsonDecode(response.body));
      var checkRole=user.getRoles()!.contains("User");
      print(checkRole);
      if(checkRole==true){

        return true;
      }else {
        return false;
      }
    }else{
      print("Failed Login");
      return false;
    }
  }

}