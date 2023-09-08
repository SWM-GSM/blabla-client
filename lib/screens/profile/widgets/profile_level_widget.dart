import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:flutter/material.dart';

class ProfileLevelWidget extends StatelessWidget {
  const ProfileLevelWidget(
      {super.key,
      required this.degree,
      required this.desc,
      required this.selected});
  final int degree;
  final String desc;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: 84,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: selected ? BlaColor.lightOrange : BlaColor.grey100),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Lv. $degree",
            style: selected
                ? BlaTxt.txt16BK.copyWith(color: BlaColor.orange)
                : BlaTxt.txt16B,
          ),
          const SizedBox(height: 4),
          Text(
            desc,
            style: selected
                ? BlaTxt.txt16SB.copyWith(color: BlaColor.semiLightOrange)
                : BlaTxt.txt16R.copyWith(color: BlaColor.grey700),
          ),
        ],
      ),
    );
  }
}
