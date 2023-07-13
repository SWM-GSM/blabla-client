import 'package:blabla/models/interest.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:flutter/material.dart';

class KeywordWidget extends StatelessWidget {
  const KeywordWidget(
      {super.key, required this.keyword, required this.selected});
  final Keyword keyword;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
          color: selected ? BlaColor.lightOrange : BlaColor.grey100,
          borderRadius: BorderRadius.circular(18)),
        
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(keyword.emoji, style: BlaTxt.txt20M),
          const SizedBox(width: 8),
          Text(keyword.name,
              style: selected
                  ? BlaTxt.txt14B.copyWith(color: BlaColor.orange)
                  : BlaTxt.txt14R.copyWith(color: BlaColor.grey800))
        ],
      ),
    );
  }
}
