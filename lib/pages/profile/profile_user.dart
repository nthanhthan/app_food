import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../auth/sign_in_page.dart';
import '../../controllers/popular_product_controller.dart';
import '../../utils/colors.dart';
import '../../widgets/big_text.dart';

class ProfileUser extends StatelessWidget {
  const ProfileUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
       body:Column(
         children:[
          SizedBox(height: ScreenUtil().setHeight(350),),
           Container(
             width: ScreenUtil().setWidth(250),
             height: ScreenUtil().setHeight(70),
             decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(ScreenUtil().radius(30)),
                 color: AppColors.mainColor
             ),
             child: Center(
                 child:GestureDetector(
                   onTap: ()  {
                     if(Get.find<PopularProductController>().LogOut()){
                       Get.to(()=>SignInPage());
                     }
                   },
                   child: BigText(
                     text: "ĐĂNG Xuất",
                     size:  ScreenUtil().setSp(15),
                     color: Colors.white,
                   ),
                 )
             ),
           ),
         ]
       ),
    );
  }
}
