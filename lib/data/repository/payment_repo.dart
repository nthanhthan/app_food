import 'dart:convert';

import 'package:app_food/controllers/cart_controller.dart';
import 'package:app_food/models/cart_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/order_model.dart';
import '../api/api_client.dart';
import 'package:http/http.dart' as http;

class PaymentRepo extends GetxService{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  final CartController cart;
  String userID="";
  String addressUser="Chưa có địa chỉ";
  String phoneNumberUser="";
  Order? order;
  PaymentRepo({required this.apiClient,required this.sharedPreferences,required this.cart});

  Future<http.Response> getVoucher(id) async {
    var fullApiUrl ="https://takefoodvoucherservice.azurewebsites.net/GetVoucher?storeId=$id";
    return await apiClient.getFood(fullApiUrl);
  }
   getUser() async {
     userID=sharedPreferences.getString("UserId")!;
     phoneNumberUser=sharedPreferences.getString("phoneUser")!;
    var fullApiUrl ="https://takefoodauthentication.azurewebsites.net/GetAddress";
     if(sharedPreferences.getString("address") != null){
       addressUser=sharedPreferences.getString("address").toString();
     }else{
       http.Response response=await apiClient.getFood(fullApiUrl);
       if(response.statusCode==200){
         addressUser=jsonDecode(response.body).toString()=="[]"? "Chưa có địa chỉ":jsonDecode(response.body).toString();
         sharedPreferences.setString("address", addressUser);
       }else{
         print(response.statusCode);
       }
     }

  }
  Future<bool> confirmOrder(voucherID,note) async {
    var fullApiUrl ="https://takefoodorderuser.azurewebsites.net/CreateOrder";
  List<CartModel> carts=cart.getItems;
  List<FoodOrder> foodOrder=[];
  List<ToppingOrder> toppingOrder=[];
  carts.forEach((element) {
    element.listFoodTopping.forEach((value) {
      toppingOrder.add(ToppingOrder(
        toppingId: value.iD,
        quantity: 1
      ));
    });
    foodOrder.add(FoodOrder(
      foodId: element.foodId,
      quantity: element.quantity,
      toppingOrder: toppingOrder
    ));
  });
  order=Order(
      address: addressUser,
      addressId: "",
      note: note,
      phoneNumber: phoneNumberUser,
      voucherId: voucherID,
      paymentMethod: "Tien mat",
      deliveryMode: "nhan tai cua hang",
      storeId: carts[0].storeID.toString(),
      foodOrder:foodOrder
  );
  print(jsonEncode(order));
  http.Response response=await apiClient.postOrder(fullApiUrl,order!);
  if(response.statusCode==200){
    print("Done");
    await sharedPreferences.remove("Cart-list");
    Get.find<CartController>().getCartData();
    return true;
  }else{
    print("Failed");
    return false;
  }
  }
}