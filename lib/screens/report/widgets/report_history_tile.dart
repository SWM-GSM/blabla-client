import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReportHistoryTile extends StatelessWidget {
  const ReportHistoryTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.fromLTRB(20, 16, 16, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: BlaColor.grey100,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Bernardo 외 3명", style: BlaTxt.txt14SB),
              const SizedBox(height: 4,),
              Text("1:03:03",
                  style: BlaTxt.txt12R.copyWith(color: BlaColor.grey700))
            ],
          ),
          Container(
            width: 48,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: BlaColor.lightOrange,
            ),
            child: SvgPicture.asset(
              "assets/icons/ic_16_team.svg",
              width: 24,
              height: 24,
              colorFilter:
                  const ColorFilter.mode(BlaColor.orange, BlendMode.srcIn),
            ),
          )
        ],
      ),
    );
  }
}
