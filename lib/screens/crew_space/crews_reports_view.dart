import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:blabla/widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CrewsReportsView extends StatelessWidget {
  const CrewsReportsView({super.key});

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
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: BlaColor.grey200, width: 1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Wrap(
                      spacing: 4,
                      direction: Axis.horizontal,
                      children: [
                        Text(
                          "기간",
                          style:
                              BlaTxt.txt14M.copyWith(color: BlaColor.grey700),
                        ),
                        SvgPicture.asset("assets/icons/ic_24_arrow_down.svg",
                            width: 20,
                            height: 20,
                            colorFilter: const ColorFilter.mode(
                                BlaColor.grey800, BlendMode.srcIn))
                      ],
                    ),
                  ),
                  Wrap(
                    spacing: 8,
                    direction: Axis.horizontal,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/ic_20_sort.svg",
                        width: 20,
                        height: 20,
                      ),
                      Text(
                        "최신순",
                        style: BlaTxt.txt14M.copyWith(color: BlaColor.grey700),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 2),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
                decoration: BoxDecoration(
                  color: BlaColor.grey100,
                  borderRadius: BorderRadius.circular(12),
                ),
                height: 168,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      direction: Axis.horizontal,
                      children: [
                        Text(
                          "Bernardo",
                          style: BlaTxt.txt16B,
                        ),
                        Text(
                          " 외 7명",
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
                                10,
                                (index) => const ProfileWidget(
                                    profileSize: 24,
                                    profile: "cat",
                                    bgSize: 48))),
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
                                "2021.08.01 12:00",
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
                                "00:23:40",
                                style: BlaTxt.txt12M,
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        )));
  }
}
