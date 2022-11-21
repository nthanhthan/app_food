import 'package:app_food/routes/route_helper.dart';
import 'package:app_food/widgets/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
              return   myOrdered.isLoaded? ListView.builder( padding:
              EdgeInsets.only(top: ScreenUtil().setHeight(5)),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:myOrdered.listMyOrdered.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: ()  {
                         myOrdered.getDetailOrdered(myOrdered.listMyOrdered[index].orderId);
                        Get.toNamed(RouteHelper.detailOrdered);
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
                                    color: AppColors.borderBottom, width: 2.0)),
                        ),
                        width: double.maxFinite,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                AppIcon(icon: Icons.check,size: ScreenUtil().setHeight(20),backgroundColor: Colors.grey,iconColor: Colors.white,iconSize: ScreenUtil().setHeight(15),),
                                SizedBox(width: ScreenUtil().setWidth(8),),
                                SmallText(text: "Đã giao hàng",color: AppColors.mainBlackColor,size: ScreenUtil().setSp(8),),
                              ],
                            ),
                            
                            SmallText(text: myOrdered.listMyOrdered[index].storeName!, color: AppColors.mainBlackColor,size: ScreenUtil().setSp(12),maxLines: 1,),
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
                  }):Center(
                child: CircularProgressIndicator(
                  color: AppColors.mainColor,
                ),
              );
            })

        )
    );
  }
}
