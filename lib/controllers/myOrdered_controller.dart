import 'dart:convert';
import 'package:app_food/base/show_custom_snackbar.dart';
import 'package:app_food/data/repository/myOrdered_repo.dart';
import 'package:app_food/models/detailOrdered_model.dart';
import 'package:app_food/models/myOrdered_model.dart';
import 'package:app_food/models/review_model.dart';
import 'package:app_food/models/user_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MyOrderController extends GetxController {
  final MyOrderedRepo myOrderedRepo;
  List<MyOrdered> listMyOrdered = [];
  List<MyOrdered> listMyOrderedOrdered = [];
  List<MyOrdered> listMyOrderedProcessing = [];
  List<MyOrdered> listMyOrderedDelivering = [];
  List<MyOrdered> listMyOrderedDelivered = [];
  List<MyOrdered> listOrdered=[];
  final SharedPreferences sharedPreferences;
  DetailOrdered? detailOrdered;
  List<Food> listFood = [];
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  List<Toppings> listTopping = [];
  String dateOrdered = "";
  String? nameUser = "";
  Review? review;
  String dateOrderedOfList = "";
  MyOrderController(
      {required this.myOrderedRepo, required this.sharedPreferences});
  Future<void> getListMyOrdered() async {
    listMyOrdered = [];
    listMyOrderedOrdered = [];
    listMyOrderedProcessing = [];
     listMyOrderedDelivering = [];
     listMyOrderedDelivered = [];
    for (int i = 1;; i++) {
      listMyOrdered=[];
      http.Response response = await myOrderedRepo.getMyOrdered(i);
      if(response.statusCode==200){
      List<dynamic>  decodedList = json.decode(response.body);
      List<MyOrdered> posts = List<MyOrdered>.from(decodedList.map((model)=> MyOrdered.fromJson(model)));
      print(posts.length);
      listMyOrdered.addAll(posts);
      getListMyOrderedByType();
      if (posts.isEmpty) {
        break;
      }
      }
      // update();
    }
  }

  getListMyOrderedByType() {
    _isLoaded=false;
    if (listMyOrdered.isNotEmpty) {
      for (var element in listMyOrdered) {
        if (element.state == "Ordered") {
          listMyOrderedOrdered.add(element);
        }
        if (element.state == "Processing") {
          listMyOrderedProcessing.add(element);
        }
        if (element.state == "Delivering") {
          listMyOrderedDelivering.add(element);
        }
        if (element.state == "Delivered") {
          listMyOrderedDelivered.add(element);
        }
      }
    }
    _isLoaded=true;
    update();
  }

   getReviewByOrderId(orderedId) async {
    review = await myOrderedRepo.getReviewByOrderId(orderedId);
    update();

  }

  Future<bool> getDetailOrdered(orderedID) async {
    _isLoaded = false;
    http.Response response = await myOrderedRepo.getDetailOrdered(orderedID);
    if (response.statusCode == 200) {
      detailOrdered = DetailOrdered.fromJson(jsonDecode(response.body));
      Get.find<MyOrderController>().getReviewByOrderId(orderedID);
      if (sharedPreferences.containsKey("user")) {
        String? getUser = sharedPreferences.getString("user");
        User user = User.fromJson(jsonDecode(getUser!));
        nameUser = user.name;
      } else {
        nameUser = "No Name";
      }
      DateTime parseDate =  DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
        .parse(detailOrdered!.orderDate.toString(), true);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('dd/MM/yyyy hh:mm a');
    var outputDate = outputFormat.format(inputDate);
    dateOrdered = outputDate.toString();
    listFood = [];
    listFood.addAll(detailOrdered!.listFoods!);
    listTopping = [];
    for (var element in listFood) {
      listTopping.addAll(element.toppings!);
    }
    _isLoaded = true;
    update();
    return true;
    }
    showCustomSnackBar("Vui lòng thử lại",);
    return false;
  }

  Future<bool> reviewOrder(data) async {
    bool check = await myOrderedRepo.revieworder(data);
    return check;
  }
}
