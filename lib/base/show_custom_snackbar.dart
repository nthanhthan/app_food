import 'package:app_food/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomSnackBar(String message,
    {bool isError = true, String title = "Lỗi",bool type=true}) {
  Get.snackbar(title, message,
      titleText: SmallText(
        text: title,
        color: Colors.white,
      ),
      messageText: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
    colorText: Colors.white,
    snackPosition: SnackPosition.TOP,
    backgroundColor: type?Colors.redAccent:Colors.blueAccent,
     onTap: (snack){

     }
  );
}
