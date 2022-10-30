
import 'package:app_food/controllers/popular_product_controller.dart';
import 'package:app_food/data/api/api_client.dart';
import 'package:app_food/data/repository/popular_product_repo.dart';
import 'package:get/get.dart';
import '../controllers/foodOfStore_controller.dart';
import '../controllers/recommended_storenear_controller.dart';
import '../data/repository/foodOfStore_repo.dart';
import '../data/repository/recommended_storenear_repo.dart';


Future<void> init()async {

  //api client
  Get.lazyPut(() =>ApiClient(appBaseUrl: "https://takefoodauthentication.azurewebsites.net/"));
  //repo
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  //controllers
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedStoreNearRepo(apiClient: Get.find()));
  //controllers
  Get.lazyPut(() => RecommendedStoreNearController(recommendedStoreNearRepo: Get.find()));
  Get.lazyPut(() => FoodOfStoreRepo(apiClient: Get.find()));
  //controllers
  Get.lazyPut(() => FoodOfStoreController(foodOfStoreRepo: Get.find()));
}