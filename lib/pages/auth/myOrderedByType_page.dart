import 'package:app_food/controllers/myOrdered_controller.dart';
import 'package:app_food/models/myOrdered_model.dart';
import 'package:app_food/routes/route_helper.dart';
import 'package:app_food/utils/colors.dart';
import 'package:app_food/widgets/app_icon.dart';
import 'package:app_food/widgets/loader_overlay.dart';
import 'package:app_food/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    final overlay = LoadingOverlay.of(context,false);
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
                        bool check=await Get.find<MyOrderController>().getDetailOrdered(widget.data![index].orderId);
                        if(check){
                          setState(() {
                            loaderOverlay=false;
                            //overlay.hide();
                          });
                          Get.toNamed(RouteHelper.getDetailOrdered(widget.data![index].orderId));

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
                                  color: AppColors.borderBottom, width: 2.0)),
                        ),
                        width: double.maxFinite,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                AppIcon(
                                  icon: Icons.check,
                                  size: ScreenUtil().setHeight(20),
                                  backgroundColor: Colors.grey,
                                  iconColor: Colors.white,
                                  iconSize: ScreenUtil().setHeight(15),
                                ),
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
                            SmallText(
                              text: widget.data![index].storeName!,
                              color: AppColors.mainBlackColor,
                              size: ScreenUtil().setSp(12),
                              maxLines: 1,
                            ),
                            SmallText(
                              text: widget.data![index].created.toString(),
                              fontWeight: "bold",
                              size: ScreenUtil().setSp(8),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SmallText(
                                  text: widget.data![index]
                                      .total
                                      .toString()
                                      .toVND(unit: "đ"),
                                  color: AppColors.mainBlackColor,
                                  fontWeight: "bold",
                                  size: ScreenUtil().setSp(10),
                                ),
                                SmallText(
                                  text: "Xem chi tiết",
                                  color: AppColors.mainColor,
                                  fontWeight: "bold",
                                  size: ScreenUtil().setSp(8),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  })
              : Center(child: Text("Trống"))),
    );
  }
}
