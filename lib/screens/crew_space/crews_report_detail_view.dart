import 'package:blabla/screens/crew_space/widgets/crews_feedback_widget.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:blabla/widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CrewsReportDetailView extends StatelessWidget {
  const CrewsReportDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        title: Text(
          "크루 리포트",
          style: BlaTxt.txt18B,
        ),
        backgroundColor: BlaColor.white,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SvgPicture.asset(
                "assets/icons/ic_32_arrow_left.svg",
                width: 24,
                height: 24,
                colorFilter:
                    const ColorFilter.mode(BlaColor.black, BlendMode.srcIn),
              )),
        ),
        leadingWidth: 64,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "기본 정보",
                      style: BlaTxt.txt20B,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "생성시간",
                          style:
                              BlaTxt.txt14M.copyWith(color: BlaColor.grey700),
                        ),
                        Text(
                          "2023.05.30 16:00",
                          style: BlaTxt.txt16SB,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "소요 시간",
                          style:
                              BlaTxt.txt14M.copyWith(color: BlaColor.grey700),
                        ),
                        Text(
                          "00:23:40",
                          style: BlaTxt.txt16SB,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "참여자",
                          style: BlaTxt.txt20B,
                        ),
                        Text(
                          " 8명",
                          style:
                              BlaTxt.txt20R.copyWith(color: BlaColor.grey700),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Wrap(
                        runSpacing: 20,
                        children:
                            List.generate(8, (index) => profileWithName())),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "핵심 키워드",
                      style: BlaTxt.txt20B,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 40),
                        child: Image.asset(
                          "assets/imgs/img_284_keywords.png",
                          width: 284,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        chartLabel(BlaColor.coral500, "미국 유머", 38),
                        const SizedBox(
                          height: 16,
                        ),
                        chartLabel(BlaColor.coral400, "여자친구", 32),
                        const SizedBox(
                          height: 16,
                        ),
                        chartLabel(BlaColor.coral300, "음악", 27),
                        const SizedBox(
                          height: 16,
                        ),
                        chartLabel(BlaColor.coral200, "먹방", 18),
                        const SizedBox(
                          height: 16,
                        ),
                        chartLabel(BlaColor.coral100, "넷플릭스", 9),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "언어 사용 비율",
                      style: BlaTxt.txt20B,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "한국어를 영어보다 더 많이 사용하고 있어요!",
                      style: BlaTxt.txt12R.copyWith(color: BlaColor.grey700),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Flexible(
                            flex: 6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 24,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.horizontal(
                                          left: Radius.circular(12),
                                          right: Radius.circular(4)),
                                      color: BlaColor.orange),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: BlaColor.orange),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      "한국어",
                                      style: BlaTxt.txt12R
                                          .copyWith(color: BlaColor.grey800),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "60%",
                                  style: BlaTxt.txt14B,
                                ),
                              ],
                            )),
                        const SizedBox(
                          width: 4,
                        ),
                        Flexible(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 24,
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(4),
                                        right: Radius.circular(12)),
                                    color: BlaColor.green),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: BlaColor.green),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "영어",
                                    style: BlaTxt.txt12R
                                        .copyWith(color: BlaColor.grey800),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                "40%",
                                style: BlaTxt.txt14B,
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "크루원 피드백",
                          style: BlaTxt.txt20B,
                        ),
                        const SizedBox(height: 12,),
                        CrewsFeedbackWidget(profile: "cat"),
                        CrewsFeedbackWidget(profile: "dog"),
                        CrewsFeedbackWidget(profile: "chicken"),
                        CrewsFeedbackWidget(profile: "fox"),
                      ])),
            ],
          ),
        ),
      )),
    );
  }

  Widget profileWithName() {
    return Container(
      height: 72,
      width: 62,
      margin: const EdgeInsets.only(right: 10),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const ProfileWidget(
              profileSize: 24,
              profile: "cat",
              bgSize: 48,
              bgColor: BlaColor.lightOrange,
            ),
            Text(
              "Bernardo",
              style: BlaTxt.txt12M.copyWith(color: BlaColor.grey800),
            )
          ]),
    );
  }

  Widget chartLabel(Color color, String keyword, int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 8),
            Text(
              keyword,
              style: BlaTxt.txt14M,
            )
          ],
        ),
        Text(
          "$count회",
          style: BlaTxt.txt14R.copyWith(color: BlaColor.grey700),
        ),
      ],
    );
  }
}
