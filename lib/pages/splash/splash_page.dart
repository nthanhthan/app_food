import 'dart:async';
import 'package:app_food/routes/route_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashSreeen extends StatefulWidget {
  const SplashSreeen({Key? key}) : super(key: key);
  @override
  State<SplashSreeen> createState() => _SplashSreeenState();
}

class _SplashSreeenState extends State<SplashSreeen> with TickerProviderStateMixin{
  late Animation<double> animation;
  late AnimationController controller;
   String? token;
  Future<void > _loadResource()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
     token= prefs.getString("token");
  }
  @override
 void  initState()  {
    super.initState();
     _loadResource();

    controller= AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2))..forward();
    animation=  CurvedAnimation(parent: controller, curve: Curves.linear);
    Timer(
        const Duration(seconds:5),
            ()=>Get.offNamed(token==null? RouteHelper.getInitial():RouteHelper.getHomePage())
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(scale: animation,
          child:Center(child:Image.asset("assets/images/logo1.png",width: ScreenUtil().setWidth(400),))),
         // Center(child:Image.asset("assets/images/logoText.jpg",width: ScreenUtil().setWidth(250),)),
        ],
      ),
    );
  }
}
