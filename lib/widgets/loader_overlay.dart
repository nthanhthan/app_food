import 'package:app_food/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class LoadOverlay extends StatefulWidget {
  bool type;
  LoadOverlay({Key? key,required this.type}) : super(key: key);

  @override
  State<LoadOverlay> createState() => _LoadOverlayState(type);
}

class _LoadOverlayState extends State<LoadOverlay> with SingleTickerProviderStateMixin  {
  late AnimationController controller;
  bool _type;
  _LoadOverlayState(this._type);
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return _type?SpinKitPouringHourGlassRefined(
          color: Colors.white,
          size: 50.0,
          controller: controller,
        ):SpinKitThreeBounce(
      color: AppColors.mainColor,
      size: 50.0,
      controller: controller,
    );

  }
}
class LoadingOverlay {
  bool type;
  BuildContext _context;

  void hide() {
    Navigator.of(_context).pop();
  }

  void show() {
    showDialog(
        context: _context,
        barrierDismissible: false,
        builder: (ctx) => _FullScreenLoader(type));
  }

  Future<T> during<T>(Future<T> future) {
    show();
    return future.whenComplete(() => hide());
  }

  LoadingOverlay._create(this._context,this.type);

  factory LoadingOverlay.of(BuildContext context,bool type) {
    return LoadingOverlay._create(context,type);
  }
}

class _FullScreenLoader extends StatelessWidget {
  bool _type;
  _FullScreenLoader(this._type);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.5)),
        child:  Center(child: LoadOverlay(type: _type)));
  }
}