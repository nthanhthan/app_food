import 'package:app_food/utils/colors.dart';
import 'package:app_food/widgets/skeleton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
class ShimmerLoad extends StatelessWidget {
  const ShimmerLoad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.0,
      height: 100.0,
      child: Shimmer.fromColors(
        baseColor: Colors.red,
        highlightColor: AppColors.mainColor,
        child: ListView.separated(
          itemCount: 5,
          itemBuilder: (context, index) =>
          const NewsCardSkeleton(),
          separatorBuilder: (context, index) =>
          const SizedBox(height: 16),
        ),
      ),
    );
  }
}
