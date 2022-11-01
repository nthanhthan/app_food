import 'package:app_food/auth/sign_in_page.dart';
import 'package:app_food/auth/sign_up_page.dart';
import 'package:app_food/models/foodStore_model.dart';
import 'package:app_food/pages/food/store.dart';
import 'package:app_food/pages/splash/splash_page.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../pages/food/foodDetail.dart';
import '../pages/home/home_page.dart';

class RouteHelper{
  static const String initial="/";
  static const String homepage="/home_page";
  static const String storeDetail="/store_detail";
  static const String foodDetail="/food_detail";
  static const String Splashpage="/splash_page";
  static String getInitial()=>'$initial';
  static String getHomePage()=>'$homepage';
  static String getSplashPage()=>'$Splashpage';
  static String getDetailFood(String foodId)=>'$foodDetail?foodID=&foodId';
  static String getStoreDetail(String storeId)=>'$storeDetail?storeId=$storeId';
  static List<GetPage> routes=[
    GetPage(name: initial, page: ()=>SignInPage()),
    GetPage(name: homepage, page:(){
      return HomePage();
  } , transition: Transition.fadeIn
    ),
    GetPage(name: Splashpage, page:()=>SplashSreeen()),
    GetPage(name: storeDetail, page:(){
      var storeId=Get.parameters['storeId'];
      return StorePage(storeId:storeId.toString());
  },
    transition: Transition.downToUp),
    GetPage(name: foodDetail, page: (){
      var foodID=Get.parameters['foodID'];
      return FoodDetail(foodID:foodID.toString());
    })
  ];
}