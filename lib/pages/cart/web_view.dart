
import 'package:app_food/utils/colors.dart';
import 'package:flutter/material.dart';
 import 'package:webview_flutter/webview_flutter.dart';
class WebViewContainer extends StatefulWidget {
  final url;
  const WebViewContainer({Key? key, this.url}) : super(key: key);

  @override
  State<WebViewContainer> createState() => _WebViewState(this.url);
}

class _WebViewState extends State<WebViewContainer> {
  var _url;
  _WebViewState(this._url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: const Text("Thanh Toán"),
        centerTitle: true,),
      body: Column(
        children: [
          Expanded(child: WebView(
              key: UniqueKey(),
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: _url)
          )
        ],
      ),
    );
  }
}