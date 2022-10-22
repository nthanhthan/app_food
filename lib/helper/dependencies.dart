import 'package:app_food/controllers/popular_product_controller.dart';
import 'package:app_food/data/api/api_client.dart';
import 'package:app_food/data/repository/popular_product_repo.dart';
import 'package:get/get.dart';
Future<void> init()async {
  //api client
  Get.lazyPut(() =>ApiClient(appBaseUrl: "https://takefoodauthentication.azurewebsites.net/"));
  //repo
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  //controllers
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
}