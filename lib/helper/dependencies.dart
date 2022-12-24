import 'package:app_food/controllers/cart_controller.dart';
import 'package:app_food/controllers/myOrdered_controller.dart';
import 'package:app_food/controllers/payment_controller.dart';
import 'package:app_food/controllers/user_controller.dart';
import 'package:app_food/data/api/api_client.dart';
import 'package:app_food/data/repository/cart_repo.dart';
import 'package:app_food/data/repository/myOrdered_repo.dart';
import 'package:app_food/data/repository/payment_repo.dart';
import 'package:app_food/data/repository/user_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/foodDetail_controller.dart';
import '../controllers/foodOfStore_controller.dart';
import '../controllers/recommended_storenear_controller.dart';
import '../data/repository/foodDetail_repo.dart';
import '../data/repository/foodOfStore_repo.dart';
import '../data/repository/recommended_storenear_repo.dart';
Future<void> init()async {
  final sharePreferences=await SharedPreferences.getInstance();
  //await sharePreferences.remove("token");
  //await sharePreferences.remove("Cart-list");
  Get.lazyPut((){return sharePreferences;},
      fenix: true);
  //api client
  Get.lazyPut(() =>ApiClient(appBaseUrl: "https://takefood-apigateway-mobile.azurewebsites.net/"));
  //repo
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));
  //controllers
  Get.lazyPut(() {
    return UserController(userRepo: Get.find());
  },
      fenix: true);
  Get.lazyPut(() => RecommendedStoreNearRepo(apiClient: Get.find()));
  //controllers
  Get.lazyPut((){ return RecommendedStoreNearController(recommendedStoreNearRepo: Get.find());},
      fenix: true);
  Get.lazyPut(() => FoodOfStoreRepo(apiClient: Get.find()));
  //controllers
  Get.lazyPut(() => FoodDetailRepo(apiClient: Get.find()));
  Get.lazyPut(() {
    return FoodOfStoreController(foodOfStoreRepo: Get.find());
  },
      fenix: true);
  //controllers
  Get.lazyPut(() {
    return FoodDetailController(foodDetailRepo: Get.find(),sharedPreferences: Get.find());
  },
  fenix: true);
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  //controllers
  Get.lazyPut(() {
    return CartController(cartRepo: Get.find());
  }, fenix: true);
  Get.lazyPut(() =>CartController(cartRepo: Get.find()));
  Get.lazyPut(() => PaymentRepo(apiClient: Get.find(),sharedPreferences: Get.find(),cart: Get.find()));
  Get.lazyPut(() {
    return PaymentController(paymentRepo: Get.find(),cartController: Get.find());
  },
      fenix: true);
  Get.lazyPut(() {
    return MyOrderController(myOrderedRepo: Get.find(),sharedPreferences: Get.find());
  },
      fenix: true);

  Get.lazyPut(() => MyOrderedRepo(apiClient: Get.find()));
}