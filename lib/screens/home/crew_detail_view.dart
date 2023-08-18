import 'package:blabla/screens/home/crew_view_model.dart';
import 'package:blabla/screens/home/widget/level_tile_widget.dart';
import 'package:blabla/screens/home/widget/member_tile_widget.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class CrewDetailView extends StatefulWidget {
  const CrewDetailView({super.key, required this.imgWidth});
  final double imgWidth;

  @override
  State<CrewDetailView> createState() => _CrewDetailViewState();
}

class _CrewDetailViewState extends State<CrewDetailView> {
  final _scrollCtr = ScrollController();
  bool _appBarCollapsed = false;

  @override
  void initState() {
    super.initState();
    _scrollCtr.addListener(() {
      setState(() {
        if (_scrollCtr.hasClients &&
            _scrollCtr.offset >
                (widget.imgWidth -
                    WidgetsBinding.instance.window.padding.top)) {
          _appBarCollapsed = true;
        } else {
          _appBarCollapsed = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CrewViewModel>(context);
    return Scaffold(
        body: NestedScrollView(
          controller: _scrollCtr,
          headerSliverBuilder: (context, bool isScrolled) {
            return [
              SliverAppBar(
                backgroundColor: BlaColor.white,
                expandedHeight:
                    widget.imgWidth - MediaQuery.of(context).padding.top,
                toolbarHeight: 64,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(children: [
                    Image.asset(
                      "assets/imgs/img_360_crew_${viewModel.crew!.coverImage}.png",
                      fit: BoxFit.cover,
                      width: widget.imgWidth,
                      height: widget.imgWidth,
                    ),
                    Container(
                      height: widget.imgWidth / 3,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                            BlaColor.black.withOpacity(0.4),
                            BlaColor.black.withOpacity(0),
                          ])),
                    ),
                  ]),
                ),
                collapsedHeight: 64,
                elevation: 0.1,
                leadingWidth: 64,
                leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 44,
                    height: 44,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: BlaColor.white.withOpacity(0.3)),
                    child: SvgPicture.asset(
                      "assets/icons/ic_32_arrow_left.svg",
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                          _appBarCollapsed ? BlaColor.black : BlaColor.white,
                          BlendMode.srcIn),
                    ),
                  ),
                ),
                actions: [
                  GestureDetector(
                    onTap: () {
                      print("더보기 버튼 클릭");
                    },
                    child: Container(
                      width: 44,
                      height: 44,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: BlaColor.white.withOpacity(0.3)),
                      child: SvgPicture.asset(
                        "assets/icons/ic_24_more.svg",
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                            (_appBarCollapsed
                                ? BlaColor.black
                                : BlaColor.white),
                            BlendMode.srcIn),
                      ),
                    ),
                  ),
                ],
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  20, 0, 20, 140 + MediaQuery.of(context).padding.bottom),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 12),
                    child: Text(
                      viewModel.crew!.name,
                      style: BlaTxt.txt28B,
                    ),
                  ),
                  Text(
                    viewModel.crew!.description,
                    style: BlaTxt.txt14R.copyWith(color: BlaColor.grey800),
                  ),
                  Row(
                      children: viewModel.crew!.tags
                          .map((e) => Container(
                                margin:
                                    const EdgeInsets.only(right: 8, top: 12),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: BlaColor.grey100,
                                ),
                                child: Text(
                                  e,
                                  style: BlaTxt.txt12M
                                      .copyWith(color: BlaColor.grey800),
                                ),
                              ))
                          .toList()),
                  const SizedBox(height: 40),
                  Text(
                    "멤버 소개",
                    style: BlaTxt.txt20B,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Column(
                      children: viewModel.crew!.members
                          .map((e) => MemberTileWidget(member: e))
                          .toList()),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    "세부 정보",
                    style: BlaTxt.txt20B,
                  ),
                  LevelTileWidget(
                    lang: "한국어",
                    level: viewModel.crew!.korLevel,
                  ),
                  LevelTileWidget(
                    lang: "영어",
                    level: viewModel.crew!.engLevel,
                  ),
                  qaColumn("어떤 크루원들과 함께하고 싶나요?", viewModel.crew!.preferMember),
                  qaColumn("얼마나 자주 모이고 싶나요?", viewModel.crew!.meetingCycle),
                  if (viewModel.crew!.detail != "")
                    qaColumn("크루에 대한 더 자세한 소개", viewModel.crew!.detail),
                ],
              ),
            ),
          ),
        ),
        bottomSheet: Container(
            alignment: Alignment.topCenter,
            height: (viewModel.crew!.status == "NOTHING" ? 120 : 80) +
                MediaQuery.of(context).padding.bottom,
            padding: EdgeInsets.fromLTRB(
                20, 11, 20, MediaQuery.of(context).padding.bottom),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: BlaColor.grey100, width: 1),
              ),
              color: BlaColor.white,
            ),
            child: Column(
              children: [
                if (viewModel.crew!.status == "NOTHING")
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: viewModel.crew!.autoApproval
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "선착순",
                                style: BlaTxt.txt16M
                                    .copyWith(color: BlaColor.grey800),
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/icons/ic_16_team.svg",
                                    width: 20,
                                    height: 20,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    viewModel.crew!.members.length.toString(),
                                    style: BlaTxt.txt16B
                                        .copyWith(color: BlaColor.orange),
                                  ),
                                  Text(
                                    " / ${viewModel.crew!.maxNum}",
                                    style: BlaTxt.txt16R
                                        .copyWith(color: BlaColor.grey700),
                                  ),
                                ],
                              )
                            ],
                          )
                        : Text(
                            "승인 후 크루 참여가 가능합니다",
                            style:
                                BlaTxt.txt14M.copyWith(color: BlaColor.grey700),
                          ),
                  ),
                if (viewModel.crew!.status == "NOTHING")
                  GestureDetector(
                    onTap: () async {
                      if (viewModel.crew!.autoApproval) {
                        await viewModel.joinCrew(viewModel.crew!.autoApproval);
                      } else {
                        // 수정 - 모달창으로 수정
                        await viewModel.joinCrew(viewModel.crew!.autoApproval,
                            msg: "");
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 56,
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: BlaColor.orange,
                      ),
                      child: Text(
                        "참여하기",
                        style: BlaTxt.txt16B.copyWith(color: BlaColor.white),
                      ),
                    ),
                  )
                else if (viewModel.crew!.status == "JOINED")
                  Container(
                    alignment: Alignment.center,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: BlaColor.grey200,
                    ),
                    child: Text(
                      "가입 완료",
                      style: BlaTxt.txt16B.copyWith(color: BlaColor.grey800),
                    ),
                  )
                else if (viewModel.crew!.status == "WAITING")
                  Container(
                    alignment: Alignment.center,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: BlaColor.lightOrange,
                    ),
                    child: Text(
                      "승인 대기",
                      style: BlaTxt.txt16B
                          .copyWith(color: BlaColor.semiLightOrange),
                    ),
                  )
                else
                  Container(
                    alignment: Alignment.center,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: BlaColor.grey200,
                    ),
                    child: Text(
                      "참여 불가",
                      style: BlaTxt.txt16B.copyWith(color: BlaColor.red),
                    ),
                  )
              ],
            )));
  }

  Widget qaColumn(String question, String answer) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question, style: BlaTxt.txt16B),
          const SizedBox(height: 8),
          Text(answer, style: BlaTxt.txt14R.copyWith(color: BlaColor.grey800)),
        ],
      ),
    );
  }
}
