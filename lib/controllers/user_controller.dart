import 'dart:convert';

import 'package:app_food/data/repository/user_repo.dart';
import 'package:app_food/models/user_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController{
  final UserRepo popularProductRepo;
  UserController({required this.popularProductRepo});

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
  Future<bool> LogOut(){
    return popularProductRepo.LogOut();
  }
  Future<bool> SignIn(data,url) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    http.Response response=(await popularProductRepo.SignIn(data, url));
    String? allSetCookie=response.headers['set-cookie'];
    print(allSetCookie);

    print(response.statusCode);
    if(response.statusCode==200){
      Map<String,dynamic> output=json.decode(response.body);
      User user=User.fromJson(jsonDecode(response.body));
      prefs.setString("token",user.accessToken!);
      prefs.setString("refreshToken",user.refreshToken!);
      var checkRole=user.getRoles!.contains("User");
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