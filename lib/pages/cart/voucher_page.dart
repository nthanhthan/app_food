import 'package:app_food/controllers/payment_controller.dart';
import 'package:app_food/utils/colors.dart';
import 'package:app_food/widgets/loader.dart';
import 'package:app_food/widgets/small_text.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VoucherPage extends StatelessWidget {
  const VoucherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          title:  Text("Phiếu giảm giá"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: GetBuilder<PaymentController>(builder: (voucher) {
          return voucher.isLoaded
              ? ListView.builder(
                  padding: EdgeInsets.only(top: ScreenUtil().setHeight(5)),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: voucher.listVoucher.isEmpty
                      ? 0
                      : voucher.listVoucher.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        final amountDiscount =
                            await Get.find<PaymentController>()
                                .checkVoucher(voucher.listVoucher[index]);
                        if (amountDiscount >= 0) {
                          Navigator.pop(context);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            top: ScreenUtil().setHeight(10),
                            left: ScreenUtil().setWidth(10),
                            right: ScreenUtil().setWidth(10)),
                        height: ScreenUtil().setHeight(150),
                        // decoration: BoxDecoration(
                        //     border: Border(
                        //         bottom: BorderSide(
                        //             color: AppColors.borderBottom,
                        //             width: 5.0))),
                        width: double.maxFinite,
                        child: ClayContainer(
                          color: const Color(0xFFF2F2F2),
                          customBorderRadius: const BorderRadius.only(topRight: Radius.circular(40),bottomLeft:  Radius.circular(50),topLeft: Radius.circular(20)),
                          depth: 10,
                          spread: 20,
                          child: Column(
                           // crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SmallText(
                                        text: voucher.listVoucher[index].name,
                                        size: 12,
                                        fontWeight: "bold",
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                  SmallText(
                                    color: AppColors.paraColor,
                                      text:
                                          voucher.listVoucher[index].description),
                                ],
                              ),
                              SmallText(
                                text: "Chọn",
                                color: AppColors.mainColor,
                                fontWeight: "bold",
                                size: ScreenUtil().setSp(10),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  })
              :const Center(child: Loader());
        })));
  }
}
