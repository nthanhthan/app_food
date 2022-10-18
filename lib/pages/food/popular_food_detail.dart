import 'package:app_food/pages/food/topping.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/expandable_text_widget.dart';

class PopularFoodDetail extends StatelessWidget {
  const PopularFoodDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //background image
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: ScreenUtil().setHeight(240),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/img.png"))),
              )),
          //icon widgets
          Positioned(
              top: ScreenUtil().setHeight(20),
              left: ScreenUtil().setWidth(20),
              right: ScreenUtil().setWidth(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(icon: Icons.arrow_back_ios,size: ScreenUtil().setHeight(30),),
                  AppIcon(icon: Icons.shopping_cart_outlined,size: ScreenUtil().setHeight(30))
                ],
              )),
          //introduction of food
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: ScreenUtil().setHeight(220),
              child: Container(
                  padding: EdgeInsets.only(
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      top: Dimensions.height20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(ScreenUtil().radius(20)),
                          topLeft: Radius.circular(ScreenUtil().radius(20))),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BigText(text: "Bún mắm Đà Nẵng",size: ScreenUtil().setSp(15),),
                            BigText(text: "25.000",size:  ScreenUtil().setSp(15),),
                          ],

                        ),
                      ),
                      //AppColumn(text: "Bun mam Da Nang"),
                      SizedBox(
                        height: ScreenUtil().setHeight(10),
                      ),
                     Expanded(child: SingleChildScrollView(
                        child: ExpandableTextWidget(text: "Bún mắm là một trong số các món ăn đặc sản của "
                            "miền tây Nam bộ Việt Nam. Bún mắm có nguồn gốc từ Campuchia, được nấu từ mắm bù hốc. "
                            "Khi sang đến Việt Nam thường được nấu bằng mắm cá linh hay cá sặc, "
                            "đây là các loại cá có nhiều tại miền Tây, đặc biệt là các tỉnh Trà Vinh và Sóc Trăng."

                    ),
                      )
                     ),
                      Expanded(
                          child: SingleChildScrollView(
                            child: Topping(),
                          )),
                    ],

                  )))
      
        ],
      ),

      bottomNavigationBar: Container(
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
                  borderRadius: BorderRadius.circular(ScreenUtil().radius(20)),
                  color: Colors.white),
              child: Row(
                children: [
                  Icon(
                    Icons.remove,
                    color: AppColors.signColor,
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(10),
                  ),
                  BigText(text: "0"),
                  SizedBox(
                    width: ScreenUtil().setWidth(10),
                  ),
                  Icon(
                    Icons.add,
                    color: AppColors.signColor,
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(7),
                  bottom: ScreenUtil().setHeight(10),
                  left: ScreenUtil().setWidth(10),
                  right: ScreenUtil().setWidth(10)),
              child: BigText(
                text: "Thêm  10.000đ",
                color: Colors.white,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: AppColors.mainColor),
            )
          ],
        ),
      ),
    );
  }
}
