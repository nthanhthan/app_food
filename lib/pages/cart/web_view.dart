
import 'package:app_food/routes/route_helper.dart';
import 'package:app_food/utils/colors.dart';
import 'package:flutter/material.dart';
 import 'package:webview_flutter/webview_flutter.dart';
class WebViewContainer extends StatefulWidget {
  final url;
  String name;
   WebViewContainer({Key? key, this.url,required this.name}) : super(key: key);

  @override
  State<WebViewContainer> createState() => _WebViewState(url,name);
}

class _WebViewState extends State<WebViewContainer> {
  final _url;
  final String _name;
  _WebViewState(this._url,this._name);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title:Text(_name.toString()),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
              RouteHelper.myOrderPage, (route) => false),
        ),
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
