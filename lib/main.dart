import 'package:app_food/routes/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controllers/foodOfStore_controller.dart';
import 'controllers/recommended_storenear_controller.dart';
import 'helper/dependencies.dart' as dep;
 //String? token;
Future<void> main() async{
  await ScreenUtil.ensureScreenSize();
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  //SharedPreferences prefs = await SharedPreferences.getInstance();
  //token=prefs?.getString("token");
  //print(token);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data={
      "lat": 16.073877,
      "lng": 108.149892,
      "radiusIn": 0,
      "radiusOut": 1
    };
    Get.find<RecommendedStoreNearController>().getRecommendedStoreNearList(data);
   // Get.find<FoodOfStoreController>().getAllFoodOfStore("6358eb4c814c0de88aeb3d8a","16.073877","108.149892");
    return ScreenUtilInit(
      designSize: const Size(410, 730),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context , child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          // home: SplashSreeen(),
          initialRoute: RouteHelper.Splashpage,
          //initialRoute: token==null? RouteHelper.getInitial():RouteHelper.getHomePage(),
          getPages: RouteHelper.routes,
        );
      },
      // child: const HomePage(title: 'First Method'),
    );

  }
}
