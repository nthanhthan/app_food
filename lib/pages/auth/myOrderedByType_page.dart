import 'package:app_food/controllers/myOrdered_controller.dart';
import 'package:app_food/models/myOrdered_model.dart';
import 'package:app_food/routes/route_helper.dart';
import 'package:app_food/utils/colors.dart';
import 'package:app_food/widgets/app_icon.dart';
import 'package:app_food/widgets/loader_overlay.dart';
import 'package:app_food/widgets/small_text.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class MyOrderedByType extends StatefulWidget {
  const MyOrderedByType({
    Key? key,
    required this.data,
  }) : super(key: key);
  final List<MyOrdered>? data;

  @override
  State<MyOrderedByType> createState() => _MyOrderedByTypeState();
}

class _MyOrderedByTypeState extends State<MyOrderedByType> {
  bool loaderOverlay = true;

  @override
  Widget build(BuildContext context) {
    final overlay = LoadingOverlay.of(context, false);
    return Scaffold(
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: widget.data!.isNotEmpty
              ? ListView.builder(
                  padding: EdgeInsets.only(top: ScreenUtil().setHeight(5)),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.data?.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        if (loaderOverlay) {
                          overlay.show();
                        } else {
                          overlay.hide();
                        }
                        bool check = await Get.find<MyOrderController>()
                            .getDetailOrdered(widget.data![index].orderId);
                        if (check) {
                          setState(() {
                            loaderOverlay = false;
                            //overlay.hide();
                          });
                          Get.toNamed(RouteHelper.getDetailOrdered(
                              widget.data![index].orderId));
                        }
                      },
                      child: Container(
                        color: const Color(0xFFF2F2F2),
                        padding: EdgeInsets.only(
                            top: ScreenUtil().setHeight(10),
                            left: ScreenUtil().setWidth(10),
                            right: ScreenUtil().setWidth(15)),
                        height: ScreenUtil().setHeight(140),
                        // decoration: BoxDecoration(
                        //   border: Border(
                        //       bottom: BorderSide(
                        //           color: AppColors.borderBottom, width: 2.0)),
                        // ),
                        width: double.maxFinite,
                        child: ClayContainer(
                          color: const Color(0xFFF2F2F2),
                          customBorderRadius: const BorderRadius.only(topRight: Radius.circular(40),bottomLeft:  Radius.circular(50),topLeft: Radius.circular(20)),
                          depth: 10,
                          spread: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: ScreenUtil().setWidth(8),
                                  ),
                                  SvgPicture.asset(
                                      "assets/images/checkmark_ic.svg"),
                                  SizedBox(
                                    width: ScreenUtil().setWidth(8),
                                  ),
                                  SmallText(
                                    text: widget.data![index].state!,
                                    color: AppColors.mainBlackColor,
                                    size: ScreenUtil().setSp(8),
                                  ),
                                ],
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: ScreenUtil().setWidth(8),
                                  ),
                                  SmallText(
                                    text: widget.data![index].storeName!,
                                    color: AppColors.mainBlackColor,
                                    size: ScreenUtil().setSp(12),
                                    fontWeight: "bold",
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: ScreenUtil().setWidth(8),
                                      ),
                                      SmallText(
                                        text: widget.data![index].created.toString(),
                                        fontWeight: "bold",
                                        color: AppColors.paraColor,
                                        size: ScreenUtil().setSp(8),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SmallText(
                                        text: widget.data![index].total
                                            .toString()
                                            .toVND(unit: "đ"),
                                        color: AppColors.mainBlackColor,
                                        fontWeight: "bold",
                                        size: ScreenUtil().setSp(10),
                                      ),
                                      SizedBox(
                                        width: ScreenUtil().setWidth(8),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      SmallText(
                                        text: "Xem chi tiết",
                                        color: AppColors.mainColor,
                                        fontWeight: "bold",
                                        size: ScreenUtil().setSp(8),
                                      ),
                                      SizedBox(
                                        width: ScreenUtil().setWidth(15),
                                      ),
                                    ],
                                  ),

                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  })
              : Center(child: Text("Trống"))),
    );
  }
}
