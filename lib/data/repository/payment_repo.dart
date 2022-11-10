import 'package:get/get.dart';

import '../api/api_client.dart';

class PaymentRepo extends GetxService{
  final ApiClient apiClient;
  PaymentRepo({required this.apiClient});


}