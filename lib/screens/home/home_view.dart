import 'package:blabla/models/crew.dart';
import 'package:blabla/screens/home/crew_list_view.dart';
import 'package:blabla/screens/home/home_view_model.dart';
import 'package:blabla/screens/home/widget/crew_tile_widget.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:blabla/widgets/level_widget.dart';
import 'package:blabla/widgets/skeleton_ui_widget.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Row(
                  children: [
                    viewModel.isLoading
                        ? SkeletonBoxWidget(
                          child: Container(
                              height: 72,
                              width: 72,
                              margin: const EdgeInsets.fromLTRB(8, 0, 24, 0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(36),
                                  color: BlaColor.black),
                            ),
                        )
                        : Container(
                            height: 72,
                            width: 72,
                            margin: const EdgeInsets.fromLTRB(8, 0, 24, 0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(36),
                              color: BlaColor.lightOrange,
                            ),
                            child: Image.asset(
                                "assets/imgs/img_120_profile_cat.png",
                                width: 48,
                                height: 48),
                          ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        viewModel.isLoading
                            ? SkeletonTxtWidget(
                                style: BlaTxt.txt12R, width: 80)
                            : Text(
                                "블라블라 ${viewModel.user!.signedUpAfter}일째",
                                style: BlaTxt.txt12M
                                    .copyWith(color: BlaColor.orange),
                              ),
                        const SizedBox(height: 4),
                        viewModel.isLoading
                            ? SkeletonTxtWidget(
                                style: BlaTxt.txt24BK, width: 120)
                            : Text(
                                viewModel.user!.nickname,
                                style: BlaTxt.txt24BK,
                              ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            LevelWidget(
                                lang: "KR",
                                level: viewModel.isLoading
                                    ? null
                                    : viewModel.user!.korLevel),
                            const SizedBox(
                              width: 8,
                            ),
                            LevelWidget(
                                lang: "EN",
                                level: viewModel.isLoading
                                    ? null
                                    : viewModel.user!.engLevel),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              crewList(context, viewModel.myCrewList, "나의 크루", () {
                print('zz');
              }),
              crewList(context, viewModel.nowCrewList, "지금 참여 가능한 크루", () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        settings: const RouteSettings(name: "/CrewListView"),
                        builder: (context) => CrewListView()));
              }),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("오늘의 컨텐츠", style: BlaTxt.txt20B),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 12),
                      child: AspectRatio(
                        aspectRatio: 350 / 180,
                        child: viewModel.isLoading
                            ? SkeletonBoxWidget(
                                child: Container(
                                decoration: BoxDecoration(
                                  color: BlaColor.black,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ))
                            : ExtendedImage.network(
                                viewModel.todayContent!.contentUrl,
                                fit: BoxFit.cover,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(12),
                              ),
                      ),
                    ),
                    viewModel.isLoading
                        ? SkeletonTxtWidget(
                            width: double.infinity, style: BlaTxt.txt12R)
                        : Text(
                            viewModel.todayContent!.title,
                            style:
                                BlaTxt.txt12R.copyWith(color: BlaColor.grey700),
                          ),
                    const SizedBox(height: 4),
                    viewModel.isLoading
                        ? SkeletonTxtWidget(
                            width: double.infinity, style: BlaTxt.txt12R)
                        : Text(
                            viewModel.todayContent!.topic,
                            style: BlaTxt.txt14SB,
                          ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget crewList(
    BuildContext context,
    List<CrewSimple> list,
    String title,
    onTap,
  ) {
    final viewModel = Provider.of<HomeViewModel>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(title, style: BlaTxt.txt20B),
                GestureDetector(
                  onTap: onTap,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "더보기",
                        style: BlaTxt.txt14ML.copyWith(color: BlaColor.grey600),
                      ),
                      SvgPicture.asset("assets/icons/ic_16_arrow_right.svg",
                          width: 16, height: 16)
                    ],
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.only(right: 20),
            scrollDirection: Axis.horizontal,
            child: Row(
                children: viewModel.isLoading
                    ? List.generate(5,
                        (index) => const CrewTileWidget(name: null, img: null))
                    : list
                        .map(
                          (e) => CrewTileWidget(name: e.name, img: e.coverUrl),
                        )
                        .toList()),
          ),
        ],
      ),
    );
  }
}
