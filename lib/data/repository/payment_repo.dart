import 'dart:convert';
import 'package:app_food/base/show_custom_snackbar.dart';
import 'package:app_food/controllers/cart_controller.dart';
import 'package:app_food/models/cart_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/order_model.dart';
import '../../models/user_model.dart';
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
    var fullApiUrl ="${apiClient.appBaseUrl}GetVoucher?storeId=$id";
    return await apiClient.Get(fullApiUrl);
  }
   getUser() async {
     String? getuser;
     var user;
     if(sharedPreferences.containsKey("user")){
       getuser=sharedPreferences.getString("user");
       user=User.fromJson(jsonDecode(getuser!));
       userID=user.id;
       phoneNumberUser=user.phone;
     }
    var fullApiUrl ="${apiClient.appBaseUrl}GetAddress";
     if(sharedPreferences.getString("address") != null){
       addressUser=sharedPreferences.getString("address").toString();
     }else{
       http.Response response=await apiClient.Get(fullApiUrl);
       if(response.statusCode==200){
         addressUser=jsonDecode(response.body).toString()=="[]"? "Chưa có địa chỉ":jsonDecode(response.body).toString();
         sharedPreferences.setString("address", addressUser);
       }else{
         print(response.statusCode);
       }
     }
  }
  Future<Map<bool,Object?>> confirmOrder(voucherID,String note, String addressUser, String phoneNumberOrder, String dropdownValue) async {
    var fullApiUrl ="${apiClient.appBaseUrl}CreateOrder";
  List<CartModel> carts=cart.getItems;
  if(carts.length==0){
    showCustomSnackBar("Vui lòng chọn món",title: "Không hợp lệ");
    Map<bool,String?> result={
      false:""
    };
    return result;
  }
  print(phoneNumberOrder);
  print(voucherID);
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
      phoneNumber: phoneNumberOrder ?? phoneNumberUser,
      voucherId: voucherID,
      paymentMethod: dropdownValue,
      deliveryMode: "nhan tai cua hang",
      storeId: carts[0].storeID.toString(),
      foodOrder:foodOrder
  );
  print(jsonEncode(order));
  http.Response response=await apiClient.postOrder(fullApiUrl,order!);
  if(response.statusCode==200){
    if(response.body.isNotEmpty){
    String uri=response.body;
    uri=uri.replaceAll('"', "");
    Map<bool,Object?> result={
      true:uri
    };
    removeCart();
    await sharedPreferences.remove("Cart-list");
    Get.find<CartController>().getCartData();
    return result;

    }
    print("Done");
    removeCart();
    await sharedPreferences.remove("Cart-list");
    Get.find<CartController>().getCartData();
    Map<bool,String?> result={
      true:""
    };
    return result;

  }else{
    print(response.statusCode);
    print("Failed");
    Map<bool,String?> result={
      false:""
    };
    return result;
  }
  }
  void removeCart(){
    sharedPreferences.remove("Cart-list");
  }
}