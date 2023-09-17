import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:flutter/material.dart';

class JoinLangWidget extends StatelessWidget {
  const JoinLangWidget(
      {super.key,
      required this.title,
      required this.desc,
      required this.selected});
  final String title;
  final String desc;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      width: MediaQuery.of(context).size.width - 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: selected ? BlaColor.lightOrange : BlaColor.grey100),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
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
