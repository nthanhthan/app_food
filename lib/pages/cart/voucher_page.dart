import 'package:app_food/utils/colors.dart';
import 'package:app_food/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VoucherPage extends StatelessWidget {
  const VoucherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: ,
        title: const Center(child: Text("Phiếu giảm giá")),
      ),
      body: SingleChildScrollView(
        child: ListView.builder( padding:
      EdgeInsets.only(top: ScreenUtil().setHeight(5)),
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount:10,
    itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.only(
                top: ScreenUtil().setHeight(4),
                left: ScreenUtil().setWidth(20),
                right: ScreenUtil().setWidth(10)),
            height: ScreenUtil().setHeight(150),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: AppColors.borderBottom, width: 5.0))),
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SmallText(text: "Giảm 15%  tối đa 50k",fontWeight: "bold",color: Colors.black ,),
                    SmallText(text: "Voucher có giá trị giảm 15% tối đa 50.000đ cho đơn hàng từ 0đ( không bao gồm phí giao hàng"),
                  ],
                ),
                SmallText(text: "Chọn", color: AppColors.mainColor,fontWeight: "bold",size: ScreenUtil().setSp(10),)

              ],
            ),
          );
    }),
      )
    );
  }
}
