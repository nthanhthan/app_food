import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiClient extends GetConnect implements GetxService{
  late String _token;
   setToken(token){
     this._token=token;
  }
  String getToken(){
     return this._token;
  }
  final String  appBaseUrl;
  late Map<String, String> _mainHeaders={};
  Map<String, String> cookies = {};
  //Get AccessToken
  void _setCookie(String rawCookie) {
    if (rawCookie.isNotEmpty) {
      var keyValue = rawCookie.split('=');
      if (keyValue.length > 2) {
        var key = keyValue[4].trim();
        var value = key.split(';');
        setToken(value[0].trim());
      }
    }
  }
  void updateCookie(http.Response response) {
    String? rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      _mainHeaders['cookie'] =
      (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }
  void GetToken(http.Response response) {
    String? rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf('AccessToken=');
      _mainHeaders['cookie'] =
      (index == -1) ? rawCookie : rawCookie.substring(index, index);
    }
  }
  ApiClient({required this.appBaseUrl}) {
    baseUrl = appBaseUrl;
    timeout = Duration(seconds: 30);
    var token=getToken();
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
       'Authorization': "Bearer $token",
    };
  }
    Future<Response>  getData(String uri) async {
      try{
        Response response=await get(uri);
        return response;
      }catch(e){
        return Response(statusCode: 1,statusText: e.toString());
      }
    }
    Future<http.Response> SignUp(data,apiUrl) async{
    print("3");
    print(apiUrl);

      http.Response response= await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode(data),
        headers: _mainHeaders,
      );
      //response=handleResponse(response);
      print(response.statusCode);
      print("thanhcobng");
      return response;

    }
  Future<http.Response> SignIn(data,apiUrl) async{
    print(apiUrl);
    http.Response response= await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode(data),
      headers: _mainHeaders,
    );
     var allcookie=response.headers['set-cookie'];
     _setCookie(allcookie!);
    return response;
  }
  _setHeaders()=>{
    'Content-type': 'application/json',
    'Accept':'application/json'
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