import 'package:intl/intl.dart';

class MyOrdered {
  String? orderId;
  String? storeName;
  String? state;
  int? total;
  String? created;
  int? foodQuantity;

  MyOrdered(
      {this.orderId,
        this.storeName,
        this.state,
        this.total,
        this.created,
        this.foodQuantity});
  String parseDateTime(created){
    DateTime parseDate =  DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
        .parse(created.toString(), true);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('dd/MM/yyyy hh:mm a');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  MyOrdered.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    storeName = json['storeName'];
    state = json['state'];
    total = json['total'];
    created = json['created'];
    created=parseDateTime(created);
    foodQuantity = json['foodQuantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['storeName'] = this.storeName;
    data['state'] = this.state;
    data['total'] = this.total;
    data['created'] = this.created;
    data['foodQuantity'] = this.foodQuantity;
    return data;
  }
}