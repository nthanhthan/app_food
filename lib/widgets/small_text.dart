import 'package:flutter/cupertino.dart';

class SmallText extends StatelessWidget {
  final Color? color;
  final String text;
  double size;
  double height;
  int maxLines;
  SmallText(
      {Key? key,
        this.color=const Color(0xFFccc7c5),
        required this.text,
        this.maxLines=5,
        this.size = 10,
        this.height=1.2
        })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      style: TextStyle(
        fontFamily: 'Inter',
        color: color==const Color(0xFFccc7c5)?const Color(0xFFccc7c5):color,
        fontSize: size,
        height: height
      ),
    );
  }
}
