import 'package:blabla/models/report.dart';
import 'package:blabla/screens/crew_space/crews_report_detail_view.dart';
import 'package:blabla/screens/crew_space/crews_view_model.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:blabla/utils/datetime_to_str.dart';
import 'package:blabla/widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum ReportType { small, big }

class CrewsReportWidget extends StatelessWidget {
  const CrewsReportWidget(
      {super.key,
      required this.reportType,
      required this.reportStatus,
      required this.report});
  final ReportType reportType;
  final bool reportStatus;
  final Report? report;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CrewsViewModel>(context);
    return GestureDetector(
      onTap: () {
        if (reportStatus) {
          viewModel.setReport(report!.id).then((value) => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CrewsReportDetailView())));
        }
      },
      child: switch (reportType) {
        ReportType.small => Container(
            width: 140,
            height: 172,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: BlaColor.grey100,
            ),
            child: reportStatus
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Wrap(
                            spacing: -8,
                            direction: Axis.horizontal,
                            children:
                                List.generate(report!.members.length, (idx) {
                              if (idx < 3) {
                                return ProfileWidget(
                                  profileSize: 16,
                                  profile: report!.members[idx].profileImage,
                                  bgSize: 32,
                                  bgColor: BlaColor.lightOrange, // 수정 - 프로필 전용 색상으로 교체 Color(0xFFFFF6DE),
                                );
                              } else if (idx == 3) {
                                return Container(
                                    width: 32,
                                    height: 32,
                                    alignment: Alignment.center,
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: BlaColor.grey300),
                                    child: Text(
                                      "+${report!.members.length - 3}",
                                      style: BlaTxt.txt12B
                                          .copyWith(color: BlaColor.grey700),
                                    ));
                              } else {
                                return const SizedBox();
                              }
                            }),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "소요 시간",
                        style: BlaTxt.txt12R.copyWith(color: BlaColor.grey700),
                      ),
                      const SizedBox(height: 4),
                      Text(report!.durationTime, style: BlaTxt.txt12M),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        "생성 시각",
                        style: BlaTxt.txt12R.copyWith(color: BlaColor.grey700),
                      ),
                      const SizedBox(height: 4),
                      Text(
                          datetimeToStr(
                              report!.createdAt, StrDatetimeType.dotDelimiter),
                          style: BlaTxt.txt12M),
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
                        const CircularProgressIndicator(
                          strokeWidth: 8,
                          color: BlaColor.orange,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "리포트 생성중...",
                          style:
                              BlaTxt.txt12SB.copyWith(color: BlaColor.grey700),
                        ),
                      ],
                    ),
                  ),
          ),
        ReportType.big => Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
            decoration: BoxDecoration(
              color: BlaColor.grey100,
              borderRadius: BorderRadius.circular(12),
            ),
            height: 168,
            child: reportStatus
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        direction: Axis.horizontal,
                        children: [
                          Text(
                            report!.members[0].nickname,
                            style: BlaTxt.txt16B,
                          ),
                          if (report!.members.length > 1)
                            Text(
                              " 외 ${report!.members.length - 1}명",
                              style: BlaTxt.txt16R,
                            ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                          child: Wrap(
                              direction: Axis.horizontal,
                              spacing: -6,
                              children: List.generate(
                                  report!.members.length,
                                  (idx) => ProfileWidget(
                                        profileSize: 24,
                                        profile:
                                            report!.members[idx].profileImage,
                                        bgSize: 48,
                                        bgColor: BlaColor.lightOrange,
                                      ))),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "생성 시간",
                                  style: BlaTxt.txt12R
                                      .copyWith(color: BlaColor.grey700),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  datetimeToStr(report!.createdAt,
                                      StrDatetimeType.dotDelimiter),
                                  style: BlaTxt.txt12M,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "소요 시간",
                                  style: BlaTxt.txt12R
                                      .copyWith(color: BlaColor.grey700),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  report!.durationTime,
                                  style: BlaTxt.txt12M,
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(
                        strokeWidth: 8,
                        color: BlaColor.orange,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "리포트 생성중...",
                        style: BlaTxt.txt12SB.copyWith(color: BlaColor.grey700),
                      ),
                    ],
                  ))
      },
    );
  }
}
