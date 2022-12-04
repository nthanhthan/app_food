import 'package:app_food/controllers/cart_controller.dart';
import 'package:app_food/routes/route_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signalr_netcore/http_connection_options.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';
import 'base/show_custom_snackbar.dart';
import 'controllers/recommended_storenear_controller.dart';
import 'controllers/user_controller.dart';
import 'helper/dependencies.dart' as dep;
 //String? token;
Future<void> main() async{
  await ScreenUtil.ensureScreenSize();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dep.init();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token= prefs.getString("token");
  if(token!=null){
    await Get.find<UserController>().getUser();
    String url="https://takefooduserorder.azurewebsites.net/notifysocket";
    HubConnection hubConnection;
    hubConnection = HubConnectionBuilder().withUrl(url,options: HttpConnectionOptions(accessTokenFactory: () =>Future.value(token),requestTimeout: 15000))
        .build();
    await hubConnection.start();
    print(hubConnection.state);
    hubConnection.on("sendToUser", (value) {showCustomSnackBar(title: value![0].toString(),value![1].toString(),type: false);
    });
  }
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
    Get.find<CartController>().getCartData();
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
