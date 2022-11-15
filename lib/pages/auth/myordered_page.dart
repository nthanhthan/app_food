import 'package:app_food/routes/route_helper.dart';
import 'package:app_food/widgets/app_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../controllers/myOrdered_controller.dart';
import '../../utils/colors.dart';
import '../../widgets/small_text.dart';

class MyOrderPage extends StatefulWidget {
  const MyOrderPage({Key? key}) : super(key: key);

  @override
  State<MyOrderPage> createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor:AppColors.mainColor,
          title: const Center(child: Text("Đơn hàng của tôi")),
        ),
        body: SingleChildScrollView(
            child: GetBuilder<MyOrderController>(builder: (myOrdered)  {
              return   myOrdered.listMyOrdered.isEmpty?Container(
                child: Center(child: SmallText(text: "CHƯA CÓ ĐƠN HÀNG NÀO",),),
              ):ListView.builder( padding:
              EdgeInsets.only(top: ScreenUtil().setHeight(5)),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:myOrdered.listMyOrdered.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        bool check=await myOrdered.getDetailOrdered(myOrdered.listMyOrdered[index].orderId);
                        if(check){
                        Get.toNamed(RouteHelper.detailOrdered);
                        }else{
                          print("false");
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            top: ScreenUtil().setHeight(4),
                            left: ScreenUtil().setWidth(20),
                            right: ScreenUtil().setWidth(10)),
                        height: ScreenUtil().setHeight(120),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: AppColors.borderBottom, width: 5.0))),
                        width: double.maxFinite,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                AppIcon(icon: Icons.check_circle_rounded,size: ScreenUtil().setHeight(25),backgroundColor: Colors.grey,iconColor: AppColors.mainBlackColor,),
                                SmallText(text: "Đã giao hàng",fontWeight: "bold",size: ScreenUtil().setSp(8),),
                              ],
                            ),
                            
                            SmallText(text: myOrdered.listMyOrdered[index].storeName!, color: AppColors.mainBlackColor,size: ScreenUtil().setSp(12),),
                            SmallText(text:"${myOrdered.listMyOrdered[index].foodQuantity}món",fontWeight: "bold",size: ScreenUtil().setSp(8),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SmallText(text: myOrdered.listMyOrdered[index].total.toString().toVND(unit: "đ"), color: AppColors.mainBlackColor,fontWeight: "bold",size: ScreenUtil().setSp(10),),
                                SmallText(text: "Xem chi tiết", color: AppColors.mainColor,fontWeight: "bold",size: ScreenUtil().setSp(8),)
                              ],
                            )

                          ],
                        ),
                      ),
                    );
                  });
            })

        )
    );
  }
}
