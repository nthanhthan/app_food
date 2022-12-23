import 'package:app_food/pages/auth/DetailOrdered_page.dart';
import 'package:app_food/pages/auth/sign_up_page.dart';
import 'package:app_food/pages/cart/cart_page.dart';
import 'package:app_food/pages/cart/payment_page.dart';
import 'package:app_food/pages/cart/voucher_page.dart';
import 'package:app_food/pages/cart/web_view.dart';
import 'package:app_food/pages/food/comment_store.dart';
import 'package:app_food/pages/food/store.dart';
import 'package:app_food/pages/profile/edit_profile.dart';
import 'package:app_food/pages/profile/infoUser_Order.dart';
import 'package:app_food/pages/profile/profile_user.dart';
import 'package:app_food/pages/splash/splash_page.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import '../pages/auth/myordered_page.dart';
import '../pages/auth/sign_in_page.dart';
import '../pages/food/foodDetail.dart';
import '../pages/home/home_page.dart';

class RouteHelper {
  static const String initial = "/";
  static const String signUp = "/signup";
  static const String homepage = "/home_page";
  static const String storeDetail = "/store_detail";
  static const String foodDetail = "/food_detail";
  static const String Splashpage = "/splash_page";
  static const String cartPage = "/cart_page";
  static const String paymentPage = "/payment_page";
  static const String voucherPage = "/voucher_page";
  static const String myOrderPage = "/myorder_page";
  static const String detailOrdered = "/detailOrdered_page";
  static const String editProfile = "/editProfile_page";
  static const String profile = '/profile_page';
  static const String infoUserOrder = '/infoUserOrder_page';
  static const String searchPage = '/search_page';
  static const String reviewPage = '/review_page';
  static const String webView = '/web_view';
  static const String webViewForgotPass = '/web_view_forgot';

  static String getInitial() => '$initial';
  static String getHomePage() => '$homepage';
  static String getSplashPage() => '$Splashpage';
  static String getDetailFood(String storeID) => '$foodDetail?storeID=$storeID';
  static String getStoreDetail(String storeId) =>
      '$storeDetail?storeId=$storeId';
  static String getCartPage(String storeID) => '$cartPage?storeID=$storeID';
  static String getPaymentPage() => '$paymentPage';
  static String getVoucherPage() => '$voucherPage';
  static String getMyOrderPage() => '$myOrderPage';
  static String getDetailOrdered(String? orderId) =>
      '$detailOrdered?orderId=$orderId';
  static String getEditProfile() => '$editProfile';
  static String getProfileUser() => '$profile';
  static String getInfoUserOrder() => '$infoUserOrder';
  static String getSearchPage() => '$searchPage';
  static String getReviewPage() => '$reviewPage';
  static String getWebViewPage(String url,String name) => '$webView?url=$url&name=$name';
  static List<GetPage> routes = [
    GetPage(
        name: initial,
        page: () {
          return SignInPage();
        },
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: signUp,
        page: () {
          return SignUpPage();
        },
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: homepage,
        page: () {
          return HomePage();
        },
        transition: Transition.rightToLeftWithFade),
    GetPage(name: Splashpage, page: () => SplashSreeen()),
    GetPage(
        name: storeDetail,
        page: () {
          var storeId = Get.parameters['storeId'];
          return StorePage(storeId: storeId.toString());
        },
        transition: Transition.rightToLeftWithFade),
    GetPage(
      name: foodDetail,
      page: () {
        var storeID = Get.parameters['storeID'];
        return FoodDetail(storeID: storeID.toString());
      },
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
        name: cartPage,
        page: () {
          String? storeID = Get.parameters['storeID'];
          return CartPage(storeID: storeID);
        },
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: paymentPage,
        page: () {
          return PaymentPage();
        },
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: voucherPage,
        page: () {
          return VoucherPage();
        },
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: myOrderPage,
        page: () {
          return MyOrderPage();
        },
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: detailOrdered,
        page: () {
          String orderId = Get.parameters['orderId']!;
          return DetailOrderPage(orderID: orderId);
        },
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: editProfile,
        page: () {
          return EditProfile();
        },
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: profile,
        page: () {
          return ProfileUser();
        },
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: infoUserOrder,
        page: () {
          return InfoUserOrder();
        },
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: reviewPage,
        page: () {
          return CommentStore();
        },
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: webView,
        page: () {
          var url = Get.parameters['url'];
          String name=Get.parameters['name']!;
          print(url.toString());
          print(name);
          return WebViewContainer(
            url: url, name: name!,
          );
        },
        transition: Transition.downToUp),
    GetPage(
        name: webViewForgotPass,
        page: () {
          return WeViewForgotPassword(
          );
        },
        transition: Transition.downToUp),
  ];
}
