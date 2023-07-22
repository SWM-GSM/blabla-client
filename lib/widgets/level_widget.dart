import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:blabla/widgets/skeleton_ui_widget.dart';
import 'package:flutter/material.dart';

class LevelWidget extends StatelessWidget {
  const LevelWidget({super.key, required this.lang, required this.level});
  final String lang;
  final int? level;

  @override
  Widget build(BuildContext context) {
    return level == null
        ? SkeletonBoxWidget(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: BlaColor.grey200),
              child: Text("$lang - Lv. 0", style: BlaTxt.txt12R),
            ),
          )
        : Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: BlaColor.grey200),
            child: Text("$lang - Lv. $level", style: BlaTxt.txt12R.copyWith(color: BlaColor.grey800)),
          );
  }
}