import 'package:app_food/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        Container(
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
        ),
        ListView.builder(
            padding: EdgeInsets.only(top:ScreenUtil().setHeight(5)),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 10,
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BigText(text: "Trân châu đen",size: ScreenUtil().setSp(10),),
                            BigText(text: "5.000đ",size: ScreenUtil().setSp(10),),
                          ],


                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: AppColors.borderBottom,
                              width: 2.0
                            )
                          )
                        ),

                      ),
                    )
                  ],
                ),
              );
            }),
      ],
    );
  }
}
