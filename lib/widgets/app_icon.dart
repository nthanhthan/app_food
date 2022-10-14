import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/dimensions.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;

  const AppIcon({Key? key,
    required this.icon,
    this.backgroundColor=const Color(0xFFfcf4e4),
   this.iconColor=const Color(0xFF756d54),
     this.size=40}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimensions.iconSize40,
      height: Dimensions.iconSize40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size/2),
        color: AppColors.buttonBackgroundColor,
      ),
      child: Icon(
        icon,
        color: iconColor,
        size: size,
      ),
    );
  }
}