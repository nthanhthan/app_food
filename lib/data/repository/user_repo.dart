import 'dart:convert';

import 'package:app_food/data/api/api_client.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user_model.dart';

class UserRepo extends GetxService{
  final ApiClient apiClient;
  var user;
  String address="";
  UserRepo({required this.apiClient});
   Future<http.Response> SignUp(data,apiUrl) async{
    var fullApiUrl=apiClient.appBaseUrl+apiUrl;
    return await apiClient.SignUp(data, fullApiUrl);
  }
  Future<http.Response> SignIn(data,apiUrl) async{
    var fullApiUrl=apiClient.appBaseUrl+apiUrl;
    return await apiClient.SignIn(data, fullApiUrl);
  }
  Future<bool> LogOut(){
    return apiClient.LogOut();
  }
  getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? getuser;
    if(prefs.containsKey("user")){
      getuser=prefs.getString("user");
      user=User.fromJson(jsonDecode(getuser!));
    }
    var fullApiUrl ="https://takefoodauthentication.azurewebsites.net/GetAddress";
    http.Response response=await apiClient.Get(fullApiUrl);
    if(response.statusCode==200){
      address=jsonDecode(response.body).toString()=="[]"? "Chưa có địa chỉ":jsonDecode(response.body).toString();
      prefs.setString("address", address);
    }else{
      print(response.statusCode);
    }
    return user;
  }
}