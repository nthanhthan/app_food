import 'dart:convert';
import 'package:app_food/controllers/cart_controller.dart';
import 'package:app_food/data/repository/payment_repo.dart';
import 'package:app_food/models/voucher_model.dart';
import 'package:app_food/routes/route_helper.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'myOrdered_controller.dart';

class PaymentController extends GetxController{
  final PaymentRepo paymentRepo;
  final CartController cartController;
  List<dynamic> _listVoucher=[];
  List<dynamic> get listVoucher=>_listVoucher;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  String? voucherID;
  num amountDiscount=0;
  String addressUser="";
  String phoneNumberUser="";
  PaymentController({required this.paymentRepo,required this.cartController})  {
     initUser();
  }
  Future<bool> getVoucher(id) async {
    http.Response response = (await paymentRepo.getVoucher(id));
    if (response.statusCode == 200) {
      _listVoucher=[];
      List<dynamic>  decodedList = json.decode(response.body);
      List<VoucherStore> posts = List<VoucherStore>.from(decodedList.map((model)=> VoucherStore.fromJson(model)));
      _listVoucher.addAll(posts);
      _isLoaded=true;
      update();
      // return _foodsDetail;
      return true;
    } else {
      _isLoaded=false;
      return false;
      // return false;
    }
  }
  initUser() async {
    await paymentRepo.getUser();
    voucherID="";
    phoneNumberUser=paymentRepo.phoneNumberUser;
    addressUser=paymentRepo.addressUser;
    update();
  }
  checkVoucher(VoucherStore voucher){
    int amount=cartController.totalAmount;
     amountDiscount=0;
    if(amount>=voucher.minSpend!){
      double discount=(amount*voucher.amount!/100);
      amountDiscount=discount.floor();
      if(amountDiscount>voucher.maxDiscount!){
        amountDiscount=voucher.maxDiscount!;
      }
      voucherID=voucher.voucherId;
    }
    update();
    return amountDiscount;
  }
  getTotal(){
    return cartController.totalAmount-amountDiscount;
  }
  Future<bool> confirmOrder(String note) async {
    _isLoaded=false;
    print(voucherID);
    bool checkOrder=await paymentRepo.confirmOrder(voucherID,note);
    if(checkOrder){
      await Get.find<MyOrderController>().getListMyOrdered();
      clear();
      cartController.getCartData();
      return true;
    }else{
      Get.toNamed(RouteHelper.homepage);
    }
    return false;
  }
  void clear(){
    cartController.setItems={};
    update();
  }
}