
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

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var nameController=TextEditingController();
  var phoneController=TextEditingController();
  bool _isHidden = true;
  @override
  Widget build(BuildContext context) {

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
            AppTextField(textController: emailController, hintText: "Email", icon: Icons.email,textInputType: TextInputType.emailAddress,),
            SizedBox(height:  ScreenUtil().setHeight(20),),
            AppTextField(textController: phoneController, hintText: "Số điện thoại", icon: Icons.phone,textInputType: TextInputType.phone,),
            SizedBox(height:  ScreenUtil().setHeight(20),),
      Container(
        margin: EdgeInsets.only(left: ScreenUtil().setHeight(20),right: ScreenUtil().setWidth(20)),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(ScreenUtil().radius(30)),
            boxShadow: [
              BoxShadow(
                  blurRadius: 10,
                  spreadRadius: 7,
                  offset: Offset(1,10),
                  color: Colors.grey.withOpacity(0.2)
              )
            ]
        ),
        child: TextField(
          controller: passwordController,
          obscureText: _isHidden,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            suffix: InkWell(
              onTap: (){
                setState(() {
                  _isHidden=!_isHidden;
                });
              },
              child: Icon(
                _isHidden
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: AppColors.mainColor,
              ),
            ),
              hintText: "Mật khẩu",
              prefixIcon: Icon(Icons.password_sharp,color: AppColors.mainColor,),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(ScreenUtil().radius(30)),
                  borderSide: const BorderSide(
                    width: 0.5,
                    color: Colors.white,
                  )
              ),
              enabledBorder:  OutlineInputBorder(
                  borderRadius: BorderRadius.circular(ScreenUtil().radius(30)),
                  borderSide: const BorderSide(
                    width: 1.0,
                    color: Colors.white,
                  )
              ),
              border:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(ScreenUtil().radius(30)),

              )

          ),
          style: TextStyle(fontSize: ScreenUtil().setSp(10)),
        ),
      ),
           // AppTextField(textController: passwordController, hintText: "Mật khẩu", icon: Icons.password_sharp,obscureText: _isHidden,),
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
