import 'package:blabla/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonBoxWidget extends StatelessWidget {
  const SkeletonBoxWidget({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: BlaColor.grey300,
        highlightColor: BlaColor.grey100,
        child: child);
  }
}

class SkeletonTxtWidget extends StatelessWidget {
  const SkeletonTxtWidget(
      {super.key, required this.style, required this.width});
  final TextStyle style;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: (style.fontSize! * style.height! - style.fontSize!)/2),
      child: Shimmer.fromColors(
          baseColor: BlaColor.grey300,
          highlightColor: BlaColor.grey100,
          child: Container(
            height: style.fontSize!,
            width: width,
            color: BlaColor.grey100,
          )),
    );
  }
}
