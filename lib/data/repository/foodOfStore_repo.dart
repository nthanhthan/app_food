import 'package:app_food/data/api/api_client.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FoodOfStoreRepo extends GetxService{
  final ApiClient apiClient;
  FoodOfStoreRepo({required this.apiClient});

  Future<http.Response> getAllFoodOfStore(id,lat,lng) async{
  //  var fullApiUrl="${"https://takefoodstoreservice.azurewebsites.net/GetStore?storeId="+id+"&lat="+lat}&lng="+lng;
    var fullApiUrl="https://takefoodstoreservice.azurewebsites.net/GetStore?storeId=6358eb4c814c0de88aeb3d8a&lat=16.073877&lng=108.149892";
    print(fullApiUrl);
    return await apiClient.getAllFoodOfStore(fullApiUrl);
  }
}