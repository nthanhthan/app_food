import 'package:app_food/base/show_custom_snackbar.dart';
import 'package:app_food/controllers/user_controller.dart';
import 'package:app_food/routes/route_helper.dart';
import 'package:app_food/utils/colors.dart';
import 'package:app_food/widgets/app_text_field.dart';
import 'package:app_food/widgets/big_text.dart';
import 'package:app_food/widgets/loader_overlay.dart';
import 'package:app_food/widgets/small_text.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool loaderOverlay = true;
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  bool _isHidden = true;
  @override
  Widget build(BuildContext context) {
    final overlay = LoadingOverlay.of(context, false);
    double screenHeight = Get.context!.height; //820
    double screenWidth = Get.context!.width; //411
    print(screenHeight);
    print(screenWidth);
    Future<bool> _login() async {
      var data = {
        'username': emailController.text.trim(),
        'password': passwordController.text.trim(),
      };
      if(emailController.text.trim().isEmpty ||passwordController.text.trim().isEmpty ){
        showCustomSnackBar("Nhập đủ thông tin");
      }else{
        bool checkEmail=EmailValidator.validate(emailController.text.trim());
        if(checkEmail){
          var check = await Get.find<UserController>().SignIn(data, "SignIn");
          return check;
        }else{
          showCustomSnackBar("Email không đúng định dạng",title: "Lỗi email");
        }
      }
      return false;

    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: ScreenUtil().setHeight(36.5),
            ),
            Container(
              height: ScreenUtil().setHeight(182),
              child: const Center(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 90,
                  backgroundImage: AssetImage("assets/images/logo.png"),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: ScreenUtil().setWidth(15)),
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Fooder xin chào",
                    style: GoogleFonts.lobster(
                      textStyle: TextStyle(
                          color: Color(0xFFFF8357),
                          fontSize: ScreenUtil().setSp(20),
                          fontWeight: FontWeight.bold),
                    )

                  ),
                ],
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(25),
            ),
            AppTextField(
              textController: emailController,
              hintText: "Email",
              icon: Icons.email,
              textInputType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: ScreenUtil().setHeight(20),
            ),
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
            SizedBox(
              height: ScreenUtil().setHeight(50),
            ),
            Container(
                width: ScreenUtil().setWidth(250),
                height: ScreenUtil().setHeight(70),
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().radius(30)),
                    color: AppColors.mainColor),
                child: Center(
                    child: GestureDetector(
                  onTap: () async {
                    if (loaderOverlay) {
                      overlay.show();
                    } else {
                      overlay.hide();
                    }

                    var signIn = await _login();
                    if (signIn == true) {
                      setState(() {
                        loaderOverlay = false;
                      });
                      Navigator.pushNamedAndRemoveUntil(
                          context, RouteHelper.homepage, (route) => false);
                      // Get.offNamed(RouteHelper.homepage);
                    } else {
                      setState(() {
                        overlay.hide();
                        //loaderOverlay = false;
                      });
                      emailController.text = "";
                      passwordController.text = "";

                    }
                  },
                  child: BigText(
                    text: "ĐĂNG NHẬP",
                    size: ScreenUtil().setSp(15),
                    color: Colors.white,
                  ),
                ))),
            SizedBox(height: ScreenUtil().setHeight(10)),
            GestureDetector(
              onTap: (){
               Get.toNamed(RouteHelper.webViewForgotPass);
              },
                child: SmallText(
                    text: "Quên mật khẩu", color: AppColors.mainBlackColor)),
            SizedBox(height: ScreenUtil().setHeight(40)),
            RichText(
                text: TextSpan(
                    text: "Chưa có tài khoản? ",
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: ScreenUtil().setSp(20)),
                    children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.toNamed(RouteHelper.signUp);
                      },
                    text: " Đăng ký",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.mainBlackColor,
                        fontSize: ScreenUtil().setSp(25)),
                  )
                ])),
          ],
        ),
      ),
    );
  }
}
class WeViewForgotPassword extends StatefulWidget {
  const WeViewForgotPassword({Key? key}) : super(key: key);

  @override
  State<WeViewForgotPassword> createState() => _WeViewForgotPasswordState();
}

class _WeViewForgotPasswordState extends State<WeViewForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title:Text("Quên mẩu khẩu"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
              RouteHelper.initial, (route) => false),
        ),
        centerTitle: true,),
      body: Column(
        children: [
          Expanded(child: WebView(
              key: UniqueKey(),
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: "https://takefoodstore.web.app/forgotPassword")
          )
        ],
      ),
    );;
  }
}

