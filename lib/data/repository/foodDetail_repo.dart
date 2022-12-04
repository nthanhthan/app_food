import 'package:app_food/data/api/api_client.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FoodDetailRepo extends GetxService {
  final ApiClient apiClient;
  FoodDetailRepo({required this.apiClient});

  Future<http.Response> getFoodDetail(id) async {
    var fullApiUrl ="${apiClient.appBaseUrl}api/Food/GetFoodViewMobile?FoodID="+id;

    return await apiClient.Get(fullApiUrl);
  }
}
