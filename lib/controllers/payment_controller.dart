import 'package:app_food/data/repository/payment_repo.dart';
import 'package:get/get.dart';

import '../models/cart_model.dart';

class PaymentController extends GetxController{
  final PaymentRepo paymentRepo;
  List<CartModel> storageItems=[];
  PaymentController({required this.paymentRepo});


}