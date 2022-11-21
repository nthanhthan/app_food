import 'package:app_food/controllers/myOrdered_controller.dart';
import 'package:app_food/widgets/big_text.dart';
import 'package:app_food/widgets/small_text.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../utils/colors.dart';
import '../../widgets/app_icon.dart';

class DetailOrderPage extends StatelessWidget {
  const DetailOrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          title: const Center(child: Text("Chi tiết đơn hàng")),
        ),
        body: GetBuilder<MyOrderController>(builder: (ordered) {
          return ordered.isLoaded? SingleChildScrollView(
              child: Column(
            children: [
              Container(
                  padding: EdgeInsets.only(
                      top: ScreenUtil().setHeight(4),
                      left: ScreenUtil().setWidth(20),
                      right: ScreenUtil().setWidth(10)),
                  height: ScreenUtil().setHeight(200),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: AppColors.borderBottom, width: 5.0))),
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: ScreenUtil().setHeight(200),
                        width: ScreenUtil().setWidth(140),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SmallText(text: "Mã đơn hàng:",size: ScreenUtil().setSp(8)),
                            SmallText(text: "Tên:",size: ScreenUtil().setSp(8)),
                            SmallText(text: "Số điện thoại:",size: ScreenUtil().setSp(8)),
                            SmallText(text: "Địa chỉ:",size: ScreenUtil().setSp(8)),
                            SmallText(text: "Thời gian đặt hàng:", size: ScreenUtil().setSp(8),),
                          ],
                        ),
                      ),
                      GetBuilder<MyOrderController>(builder: (detailOrder) {
                        return Container(
                          height: ScreenUtil().setHeight(200),
                          width: ScreenUtil().setWidth(230),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SmallText(
                                text: detailOrder.detailOrdered.orderId,
                                color: AppColors.mainBlackColor,
                                size: ScreenUtil().setSp(8.5),
                                maxLines: 1,
                              ),
                              SmallText(
                                text: detailOrder.nameUser!,
                                color: AppColors.mainBlackColor,
                                size: ScreenUtil().setSp(8.5),
                                maxLines: 1,
                              ),
                              SmallText(
                                text: detailOrder.detailOrdered.phoneNumber,
                                color: AppColors.mainBlackColor,
                                size: ScreenUtil().setSp(8.5),
                                maxLines: 1,
                              ),
                              SmallText(
                                text: detailOrder.detailOrdered.address,
                                color: AppColors.mainBlackColor,
                                size: ScreenUtil().setSp(8.5),
                                maxLines: 1,
                              ),
                              SmallText(
                                text: detailOrder.dateOrdered,
                                color: AppColors.mainBlackColor,
                                size: ScreenUtil().setSp(8.5),
                                maxLines: 2,
                              ),
                            ],
                          ),
                        );
                      })
                    ],
                  )),
              // SizedBox(height: ScreenUtil().setHeight(210),),
              Container(
                padding: EdgeInsets.only(
                    top: ScreenUtil().setHeight(4),
                    left: ScreenUtil().setWidth(20),
                    right: ScreenUtil().setWidth(10)),
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SmallText(
                      text: "Đơn hàng của bạn",
                      color: const Color(0xFFFF8357),
                      fontWeight: "bold",
                      size: ScreenUtil().setSp(8),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(10),
                    ),
                    BigText(text: ordered.detailOrdered.storeName!),
                    Row(
                      children: [
                        SmallText(
                          text: "Đã giao hàng",
                          size: ScreenUtil().setSp(8),
                          color: AppColors.mainBlackColor,
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(5),
                        ),
                        AppIcon(
                          icon: Icons.check,
                          size: ScreenUtil().setHeight(20),
                          iconSize: ScreenUtil().setHeight(15),
                          backgroundColor: AppColors.mainColor,
                          iconColor: Colors.white,
                        ),
                      ],
                    ),
                    ListView.builder(
                        padding:
                            EdgeInsets.only(top: ScreenUtil().setHeight(5)),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: ordered.listFood?.length,
                        itemBuilder: (context, index) {
                          return Container(
                            // height: ScreenUtil().setHeight(50),
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: AppColors.borderBottom,
                                        width: 1.0))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SmallText(
                                          text:
                                              "${ordered.listFood[index].quantity}x",
                                          color: Colors.black,
                                          fontWeight: "bold",
                                          size: ScreenUtil().setSp(8),
                                        ),
                                        SizedBox(
                                          width: ScreenUtil().setWidth(10),
                                        ),
                                        SmallText(
                                          text:
                                              ordered.listFood[index].foodName!,
                                          fontWeight: "bold",
                                          size: ScreenUtil().setSp(11),
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                    SmallText(
                                      text: ordered.listFood[index].total
                                          .toVND(unit: "đ"),
                                      fontWeight: "bold",
                                      color: Colors.black,
                                    )
                                  ],
                                ),
                                ordered.listFood[index].toppings!.isEmpty
                                    ? Container()
                                    : ListView.builder(
                                        padding: EdgeInsets.only(
                                            top: ScreenUtil().setHeight(5)),
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: ordered
                                            .listFood[index].toppings?.length,
                                        itemBuilder: (context, INDEX) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SmallText(
                                                    text:
                                                        "${ordered.listFood[index].toppings?[INDEX].quantity}x",
                                                    color: Colors.black,
                                                    size: ScreenUtil().setSp(6),
                                                  ),
                                                  SizedBox(
                                                    width: ScreenUtil()
                                                        .setWidth(10),
                                                  ),
                                                  SmallText(
                                                    text: ordered
                                                        .listFood[index]
                                                        .toppings![INDEX]
                                                        .toppingName
                                                        .toString(),
                                                    color: Colors.black,
                                                    size: ScreenUtil().setSp(8),
                                                  ),
                                                ],
                                              ),
                                              SmallText(
                                                  text: ordered.listFood[index]
                                                      .toppings![INDEX].total
                                                      .toVND(unit: "đ"),
                                                  color: Colors.black,
                                                  size: ScreenUtil().setSp(8))
                                            ],
                                          );
                                        }),
                                SizedBox(
                                  height: ScreenUtil().setHeight(10),
                                ),
                              ],
                            ),
                          );
                        }),
                    SizedBox(
                      height: ScreenUtil().setHeight(10),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(4),
                          left: ScreenUtil().setWidth(20),
                          right: ScreenUtil().setWidth(10)),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: AppColors.borderBottom, width: 1.0))),
                      width: double.maxFinite,
                      child: Column(
                        children: [
                          ordered.detailOrdered.discount == 0
                              ? SizedBox(
                                  height: ScreenUtil().setHeight(1),
                                )
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SmallText(
                                      text: "Giảm giá:",
                                      color: AppColors.mainBlackColor,
                                    ),
                                    SmallText(
                                        text:
                                            "-${ordered.detailOrdered.discount.toString().toVND(unit: "đ")}",
                                        color: AppColors.mainBlackColor),
                                  ],
                                ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SmallText(
                                text: "Tổng cộng:",
                                color: AppColors.mainBlackColor,
                              ),
                              SmallText(
                                  text: ordered.detailOrdered.total
                                      .toString()
                                      .toVND(unit: "đ"),
                                  color: AppColors.mainBlackColor),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(4),
                          left: ScreenUtil().setWidth(20),
                          right: ScreenUtil().setWidth(10)),
                      height: ScreenUtil().setHeight(70),
                      width: double.maxFinite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SmallText(
                              text: "Phương thức thanh toán:",
                              fontWeight: "bold",
                              color: Colors.black),
                          SmallText(text: "Tiền mặt", color: Colors.black),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          )):Center(
            child: CircularProgressIndicator(
              color: AppColors.mainColor,
            ),
          );
        }));
  }
}
