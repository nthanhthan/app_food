import 'package:app_food/data/api/api_client.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RecommendedStoreNearRepo extends GetxService{
  final ApiClient apiClient;
  RecommendedStoreNearRepo({required this.apiClient});
  // Future<Response> getRecommendedProductList() async{
  //   var fullApiUrl=apiClient.appBaseUrl+"GetNearBy";
  //   return await apiClient.getData(fullApiUrl);
  // }
  Future<http.Response> getRecommendedStoreNearList(data) async{
    var fullApiUrl="https://takefoodstoreservice.azurewebsites.net/GetNearBy";
    return await apiClient.getStoreNear(data,fullApiUrl);
  }

}