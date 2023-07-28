import 'package:blabla/models/interest.dart';
import 'package:blabla/screens/profile/profile_modify_main_view.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:blabla/widgets/keyword_widget.dart';
import 'package:blabla/widgets/profile_widget.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileMainView extends StatelessWidget {
  const ProfileMainView({super.key});

  @override
  Widget build(BuildContext context) {
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
                      Text(
                        "버나드",
                        style: BlaTxt.txt24BKH,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        "2001.09.24 | 👩 여성",
                        style: BlaTxt.txt12R.copyWith(color: BlaColor.grey700),
                      ),
                    ],
                  ),
                  const ProfileWidget(
                    profileSize: 48,
                    profile: "cat",
                    bgSize: 80,
                    bgColor: BlaColor.lightOrange,
                  )
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                          builder: (context) => ProfileModifyMainView()));
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
                    infoCol("Lv. 1", "한국어 스킬"),
                    Container(width: 1, height: 20, color: BlaColor.grey200),
                    infoCol("Lv. 3", "영어 스킬"),
                    Container(width: 1, height: 20, color: BlaColor.grey200),
                    infoCol("7일", "가입한지"),
                    Container(width: 1, height: 20, color: BlaColor.grey200),
                    infoCol("KR", "국적", isCountry: true)
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
                            print("자기소개 수정하기");
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
                    Text(
                      "함께 개발 이야기 나누고 게임도 같이해요! \nHello Nice yo meet you!",
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
                    Wrap(
                      children: List.generate(
                          4,
                          (idx) => KeywordWidget(
                              keyword:
                                  Keyword(emoji: "🎙️", name: "악기 연주", tag: ""),
                              selected: false)),
                      spacing: 8,
                      runSpacing: 8,
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

  Widget infoCol(String content, String category, {bool isCountry = false}) {
    return SizedBox(
      width: 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isCountry
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
