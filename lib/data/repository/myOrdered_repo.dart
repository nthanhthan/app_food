import 'dart:convert';

import 'package:app_food/data/api/api_client.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../models/detailOrdered_model.dart';
import '../../models/myOrdered_model.dart';
class MyOrderedRepo extends GetxService{
  final ApiClient apiClient;
  MyOrderedRepo({required this.apiClient});
  dynamic detailOrdered;
  List<Food>? listFood=[];
  List<Toppings> listTopping=[];
  Future<List<MyOrdered>> getMyOrdered(i) async {
    List<MyOrdered> listOrdered=[];
      var fullApiUrl ="https://takefooduserorder.azurewebsites.net/GetOrders?index=$i";
      http.Response response=await apiClient.Get(fullApiUrl);
      if(response.statusCode==200){
        List<dynamic>  decodedList = json.decode(response.body);
        List<MyOrdered> posts = List<MyOrdered>.from(decodedList.map((model)=> MyOrdered.fromJson(model)));
        listOrdered.addAll(posts);
      }else{
        print(response.statusCode);
        print("SAI");
      }
      return listOrdered;
    }
    Future<http.Response> getDetailOrdered(orderedId) async {
      var fullApiUrl ="https://takefooduserorder.azurewebsites.net/GetOrderdetail?orderId=$orderedId";
      http.Response response=await apiClient.Get(fullApiUrl);
      return response;
    }

  }

