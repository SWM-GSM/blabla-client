import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:blabla/widgets/skeleton_ui_widget.dart';
import 'package:flutter/material.dart';

class CrewTileWidget extends StatelessWidget {
  const CrewTileWidget({super.key, required this.name, required this.img});
  final String? name;
  final String? img;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20),
      width: 140,
      child: Column(
        children: [
          img == null
              ? SkeletonBoxWidget(
                  child: Container(
                      width: 140,
                      height: 110,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: BlaColor.black
                      ),
                      ),)
              : Container(
                  width: 140,
                  height: 110,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: AssetImage("assets/imgs/img_360_crew_$img.png"),
                        fit: BoxFit.cover,
                      )),
                ),
          const SizedBox(height: 8),
          name == null
              ? Column(
                children: [
                  SkeletonTxtWidget(style: BlaTxt.txt14R, width: 140),
                  SkeletonTxtWidget(style: BlaTxt.txt14R, width: 140),
                ],
              )
              : Text(
                  name!,
                  style: BlaTxt.txt14R,
                  maxLines: 2,
                ),
        ],
      ),
    );
  }
}
