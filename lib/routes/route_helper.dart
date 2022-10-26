import 'package:app_food/auth/sign_in_page.dart';
import 'package:app_food/auth/sign_up_page.dart';
import 'package:app_food/pages/food/store.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../pages/home/home_page.dart';

class RouteHelper{
  static const String initial="/";
  static const String homepage="/home_page";
  static String getInitial()=>'$initial';
  static String getHomePage()=>'$homepage';
  static List<GetPage> routes=[
    GetPage(name: initial, page: ()=>SignInPage()),
    GetPage(name: homepage, page:()=> HomePage())
  ];
}