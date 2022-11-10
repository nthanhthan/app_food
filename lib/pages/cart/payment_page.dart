import 'package:app_food/utils/colors.dart';
import 'package:app_food/widgets/app_icon.dart';
import 'package:app_food/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../controllers/cart_controller.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/big_text.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    var note=TextEditingController();
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: ,
        actions: <Widget>[
        AppIcon(
        iconColor: Colors.black54,
        icon: Icons.arrow_back,
        size: ScreenUtil().setHeight(30),)
        ],
        title: const Center(child: Text("Thanh toán")),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(4),
                  left: ScreenUtil().setWidth(20),
                  right: ScreenUtil().setWidth(10)),
              height: ScreenUtil().setHeight(130),
              width: double.maxFinite,
              //color: AppColors.paraColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SmallText(text: "Địa chỉ", color: const Color(0xFFFF8357),),
                      SmallText(text: "Thay đổi", color:AppColors.mainColor ,)
                    ],
                  ),
                  SizedBox(height: ScreenUtil().setWidth(3),),
                  SmallText(text: "155 đường Nguyễn Tất Thành, Hòa Minh, Liên Chiểu, TP Đà Nẵng", maxLines: 2,color: AppColors.mainBlackColor),
                  SizedBox(height: ScreenUtil().setWidth(3),),
                  SmallText(text: "SĐT", color: Color(0xFFFF8357),),
                  SmallText(text: "0901948483", color: AppColors.mainBlackColor,),
                ],
              ),
            ),
            SizedBox(height: ScreenUtil().setWidth(4),),
            Container(
             // color: AppColors.paraColor,
              padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(4),
                  left: ScreenUtil().setWidth(20),
                  right: ScreenUtil().setWidth(10)),
              height: ScreenUtil().setHeight(200),
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SmallText(text: "Đơn hàng của bạn", color: Color(0xFFFF8357),), 
                  Expanded(
                      child: SingleChildScrollView(
                        child: ListView.builder(  
                            padding: EdgeInsets.only(top: ScreenUtil().setHeight(5)),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return Container(
                                height: ScreenUtil().setHeight(50),
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: AppColors.borderBottom,
                                            width: 2.0
                                        )
                                    )
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SmallText(text: "1x",color: Colors.black,),
                                        SizedBox(width: ScreenUtil().setWidth(10),),
                                        SmallText(text: "Trà sữa truyền thống",color: Colors.black,),
                                      ],
                                    ),
                                    SmallText(text: "30.000đ",color: Colors.black,)
                                  ],
                                ),
                              );
                            }),
                      )),
                ],
              ),
            ),
            SizedBox(height: ScreenUtil().setWidth(5),),
            SizedBox(
              child: TextField(
                controller: note,
                obscureText: false,
                keyboardType: TextInputType.text,
                   decoration: InputDecoration(
                    hintText: "Lời nhắn cho cửa hàng",
                    hintStyle: TextStyle(color: Color(0xFFFF8357),fontSize: ScreenUtil().setSp(7)),
                    prefixIcon: const Icon(Icons.assessment_rounded,color: Color(0xFFFF8357),),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 0.5,
                          color: AppColors.paraColor,
                        )
                    ),
                    enabledBorder:  const OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1.0,
                          color: Colors.black,
                        )
                    ),
                ),
                style: TextStyle(fontSize: ScreenUtil().setSp(5)),
              ),
            ),
           Container(
             padding: EdgeInsets.only(
                 top: ScreenUtil().setHeight(4),
                 left: ScreenUtil().setWidth(20),
                 right: ScreenUtil().setWidth(10)),
             width: double.maxFinite,
             decoration: BoxDecoration(
                 border: Border(
                     bottom: BorderSide(
                         color: AppColors.borderBottom,
                         width: 2.0
                     )
                 )
             ),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     SmallText(text: "Tạm tính:",color:Colors.black ,),
                     SmallText(text: "30.000đ",color:Colors.black),
                   ],
                 ),
                 SizedBox(height: ScreenUtil().setWidth(5),),
                 SmallText(text: "Phiếu giảm giá:",color:Colors.black),
                 // Expanded(
                 //     child: Column(
                 //       children: [
                 //             ListView.builder(
                 //              scrollDirection: Axis.horizontal,
                 //             //padding: EdgeInsets.only(top: ScreenUtil().setHeight(5)),
                 //          // physics: const NeverScrollableScrollPhysics(),
                 //             shrinkWrap: true,
                 //             itemCount: 10,
                 //             itemBuilder: (context, index) {
                 //               return Container(
                 //                color: Colors.red,
                 //               );
                 //             }),
                 //           ],
                 //     )),
               ],
             ),
           )
          ],
        ),
      ),
        bottomNavigationBar: GetBuilder<CartController>(
          builder: (cart) {
            return Container(
              height: ScreenUtil().setHeight(80),
              padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(10),
                  bottom: ScreenUtil().setHeight(6),
                  left: ScreenUtil().setWidth(20),
                  right: ScreenUtil().setWidth(10)),
              decoration: BoxDecoration(
                  color: AppColors.buttonBackgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(ScreenUtil().radius(20)),
                      topRight: Radius.circular(ScreenUtil().radius(20)))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: ScreenUtil().setHeight(7),
                        bottom: ScreenUtil().setHeight(10),
                        left: ScreenUtil().setWidth(10),
                        right: ScreenUtil().setWidth(10)),
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(ScreenUtil().radius(20)),
                        color: Colors.white),
                    child: Row(
                      children: [

                        SizedBox(
                          width: ScreenUtil().setWidth(10),
                        ),
                        BigText(text:cart.totalAmount.toString().toVND(unit: "đ"),color: Colors.redAccent,),
                        SizedBox(
                          width: ScreenUtil().setWidth(10),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: ScreenUtil().setHeight(7),
                        bottom: ScreenUtil().setHeight(10),
                        left: ScreenUtil().setWidth(10),
                        right: ScreenUtil().setWidth(10)),
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(ScreenUtil().radius(10)),
                        color: AppColors.mainColor),
                    child: GestureDetector(
                      onTap: () {
                        // foodDetail.addItem(foodDetail.foodsDetail);
                      },
                      child: BigText(
                        text: "Thanh toán",
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        )
    );
  }
}
