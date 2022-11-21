import 'dart:convert';

import 'package:app_food/data/repository/myOrdered_repo.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/detailOrdered_model.dart';
import '../models/myOrdered_model.dart';
import 'package:http/http.dart' as http;
class MyOrderController extends GetxController{
  final MyOrderedRepo myOrderedRepo;
  List<MyOrdered> listMyOrdered=[];
  final SharedPreferences sharedPreferences;
  dynamic detailOrdered;
  List<Food> listFood=[];
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  List<Toppings> listTopping=[];
  String dateOrdered="";
  String? nameUser="";
  MyOrderController({required this.myOrderedRepo,required this.sharedPreferences});
  Future<void> getListMyOrdered() async {
    listMyOrdered = [];
    for(int i=1;;i++){
    List<MyOrdered>  ordered = await myOrderedRepo.getMyOrdered(i);
    listMyOrdered.addAll(ordered);
    _isLoaded=true;
    update();
      if(ordered.length<10){
       break;
     }
  }
  }
  Future<bool> getDetailOrdered(orderedID) async {
    _isLoaded=false;
    http.Response response=await myOrderedRepo.getDetailOrdered(orderedID);
    if(response.statusCode==200){
      nameUser=sharedPreferences.getString("nameUser");
      detailOrdered = null;
      print(response.body);
      detailOrdered = DetailOrdered.fromJson(jsonDecode(response.body));
      // DateTime now = DateTime.now();

      DateTime parseDate =
      new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(detailOrdered.orderDate,true);
      var inputDate = DateTime.parse(parseDate.toString());
      var outputFormat = DateFormat('dd/MM/yyyy hh:mm a');
      var outputDate = outputFormat.format(inputDate);
      dateOrdered=outputDate.toString();
      listFood=[];
      listFood.addAll(detailOrdered.listFoods!);
      listTopping=[];
      listFood.forEach((element) {
        listTopping.addAll(element.toppings!);
      });
      _isLoaded=true;
      update();
      return true;
    }
    return false;
  }

}