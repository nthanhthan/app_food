import 'dart:convert';

import 'package:app_food/base/show_custom_snackbar.dart';
import 'package:app_food/controllers/recommended_storenear_controller.dart';
import 'package:app_food/data/repository/user_repo.dart';
import 'package:app_food/models/user_model.dart';
import 'package:app_food/routes/route_helper.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'cart_controller.dart';

class UserController extends GetxController{
  final UserRepo userRepo;
  UserController({required this.userRepo});
   User? user;
  String address="";

  Future<bool> SignUp(data,url) async{
    http.Response response=(await userRepo.SignUp(data, url));
    print(data);
    print(response.statusCode);
    if(response.statusCode==200){
     showCustomSnackBar("Vui lòng xác thực email trong hòm thư của bạn",title: "Xác thực", type: false );
     Get.toNamed(RouteHelper.initial);
     return true;
    }else{
      showCustomSnackBar(response.body.toString(),title: "Đăng kí thất bại");
      return false;
    }
  }
  Future<bool> LogOut() async {
    return await userRepo.LogOut();
  }
    Future<void> getUser() async {
    address="";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user=await userRepo.getUser();
    if(prefs.containsKey("address")){
    address=prefs.getString("address")!;}
    else{
      address="nothing";
    }
    update();
  }
  Future<bool> editProfile(data, address)async {
    String? getuser;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool check=await userRepo.editProfile(data, address);
    if(check){
      if(prefs.containsKey("user")){
        getuser=prefs.getString("user");
        user=User.fromJson(jsonDecode(getuser!));
        user?.name=data['name'];
        user?.email=data['email'];
        user?.phone=data['phoneNumber'];
        String userStorage=jsonEncode(user);
        prefs.setString("user", userStorage);
        await getUser();
        update();
        return true;
      }
    }else{
      return false;
    }
    return false;
  }
  Future<bool> SignIn(data,url) async{
    var data1={
      "lat": 16.0752017445013,
      "lng": 108.15545900149125,
      "radiusIn": 0,
      "radiusOut": 1
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    http.Response response=(await userRepo.SignIn(data, url));
    if(response.statusCode==200){
      user=User.fromJson(jsonDecode(response.body));
      prefs.setString("token", user!.accessToken.toString());
      prefs.setString("refreshToken", user!.refreshToken.toString());
      String userStorage=jsonEncode(user);
      prefs.setString("user", userStorage);
      if(prefs.containsKey("user")){
        print("true");
      }
      Get.find<CartController>().getCartData();
      await Get.find<UserController>().getUser();
      var checkRole=user?.getRoles?.contains("User");

      if(checkRole==true){
        Get.find<RecommendedStoreNearController>().getRecommendedStoreNearList(data1);
        return true;
      }else {
        return false;
      }
    }else{
      showCustomSnackBar("Đăng nhập thất bại",title: "Đăng nhập");
      return false;
    }
  }

}