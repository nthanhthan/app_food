import 'package:app_food/widgets/app_icon.dart';
import 'package:app_food/widgets/big_text.dart';
import 'package:app_food/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountWidget extends StatelessWidget {
  AppIcon appIcon;
  SmallText smallText;
  AccountWidget({Key? key,required this.appIcon,required this.smallText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(20),
      top: ScreenUtil().setWidth(10),
      bottom: ScreenUtil().setWidth(10)),
      child: Row(
        children: [
          appIcon,
          SizedBox(width: ScreenUtil().setWidth(10),),
          smallText
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.white,
        boxShadow:[
          BoxShadow(
            blurRadius: 1,
            offset: Offset(0,4),
            color: Colors.grey.withOpacity(0.2),
          )
        ]
      ),
    );
  }
}
