import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';
import 'icon_and_text_widget.dart';
import 'small_text.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({Key? key,
    required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text,size: ScreenUtil().setSp(14),),
        SizedBox(
          height: ScreenUtil().setHeight(5),
        ),
        Row(
          children: [
            SizedBox(
              width: ScreenUtil().setWidth(10),
            ),
            Wrap(
              children: List.generate(5, (index) {
                return Icon(
                  Icons.star,
                  color: AppColors.iconColor1,
                  size: ScreenUtil().setHeight(15),
                );
              }),
            ),
            SizedBox(
              width: ScreenUtil().setWidth(15),
            ),
            SmallText(text: "4.5"),
            SizedBox(
              width: ScreenUtil().setWidth(15),
            ),
            SmallText(text: "(100+)")
          ],
        ),
        SizedBox(
          height:ScreenUtil().setHeight(5),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndTextWidget(
                icon: Icons.food_bank_outlined,
                text: "Quán NSL",
                iconColor: AppColors.iconColor1),
            IconAndTextWidget(
                icon: Icons.location_on,
                text: "1.7km",
                iconColor: AppColors.iconColor1),

          ],
        )
      ],
    );
  }
}
