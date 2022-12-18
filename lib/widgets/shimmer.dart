import 'package:app_food/utils/colors.dart';
import 'package:app_food/widgets/skeleton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
class ShimmerLoad extends StatelessWidget {
  const ShimmerLoad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.maxFinite,
        child: Shimmer.fromColors(
          baseColor: Colors.red,
          highlightColor: AppColors.mainColor,
          child: ListView.separated(
            itemCount: 5,
           // physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) =>
            const NewsCardSkeleton(),
            separatorBuilder: (context, index) =>
            const SizedBox(height: 16),
          ),
        ),
      ),
    );
  }
}
