import 'package:blabla/screens/crew_space/crews_calendar_view.dart';
import 'package:blabla/screens/crew_space/crews_reports_view.dart';
import 'package:blabla/screens/crew_space/crews_view_model.dart';
import 'package:blabla/screens/crew_space/crews_voiceroom_view.dart';
import 'package:blabla/screens/crew_space/widgets/crews_report_widget.dart';
import 'package:blabla/screens/crew_space/widgets/crews_schedule_widget.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:blabla/widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class CrewsMainView extends StatelessWidget {
  const CrewsMainView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CrewsViewModel>(context);
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 64,
          backgroundColor: BlaColor.white,
          elevation: 0,
          title: Text(
            viewModel.crewName,
            style: BlaTxt.txt18B,
          ),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SvgPicture.asset(
                "assets/icons/ic_32_arrow_left.svg",
                width: 24,
                height: 24,
              ),
            ),
          ),
          leadingWidth: 64,
          actions: [
            GestureDetector(
              onTap: () {
                print("세팅 버튼 클릭");
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SvgPicture.asset(
                  "assets/icons/ic_24_setting.svg",
                  width: 24,
                  height: 24,
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("다가오는 일정", style: BlaTxt.txt20B),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CrewsCalendarView()));
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "더보기",
                            style: BlaTxt.txt14ML
                                .copyWith(color: BlaColor.grey600),
                          ),
                          SvgPicture.asset("assets/icons/ic_16_arrow_right.svg",
                              width: 16, height: 16)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              viewModel.upcomingSchedule == null
                  ? const CrewsScheduleWidget(
                      type: ScheduleWidgetType.none, schedule: null)
                  : CrewsScheduleWidget(
                      type: ScheduleWidgetType.upcodming,
                      schedule: viewModel.upcomingSchedule),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "보이스룸",
                        style: BlaTxt.txt20B,
                      ),
                      Text(
                        "6명 참여중",
                        style: BlaTxt.txt14M.copyWith(color: BlaColor.grey700),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18, bottom: 16),
                    child: Wrap(
                      spacing: 8,
                      alignment: WrapAlignment.center,
                      children: [
                        const ProfileWidget(
                            profileSize: 36,
                            profile: "cat",
                            bgSize: 60,
                            bgColor: BlaColor.lightOrange),
                        const ProfileWidget(
                          profileSize: 36,
                          profile: "dog",
                          bgSize: 60,
                          bgColor: Color(0xFFEDE5E4),
                        ),
                        const ProfileWidget(
                          profileSize: 36,
                          profile: "chicken",
                          bgSize: 60,
                          bgColor: Color(0xFFF8F7F9),
                        ),
                        Container(
                            height: 60,
                            width: 60,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.all(12),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: BlaColor.grey300,
                            ),
                            child: Text(
                              "+2",
                              style: BlaTxt.txt20B
                                  .copyWith(color: BlaColor.grey700),
                            )),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CrewsVoiceroomView()));
                    },
                    child: Container(
                      width: double.infinity,
                      height: 48,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: BlaColor.orange,
                      ),
                      child: Text(
                        "참여하기",
                        style: BlaTxt.txt14B.copyWith(color: BlaColor.white),
                      ),
                    ),
                  )
                ]),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("크루 리포트", style: BlaTxt.txt20B),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CrewsReportsView()));
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "더보기",
                                  style: BlaTxt.txt14ML
                                      .copyWith(color: BlaColor.grey600),
                                ),
                                SvgPicture.asset(
                                    "assets/icons/ic_16_arrow_right.svg",
                                    width: 16,
                                    height: 16)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Wrap(
                            direction: Axis.horizontal,
                            spacing: 16,
                            children: List.generate(
                                viewModel.reportList.length,
                                (idx) => CrewsReportWidget(
                                    reportType: ReportType.small,
                                    reportStatus: true,
                                    report: viewModel.reportList[idx])))),
                  ],
                ),
              )
            ],
          ),
        )));
  }
}
