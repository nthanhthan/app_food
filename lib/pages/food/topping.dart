import 'package:app_food/controllers/foodDetail_controller.dart';
import 'package:app_food/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';

class Topping extends StatefulWidget {
  const Topping({Key? key}) : super(key: key);

  @override
  State<Topping> createState() => _ToppingState();
}

class _ToppingState extends State<Topping> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
    GetBuilder<FoodDetailController>(builder: (topping){
      return  topping.toppingFood.isEmpty?Container():Container(
        //margin: EdgeInsets.only(left: Dimensions.height10),
        child: Row(
          children: [
            BigText(
              text: "Chọn topping",
              color: AppColors.mainBlackColor,
              size: ScreenUtil().setSp(12),
            ),
          ],
        ),
      );
    }),
        GetBuilder<FoodDetailController>(builder: (topping){
          return  topping.toppingFood.isEmpty?Container():ListView.builder(
              padding: EdgeInsets.only(top:ScreenUtil().setHeight(5)),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: topping.toppingFood.isEmpty?1:topping.toppingFood.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(
                      top: ScreenUtil().setHeight(5)),
                  child: Row(
                    children: [
                      Expanded(
                        child:Container(
                          margin: EdgeInsets.only(
                              left: ScreenUtil().setWidth(15), right: ScreenUtil().setWidth(15),bottom: ScreenUtil().setHeight(8)),
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
                              BigText(text: topping.toppingFood[index].name!,size: ScreenUtil().setSp(10),),
                              BigText(text: topping.toppingFood[index].price.toString()!,size: ScreenUtil().setSp(10),),
                            ],


                          ),

                        ),
                      )
                    ],
                  ),
                );
              });
        })

      ],
    );
  }
}
