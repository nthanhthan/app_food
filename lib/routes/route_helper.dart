import 'package:get/get_navigation/src/routes/get_route.dart';

import '../pages/home/home_page.dart';

class RouteHelper{
  static const String initial="/";
  static String getInitial()=>'$initial';
  static List<GetPage> routes=[
    GetPage(name: initial, page: ()=>HomePage()),
  ];
}