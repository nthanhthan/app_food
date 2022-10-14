import 'package:get/get.dart';
class Dimensions{
  static double screenHeight=Get.context!.height; //820
  static double screenWidth=Get.context!.width;  //411
  static double pageView=screenHeight/2.56; //820/320
  static double pageViewContainer=screenHeight/3.73; //820/220
  static double pageViewTextContainer=screenHeight/6.83;   //820/120
  //dynamic height padding and margin
  static double height10=screenHeight/82;
  static double height15=screenHeight/54.67;
  static double height20=screenHeight/41;
  static double height30=screenHeight/27.3;
  static double height45=screenHeight/18.22;
  static double height55=screenHeight/14.91;
  //dynamic width padding and margin
  static double width10=screenHeight/82;
  static double width15=screenHeight/54.67;
  static double width20=screenHeight/41;
  static double width30=screenHeight/27.3;
   //font size
  static double font20=screenHeight/41;
  static double font26=screenHeight/31.54;
  static double font16=screenHeight/51.25;


  //radius
  static double radius20=screenHeight/42;
  static double radius30=screenHeight/27.3;
  static double radius15=screenHeight/54.67;

  //icon size
static double iconSize24=screenHeight/34.17;
  static double iconSize16=screenHeight/51.25;
  static double iconSize30=screenHeight/27.3;
  static double iconSize40=screenHeight/20.5;

//list view size
static double listViewImgSize=screenWidth/3.43; //411/120
static double listViewTextContSize=screenWidth/4.11;  //411/100

//pupular food
static double popularFoodImgSize=screenHeight/2.34;

//bottom height
static double bottomHeightBar=screenHeight/6.83;
}