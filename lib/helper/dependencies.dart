
import 'package:app_food/controllers/cart_controller.dart';
import 'package:app_food/controllers/user_controller.dart';
import 'package:app_food/data/api/api_client.dart';
import 'package:app_food/data/repository/cart_repo.dart';
import 'package:app_food/data/repository/user_repo.dart';
import 'package:get/get.dart';
import '../controllers/foodDetail_controller.dart';
import '../controllers/foodOfStore_controller.dart';
import '../controllers/recommended_storenear_controller.dart';
import '../data/repository/foodDetail_repo.dart';
import '../data/repository/foodOfStore_repo.dart';
import '../data/repository/recommended_storenear_repo.dart';


Future<void> init()async {

  //api client
  Get.lazyPut(() =>ApiClient(appBaseUrl: "https://takefoodauthentication.azurewebsites.net/"));
  //repo
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));
  //controllers
  Get.lazyPut(() => UserController(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedStoreNearRepo(apiClient: Get.find()));
  //controllers
  Get.lazyPut(() => RecommendedStoreNearController(recommendedStoreNearRepo: Get.find()));
  Get.lazyPut(() => FoodOfStoreRepo(apiClient: Get.find()));
  //controllers
  Get.lazyPut(() => FoodOfStoreController(foodOfStoreRepo: Get.find()));
  Get.lazyPut(() => FoodDetailRepo(apiClient: Get.find()));
  //controllers
  Get.lazyPut(() => FoodDetailController(foodDetailRepo: Get.find()));
  Get.lazyPut(() => CartRepo());
  //controllers
  Get.lazyPut(() =>CartController(cartRepo: Get.find()));
}