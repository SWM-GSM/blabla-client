import 'package:blabla/screens/home/crew_detail_view.dart';
import 'package:blabla/screens/home/crew_view_model.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:blabla/widgets/skeleton_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

enum CrewTileType { home, list }

class CrewTileWidget extends StatelessWidget {
  const CrewTileWidget({super.key, required this.crew, required this.tileType});
  final dynamic crew;
  final CrewTileType tileType;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CrewViewModel>(context);
    if (tileType == CrewTileType.home) {
      return GestureDetector(
        onTap: () async {
          if (crew != null) {
            await viewModel.getCrewDetail(crew.id).then((value) =>
                Navigator.of(context, rootNavigator: true)
                    .push(MaterialPageRoute(
                        builder: (context) => CrewDetailView(
                              imgWidth: MediaQuery.of(context).size.width,
                            ))));
          }
        },
        child: Container(
          margin: const EdgeInsets.only(left: 20),
          width: 140,
          child: Column(
            children: [
              crew == null
                  ? SkeletonBoxWidget(
                      child: Container(
                        width: 140,
                        height: 110,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: BlaColor.black),
                      ),
                    )
                  : Container(
                      width: 140,
                      height: 110,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: AssetImage(
                                "assets/imgs/img_360_crew_${crew.coverImage}.png"),
                            fit: BoxFit.cover,
                          )),
                    ),
              const SizedBox(height: 8),
              crew == null
                  ? Column(
                      children: [
                        SkeletonTxtWidget(style: BlaTxt.txt14R, width: 140),
                        SkeletonTxtWidget(style: BlaTxt.txt14R, width: 140),
                      ],
                    )
                  : Text(
                      crew.name!,
                      style: BlaTxt.txt14R,
                      maxLines: 2,
                    ),
            ],
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () async {
          if (crew != null) {
            await viewModel.getCrewDetail(crew.id).then((value) =>
                Navigator.of(context, rootNavigator: true)
                    .push(MaterialPageRoute(
                        builder: (context) => CrewDetailView(
                              imgWidth: MediaQuery.of(context).size.width,
                            ))));
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          child: Row(
            children: [
              crew == null
                  ? Expanded(
                      child: Row(
                        children: [
                          SkeletonBoxWidget(
                            child: Container(
                              width: 96,
                              height: 96,
                              margin: const EdgeInsets.only(right: 16),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: BlaColor.black),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(children: [
                                  SkeletonBoxWidget(
                                    child: Container(
                                      width: 60,
                                      height: 24,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          color: BlaColor.black),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  SkeletonBoxWidget(
                                    child: Container(
                                      width: 60,
                                      height: 24,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          color: BlaColor.black),
                                    ),
                                  ),
                                ]),
                                Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: SkeletonTxtWidget(
                                        style: BlaTxt.txt16M, width: 200)),
                                SkeletonTxtWidget(
                                    style: BlaTxt.txt12R, width: 100),
                                const SizedBox(
                                  height: 4,
                                ),
                                SkeletonTxtWidget(
                                    style: BlaTxt.txt12R,
                                    width: double.infinity),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  : Expanded(
                      child: Row(
                        children: [
                          Container(
                            width: 96,
                            height: 96,
                            margin: const EdgeInsets.only(right: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/imgs/img_360_crew_${crew.coverImage}.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                      children: (crew.tags as List)
                                          .map((e) => Container(
                                                margin: EdgeInsets.only(
                                                    right: crew.tags
                                                                .indexOf(e) ==
                                                            crew.tags.length - 1
                                                        ? 0
                                                        : 8),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4,
                                                        horizontal: 8),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14),
                                                    color:
                                                        BlaColor.lightOrange),
                                                child: Text(e,
                                                    style: BlaTxt.txt12M
                                                        .copyWith(
                                                            color: BlaColor
                                                                .grey800)),
                                              ))
                                          .toList()),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Text(
                                    crew.name,
                                    style: BlaTxt.txt16M,
                                  ),
                                ),
                                Text(
                                    "KR - Lv. ${crew.korLevel} · EN - Lv. ${crew.engLevel}",
                                    style: BlaTxt.txt12R
                                        .copyWith(color: BlaColor.grey700)),
                                const SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${crew.createdAt} ~",
                                      style: BlaTxt.txt12R
                                          .copyWith(color: BlaColor.grey700),
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          "assets/icons/ic_16_team.svg",
                                          width: 16,
                                          height: 16,
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          "${crew.currentNum} / ${crew.maxNum}",
                                          style: BlaTxt.txt12R
                                              .copyWith(color: BlaColor.orange),
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
            ],
          ),
        ),
      );
    }
  }
}
