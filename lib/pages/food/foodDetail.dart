import 'package:app_food/controllers/cart_controller.dart';
import 'package:app_food/pages/food/topping.dart';
import 'package:app_food/routes/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controllers/foodDetail_controller.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/expandable_text_widget.dart';

class FoodDetail extends StatelessWidget {
  String foodID;
  FoodDetail({Key? key, required this.foodID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var food = Get.find<FoodDetailController>().getFoodDetailById(foodID);

    //Get.find<FoodDetailController>().initFood(food.foodsDetail, Get.find<CartController>());

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<FoodDetailController>(builder: (foodDetail) {
          return Stack(
            children: [
              //background image
              Positioned(
                  left: 0,
                  right: 0,
                  child: Container(
                    width: double.maxFinite,
                    height: ScreenUtil().setHeight(240),
                    decoration:  BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(foodDetail.foodsDetail.urlImage!))),
                  )),
              //icon widgets
              Positioned(
                  top: ScreenUtil().setHeight(20),
                  left: ScreenUtil().setWidth(20),
                  right: ScreenUtil().setWidth(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHelper.storeDetail);
                          },
                          child: AppIcon(
                            icon: Icons.arrow_back,
                            size: ScreenUtil().setHeight(30),
                          )),
                      GetBuilder<FoodDetailController>(builder: (controller) {
                        return Stack(
                          children: [
                            AppIcon(
                                icon: Icons.shopping_cart_outlined,
                                size: ScreenUtil().setHeight(30)),
                            Get.find<FoodDetailController>().totalItems >= 1
                                ? Positioned(
                                    right: 3,
                                    top: 3,
                                    child: BigText(
                                      text: Get.find<FoodDetailController>()
                                          .totalItems
                                          .toString(),
                                      size: ScreenUtil().setSp(5),
                                      color: Colors.white,
                                    ),
                                  )
                                : Container()
                          ],
                        );
                      })
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
                              topRight:
                                  Radius.circular(ScreenUtil().radius(20)),
                              topLeft:
                                  Radius.circular(ScreenUtil().radius(20))),
                          color: Colors.white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BigText(
                                  text: foodDetail.foodsDetail.name!,
                                  size: ScreenUtil().setSp(10),
                                ),
                                BigText(
                                  text: foodDetail.foodsDetail.price.toString()!,
                                  size: ScreenUtil().setSp(10),
                                ),
                              ],
                            ),
                          ),
                          //AppColumn(text: "Bun mam Da Nang"),
                          SizedBox(
                            height: ScreenUtil().setHeight(10),
                          ),
                           Expanded(
                              child: SingleChildScrollView(
                            child: ExpandableTextWidget(
                                text:foodDetail.foodsDetail.description!),
                          )),
                          const Expanded(
                              child: SingleChildScrollView(
                            child: Topping(),
                          )),
                        ],
                      )))
            ],
          );
        }),
        bottomNavigationBar: GetBuilder<FoodDetailController>(
          builder: (foodDetail) {
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
                        GestureDetector(
                          onTap: () {
                            foodDetail.setQuantity(false);
                          },
                          child: Icon(
                            Icons.remove,
                            color: AppColors.signColor,
                          ),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(10),
                        ),
                        BigText(text: foodDetail.inCartItems.toString()),
                        SizedBox(
                          width: ScreenUtil().setWidth(10),
                        ),
                        GestureDetector(
                          onTap: () {
                            foodDetail.setQuantity(true);
                          },
                          child: Icon(
                            Icons.add,
                            color: AppColors.signColor,
                          ),
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
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        color: AppColors.mainColor),
                    child: GestureDetector(
                      onTap: () {
                        foodDetail.addItem(foodDetail.foodsDetail);
                      },
                      child: BigText(
                        text: "Thêm  10.000đ",
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }
}
