import 'package:blabla/models/interest.dart';
import 'package:blabla/screens/join/join_view_model.dart';
import 'package:blabla/screens/profile/profile_modify_desc_view.dart';
import 'package:blabla/screens/profile/profile_modify_main_view.dart';
import 'package:blabla/screens/profile/profile_modify_view_model.dart';
import 'package:blabla/screens/profile/profile_view_model.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:blabla/utils/datetime_to_str.dart';
import 'package:blabla/widgets/keyword_widget.dart';
import 'package:blabla/widgets/profile_widget.dart';
import 'package:blabla/widgets/skeleton_ui_widget.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ProfileMainView extends StatelessWidget {
  const ProfileMainView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProfileViewModel>(context);
    final modifyViewModel = Provider.of<ProfileModifyViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        backgroundColor: BlaColor.white,
        elevation: 0,
        title: Text(
          "마이페이지",
          style: BlaTxt.txt18B,
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              print("설정 버튼 클릭");
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
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "오늘도 블라블라해요!",
                        style: BlaTxt.txt16M.copyWith(color: BlaColor.orange),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      viewModel.user == null
                          ? SkeletonTxtWidget(
                              style: BlaTxt.txt24BKH, width: 120)
                          : Text(
                              viewModel.user!.nickname,
                              style: BlaTxt.txt24BKH,
                            ),
                      const SizedBox(
                        height: 4,
                      ),
                      viewModel.user == null
                          ? SkeletonTxtWidget(style: BlaTxt.txt12R, width: 120)
                          : Text(
                              "${datetimeToStr(viewModel.user!.birthDate, StrDatetimeType.dotDelOnlyDate)} | ${Gender.getByStr(viewModel.user!.gender).emoji} ${Gender.getByStr(viewModel.user!.gender).kr}",
                              style: BlaTxt.txt12R
                                  .copyWith(color: BlaColor.grey700),
                            ),
                    ],
                  ),
                  viewModel.user == null
                      ? SkeletonBoxWidget(
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: BlaColor.grey100,
                            ),
                          ),
                        )
                      : ProfileWidget(
                          profileSize: 48,
                          profile: viewModel.user!.profileImage,
                          bgSize: 80,
                          bgColor: BlaColor.lightOrange,
                        )
                ],
              ),
              GestureDetector(
                onTap: () {
                  if (viewModel.user != null) {
                    modifyViewModel.init(
                        viewModel.user!.profileImage,
                        viewModel.user!.nickname,
                        datetimeToStr(viewModel.user!.birthDate,
                            StrDatetimeType.dotDelOnlyDate),
                        viewModel.user!.gender,
                        viewModel.user!.countryCode,
                        viewModel.user!.korLevel,
                        viewModel.user!.engLevel);
                    Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(
                            builder: (context) =>
                                const ProfileModifyMainView()));
                  }
                },
                child: Container(
                  height: 48,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: BlaColor.grey100,
                  ),
                  child: Text(
                    "프로필 수정",
                    style: BlaTxt.txt14M.copyWith(color: BlaColor.grey800),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    infoCol(
                        viewModel.user == null
                            ? ""
                            : "Lv. ${viewModel.user!.korLevel}",
                        "한국어 스킬",
                        isSkeleton: viewModel.user == null),
                    Container(width: 1, height: 20, color: BlaColor.grey200),
                    infoCol(
                        viewModel.user == null
                            ? ""
                            : "Lv. ${viewModel.user!.engLevel}",
                        "영어 스킬",
                        isSkeleton: viewModel.user == null),
                    Container(width: 1, height: 20, color: BlaColor.grey200),
                    infoCol(
                        viewModel.user == null
                            ? ""
                            : "${viewModel.user!.signedUpAfter}일",
                        "가입한지",
                        isSkeleton: viewModel.user == null),
                    Container(width: 1, height: 20, color: BlaColor.grey200),
                    infoCol(
                        viewModel.user == null
                            ? ""
                            : viewModel.user!.countryCode.toUpperCase(),
                        "국적",
                        isSkeleton: viewModel.user == null,
                        isCountry: true)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "자기소개",
                          style: BlaTxt.txt20B,
                        ),
                        GestureDetector(
                          onTap: () {
                            modifyViewModel
                                .initDescription(viewModel.user!.description);
                            Navigator.of(context, rootNavigator: true).push(
                                MaterialPageRoute(
                                    builder: (context) => ProfileModifyDescView(
                                        initDesc:
                                            viewModel.user!.description)));
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "수정하기",
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
                    const SizedBox(
                      height: 8,
                    ),
                    viewModel.user == null
                        ? Column(
                            children: List.generate(
                            3,
                            (idx) => SkeletonTxtWidget(
                                style: BlaTxt.txt14R,
                                width: MediaQuery.of(context).size.width - 40),
                          ))
                        : viewModel.user!.description == ""
                            ? Container(
                                height: 56,
                                alignment: Alignment.center,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("😋", style: BlaTxt.txt20BL),
                                      const SizedBox(height: 8),
                                      Text(
                                        "아직 등록된 자기소개가 없어요!",
                                        style: BlaTxt.txt14R
                                            .copyWith(color: BlaColor.grey800),
                                      )
                                    ]),
                              )
                            : Text(
                                viewModel.user!.description,
                                style: BlaTxt.txt14R.copyWith(
                                    color: BlaColor.grey800,
                                    overflow: TextOverflow.visible),
                                softWrap: true,
                              )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "관심사",
                          style: BlaTxt.txt20B,
                        ),
                        GestureDetector(
                          onTap: () {
                            print("관심사 수정하기");
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "수정하기",
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
                    const SizedBox(
                      height: 8,
                    ),
                    viewModel.user == null
                        ? Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: List.generate(
                                6,
                                (index) => SkeletonBoxWidget(
                                        child: Container(
                                      width:
                                          (MediaQuery.of(context).size.width -
                                                  57) /
                                              3,
                                      height: 36,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(18),
                                        color: BlaColor.grey100,
                                      ),
                                    ))))
                        : Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: List.generate(
                                viewModel.user!.keywords.length,
                                (idx) => KeywordWidget(
                                    keyword: Keyword(
                                        emoji:
                                            viewModel.user!.keywords[idx].emoji,
                                        name:
                                            viewModel.user!.keywords[idx].name,
                                        tag: viewModel.user!.keywords[idx].tag),
                                    selected: false)),
                          )
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Widget infoCol(String content, String category,
      {bool isCountry = false, bool isSkeleton = false}) {
    return SizedBox(
      width: 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isSkeleton
              ? SkeletonTxtWidget(
                  style: BlaTxt.txt20B,
                  width: 60,
                )
              : isCountry
                  ? CountryFlag.fromCountryCode(
                      content,
                      width: 24,
                      height: 24,
                    )
                  : Text(
                      content,
                      style: BlaTxt.txt20B,
                    ),
          const SizedBox(
            height: 8,
          ),
          Text(
            category,
            style: BlaTxt.txt12R.copyWith(color: BlaColor.grey700),
          ),
        ],
      ),
    );
  }
}
