import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:blabla/widgets/profile_widget.dart';
import 'package:flutter/material.dart';

class CrewsReportWidget extends StatelessWidget {
  const CrewsReportWidget({super.key, required this.reportType});
  final bool reportType; // 임시 생성 중

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 172,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: BlaColor.grey100,
      ),
      child: reportType
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Wrap(
                      spacing: -8,
                      direction: Axis.horizontal,
                      children: [
                        const ProfileWidget(
                          profileSize: 16,
                          profile: "cat",
                          bgSize: 32,
                          bgColor: Color(0xFFFFF6DE),
                        ),
                        const ProfileWidget(
                          profileSize: 16,
                          profile: "dog",
                          bgSize: 32,
                          bgColor: Color(0xFFEDE5E4),
                        ),
                        const ProfileWidget(
                          profileSize: 16,
                          profile: "chicken",
                          bgSize: 32,
                          bgColor: Color(0xFFF8F7F9),
                        ),
                        Container(
                            width: 32,
                            height: 32,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: BlaColor.grey300),
                            child: Text(
                              "+9",
                              style: BlaTxt.txt12B
                                  .copyWith(color: BlaColor.grey700),
                            )),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  "소요 시간",
                  style: BlaTxt.txt12R.copyWith(color: BlaColor.grey700),
                ),
                const SizedBox(height: 4),
                Text("00:23:40", style: BlaTxt.txt12M),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  "생성 시각",
                  style: BlaTxt.txt12R.copyWith(color: BlaColor.grey700),
                ),
                const SizedBox(height: 4),
                Text("2023.05.30 16:00", style: BlaTxt.txt12M),
              ],
            )
          : Container(
              width: 140,
              height: 172,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: BlaColor.grey100,
              ),
              child: Wrap(
                direction: Axis.vertical,
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  CircularProgressIndicator(
                    strokeWidth: 8,
                    color: BlaColor.orange,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "리포트 생성중...",
                    style: BlaTxt.txt12SB.copyWith(color: BlaColor.grey700),
                  ),
                ],
              ),
            ),
    );
  }
}
