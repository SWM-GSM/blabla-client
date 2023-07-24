import 'package:blabla/models/level.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:blabla/widgets/custom_slider_thumb_widget.dart';
import 'package:flutter/material.dart';

class LevelTileWidget extends StatelessWidget {
  const LevelTileWidget({super.key, required this.lang, required this.level});
  final String lang;
  final Level level;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("최소 $lang 레벨", style: BlaTxt.txt16M,),
              const SizedBox(height: 4,),
              Text(level.desc, style: BlaTxt.txt14R.copyWith(color: BlaColor.grey700),),
            ],
          ),
          Container(
            width: 48,
            height: 48,
            padding: const EdgeInsets.symmetric(vertical: 14),
            alignment: Alignment.center,
            decoration: const BoxDecoration(shape: BoxShape.circle, color: BlaColor.lightOrange,),
            child: Text("Lv. ${level.degree}", style: BlaTxt.txt14BK.copyWith(color: BlaColor.orange),),
          ),
          
        ],),
        const SizedBox(height:12),
         SliderTheme(
          data: SliderThemeData(
              trackHeight: 8,
              thumbShape: CustomSliderThumbWidget(num: level.degree),
              activeTrackColor: BlaColor.orange,
              activeTickMarkColor: BlaColor.white.withOpacity(0.3),
              inactiveTickMarkColor: BlaColor.grey300,
              overlayColor: BlaColor.black.withOpacity(0.16),
              overlayShape: SliderComponentShape.noThumb),
          child: Slider(
              inactiveColor: BlaColor.grey100,
              thumbColor: BlaColor.orange,
              value: 3,
              min: 1,
              max: 5,
              divisions: 4,
              onChanged: (value) {
                
              }),
        ),
        ],
      ),
    );
  }
}