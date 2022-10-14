
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';
import '../widgets/app_text_field.dart';
import '../widgets/big_text.dart';
import 'sign_in_page.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController=TextEditingController();
    var passwordController=TextEditingController();
    var nameController=TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: Dimensions.screenHeight*0.05,),
            Container(
              height: Dimensions.screenHeight*0.25,
              child: Center(
                child: CircleAvatar(
                  backgroundColor:Colors.white,
                  radius: 70,
                  backgroundImage: AssetImage(
                    "assets/images/logo.png"
                  ),
                ),
              ),
            ),
            AppTextField(textController: nameController, hintText: "Tên", icon: Icons.person),
            SizedBox(height: Dimensions.height20,),
            AppTextField(textController: emailController, hintText: "Email", icon: Icons.email),
            SizedBox(height: Dimensions.height20,),
            AppTextField(textController: passwordController, hintText: "Password", icon: Icons.password_sharp,obscureText: true,),
            SizedBox(height: Dimensions.height45,),
            Container(
              width: Dimensions.screenWidth/2,
                height: Dimensions.screenHeight/16,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: AppColors.mainColor
              ),
              child: Center(
                child: BigText(
                  text: "ĐĂNG KÝ",
                  size: Dimensions.font20+Dimensions.font20/3,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: Dimensions.height10,),
            RichText(
                text: TextSpan(
                    text: "Đã có tài khoản? ",
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimensions.font20
                    ),
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignInPage()),
                        text: " Đăng nhập",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.mainBlackColor,
                            fontSize: Dimensions.font20
                        ),)
                    ]
                )),
          ],
        ),
      ) ,
    );
  }
}
