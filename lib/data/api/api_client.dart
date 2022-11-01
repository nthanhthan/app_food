import 'dart:convert';
import 'dart:ffi';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient extends GetConnect implements GetxService {
  final String  appBaseUrl;
//  late Map<String, String> _mainHeaders={};
  Map<String, String> cookies = {};
  //Get AccessToken
  // Future<void> _setToken() async{
  //   final SharedPreferences prefs=await _prefs;
  //   final String token=(prefs.getString("token"))!;
  //   setState((){
  //     _token=prefs.setString("token", token).then((bool success){
  //       return token;
  //     });
  //   });
  // }
  // @override
  // void initState(){
  //   super.initState();
  //   _token=_prefs.then((SharedPreferences prefs){
  //     return prefs.getString("token")??"";
  //   });
  // }
  String _setCookie(String rawCookie)  {
    if (rawCookie.isNotEmpty) {
      var keyValue = rawCookie.split('=');
      if (keyValue.length > 2) {
        var key = keyValue[4].trim();
        var value = key.split(';');
        return value[0].trim();
        //prefs!.setString("token", value[0].trim());
      }
    }
    return "";
  }
  // void updateCookie(http.Response response) {
  //   String? rawCookie = response.headers['set-cookie'];
  //   if (rawCookie != null) {
  //     int index = rawCookie.indexOf(';');
  //     _mainHeaders['cookie'] =
  //     (index == -1) ? rawCookie : rawCookie.substring(0, index);
  //   }
  // }
  // void GetToken(http.Response response) {
  //   String? rawCookie = response.headers['set-cookie'];
  //   if (rawCookie != null) {
  //     int index = rawCookie.indexOf('AccessToken=');
  //     _mainHeaders['cookie'] =
  //     (index == -1) ? rawCookie : rawCookie.substring(index, index);
  //   }
  // }
  ApiClient({required this.appBaseUrl}) {
      baseUrl = appBaseUrl;
      timeout = Duration(seconds: 30);
  }
    Future<http.Response>  getFood(String uri) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
        String token=prefs?.getString("token")??"";
        http.Response response=await http.get(
          Uri.parse(uri),
          headers: _mainHeaders(token)
        );
        return response;
    }
    Future<http.Response> SignUp(data,apiUrl) async{
      http.Response response= await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode(data),
        headers: _setHeaders(),
      );
      //response=handleResponse(response);
      print(response.statusCode);
      print("thanhcobng");
      return response;

    }
  Future<http.Response> SignIn(data,apiUrl) async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();

   // String token=prefs?.getString("token")??"";
    http.Response response= await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
     var allcookie=response.headers['set-cookie'];
     _prefs.setString("token", _setCookie(allcookie!)) ;
    // print(prefs?.getString("token"));
    return response;
  }
  Future<bool> LogOut() async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove("token");
    //print(prefs?.getString("token"));
    return true;
    }
    catch(e){
      return false;
    }
  }
  Future<http.Response> getStoreNear(data,apiUrl) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token=prefs.getString("token");
    print(data);
    http.Response response= await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode(data),
      headers: _mainHeaders(token),
    );
    return response;
  }
  _setHeaders()=>{
    'Content-type': 'application/json',
    'Accept':'application/json'
  };
  _mainHeaders (token)=> {
  'Content-type': 'application/json',
  'Accept':'application/json',
  'Authorization': 'Bearer $token',
  };

  Response handleResponse(Response response) {
    Response _response = response;
    if(_response.hasError && _response.body != null && _response.body is !String) {
      if(_response.body.toString().startsWith('{errors: [{code:')) {
        _response = Response(statusCode: _response.statusCode, body: _response.body, statusText: "Error");

      }else if(_response.body.toString().startsWith('{message')) {
        _response = Response(statusCode: _response.statusCode,
            body: _response.body,
            statusText: _response.body['message']);

      }
    }else if(_response.hasError && _response.body == null) {
      print("The status code is "+_response.statusCode.toString());
      _response = Response(statusCode: 0, statusText: 'Connection to API server failed due to internet connection');
    }
    return _response;
}
}