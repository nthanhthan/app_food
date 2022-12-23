
import 'package:app_food/routes/route_helper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../base/show_custom_snackbar.dart';
import '../../controllers/user_controller.dart';
import '../../utils/colors.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/big_text.dart';
import 'sign_in_page.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController=TextEditingController();
    var passwordController=TextEditingController();
    var nameController=TextEditingController();
    var phoneController=TextEditingController();
    Future<bool> _register() async{
      String name=nameController.text.trim();
      String email=emailController.text.trim();
      String password=passwordController.text.trim();
      String phoneNumber=phoneController.text.trim();
      if(name.isEmpty){
        showCustomSnackBar("Vui lòng nhập tên", title: "Tên");
      }else if(email.isEmpty){
        showCustomSnackBar("Vui lòng nhập email", title: "Email");
      }else if(password.isEmpty){
        showCustomSnackBar("Vui lòng nhập mật khẩu", title: "Mật khẩu");
      }else if(phoneNumber.isEmpty){
        showCustomSnackBar("Vui lòng nhập số điện thoại", title: "Số điện thoại");
      }else{
        var data={
          'name':name,
          'email':email,
          'password':password,
          'phoneNumber':phoneNumber,
        };
        var check=await Get.find<UserController>().SignUp(data, "SignUp");
        return check;
      }
      return false;

    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: ScreenUtil().setHeight(50),),
            Container(
              height: ScreenUtil().setHeight(150),
              child: const Center(
                child: CircleAvatar(
                  backgroundColor:Colors.white,
                  radius: 90,
                  backgroundImage: AssetImage(
                    "assets/images/logo.png"
                  ),
                ),
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(20),),
            AppTextField(textController: nameController, hintText: "Tên", icon: Icons.person),
            SizedBox(height: ScreenUtil().setHeight(20),),
            AppTextField(textController: emailController, hintText: "Email", icon: Icons.email),
            SizedBox(height:  ScreenUtil().setHeight(20),),
            AppTextField(textController: phoneController, hintText: "Số điện thoại", icon: Icons.phone),
            SizedBox(height:  ScreenUtil().setHeight(20),),
            AppTextField(textController: passwordController, hintText: "Mật khẩu", icon: Icons.password_sharp,obscureText: true,),
            SizedBox(height:  ScreenUtil().setHeight(40),),
            Container(
              width:  ScreenUtil().setWidth(250),
                height:  ScreenUtil().setHeight(60),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular( ScreenUtil().radius(30)),
                color: AppColors.mainColor
              ),

              child: Center(
                child:GestureDetector(
                  onTap: () async {
                    var signup=await _register();
                    if(signup==true){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignInPage()),
                    );
                    }else{
                      emailController.text="";
                      nameController.text="";
                      phoneController.text="";
                      passwordController.text="";
                      Text("SAI rooif");
                    }
                  },
                  child: BigText(
                    text: "ĐĂNG KÝ",
                    size: ScreenUtil().setSp(15),
                    color: Colors.white,
                  ),
                )
              ),

            ),
            SizedBox(height: ScreenUtil().setHeight(20),),
            RichText(
                text: TextSpan(
                    text: "Đã có tài khoản? ",
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: ScreenUtil().setSp(18)
                    ),
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()..onTap=(){
                          Get.toNamed(RouteHelper.initial);
                        },
                        text: " Đăng nhập",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.mainBlackColor,
                            fontSize: ScreenUtil().setSp(22)
                        ),)
                    ]
                )),
          ],
        ),
      ) ,
    );
  }
}
