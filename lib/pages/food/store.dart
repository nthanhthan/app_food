import 'package:app_food/widgets/big_text.dart';
import 'package:app_food/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/colors.dart';
import '../../widgets/app_icon.dart';

class StorePage extends StatelessWidget {
  const StorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: ScreenUtil().setHeight(260),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/milktea.png"))),
              )),
          Positioned(
              top: ScreenUtil().setHeight(20),
              left: ScreenUtil().setWidth(20),
              right: ScreenUtil().setWidth(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(icon: Icons.arrow_back,size: ScreenUtil().setHeight(25),),
                  AppIcon(icon: Icons.search,size: ScreenUtil().setHeight(25))
                ],
              )),
          Positioned(
              top: ScreenUtil().setHeight(200),
              left: ScreenUtil().setWidth(10),
              right: ScreenUtil().setWidth(10),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: ScreenUtil().setHeight(115),
                margin: EdgeInsets.only(
                    left: ScreenUtil().setWidth(25),
                    right: ScreenUtil().setWidth(25),
                    bottom:ScreenUtil().setHeight(10)),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(ScreenUtil().radius(25)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xFFe8e8e8),
                          blurRadius: 5.0,
                          offset: Offset(0, 5)),
                      BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                      BoxShadow(color: Colors.white, offset: Offset(5, 0))
                    ]),
                child: Container(
                  padding: EdgeInsets.only(
                      top: ScreenUtil().setHeight(10),
                      left: ScreenUtil().setWidth(10),
                      right: ScreenUtil().setWidth(10)),
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(text: "Trà sữa nhà làm YumYum",size: ScreenUtil().setSp(13),),
                      SizedBox(
                        height: ScreenUtil().setHeight(10),
                      ),
                      SmallText(text: "2,6km -K26/5 đường ABC, phường Hòa Khánh Nam, Q.Liên Chiểu, TP.Đà Nẵng",color:Color(0xFF4D4D4D),size: ScreenUtil().setSp(8),),
                    ]
                  )
                ),
              ),
            ),),
          Positioned(
              top: ScreenUtil().setHeight(320),
              left: ScreenUtil().setWidth(5),
              right:ScreenUtil().setWidth(5),
              child: ListView.builder(
                  padding: EdgeInsets.only(top: ScreenUtil().setHeight(5)),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(
                          left: ScreenUtil().setWidth(10), right: ScreenUtil().setWidth(10),bottom: ScreenUtil().setWidth(10)),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: AppColors.borderBottom,
                                  width: 2.0
                              )
                          )
                      ),
                      child: Row(
                        children: [
                          //image section
                          //text container
                          Expanded(
                            child: Container(
                              height: ScreenUtil().setWidth(98),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(ScreenUtil().radius(15)),
                                  bottomRight: Radius.circular(ScreenUtil().radius(15)),
                                ),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: ScreenUtil().setWidth(10),right:  ScreenUtil().setWidth(10)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SmallText(text: "Trà sữa trân châu",size:  ScreenUtil().setSp(10),color:AppColors.mainBlackColor ),
                                    SizedBox(height: ScreenUtil().setHeight(20)),
                                    BigText(text: "25.000 đ",color:AppColors.mainBlackColor ,size:  ScreenUtil().setSp(10),)
                                  ],

                                ),


                              ),
                            ),
                          ),
                          Container(
                            width:ScreenUtil().setWidth(80),
                            height: ScreenUtil().setHeight(80),
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(ScreenUtil().radius(10)),
                                color: Colors.white38,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage("assets/images/milktea.png"))),
                          ),
                        ],
                      ),

                    );
                  }),
          )


        ],
      ),

    );
  }
}
