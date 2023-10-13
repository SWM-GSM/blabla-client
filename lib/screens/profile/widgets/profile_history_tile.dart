import 'package:blabla/models/history.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileHistoryTile extends StatelessWidget {
  const ProfileHistoryTile({super.key, required this.report});
  final HistoryReport report;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(16),
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
              SizedBox(
                width: MediaQuery.of(context).size.width -
                    164, // 기본패딩 + 날짜타일 + 타일 패딩 + 아이콘 + 아이콘간격 = 40 + 40(30여유) + 32 + 40 + 12
                child: Text(report.title,
                    style: BlaTxt.txt14SB),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(report.subTitle,
                  style: BlaTxt.txt12R.copyWith(color: BlaColor.grey700))
            ],
          ),
          Container(
            width: 40,
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: BlaColor.lightOrange,
            ),
            child: SvgPicture.asset(
              report.type == "crew"
                  ? "assets/icons/ic_16_team.svg"
                  : "assets/icons/ic_24_play_circle.svg",
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
