import 'package:blabla/styles/colors.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget(
      {super.key,
      required this.profileSize,
      required this.profile,
      required this.bgSize,
      this.bgColor = BlaColor.orange});
  final double profileSize;
  final String profile;
  final double bgSize;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: bgSize,
      height: bgSize,
      alignment: Alignment.center,
      padding: EdgeInsets.all((bgSize - profileSize) / 2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
            color: BlaColor.black.withOpacity(0.03),
            width: 0.5,
            strokeAlign: BorderSide.strokeAlignInside),
        color: bgColor,
      ),
      child: Image.asset(
        "assets/imgs/img_120_profile_$profile.png",
        width: profileSize,
        height: profileSize,
      ),
    );
  }
}
