import 'package:app_food/auth/sign_in_page.dart';
import 'package:app_food/pages/cart/cart_page.dart';
import 'package:app_food/pages/cart/payment_page.dart';
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
  static const String cartPage="/cart_page";
  static const String paymentPage="/payment_page";
  static String getInitial()=>'$initial';
  static String getHomePage()=>'$homepage';
  static String getSplashPage()=>'$Splashpage';
  static String getDetailFood(String storeID)=>'$foodDetail?storeID=$storeID';
  static String getStoreDetail(String storeId)=>'$storeDetail?storeId=$storeId';
  static String getCartPage(String FoodID)=>'$cartPage';
  static String getPaymentPage()=>'$paymentPage';
  static List<GetPage> routes=[
    GetPage(name: initial, page: ()=>SignInPage()),
    GetPage(name: homepage, page:(){
      return HomePage();
  } , transition: Transition.rightToLeftWithFade
    ),
    GetPage(name: Splashpage, page:()=>SplashSreeen()),
    GetPage(name: storeDetail, page:(){
      var storeId=Get.parameters['storeId'];
      return StorePage(storeId:storeId.toString());
  },
    transition: Transition.rightToLeftWithFade),
    GetPage(name: foodDetail, page: (){
      var storeID=Get.parameters['storeID'];
      return FoodDetail(storeID:storeID.toString());
    },transition: Transition.rightToLeftWithFade,
    ),
    GetPage(name: cartPage, page: (){
      return CartPage();
    },transition: Transition.rightToLeftWithFade),
    GetPage(name: paymentPage, page: (){
      return PaymentPage();
    },transition: Transition.rightToLeftWithFade),
  ];
}