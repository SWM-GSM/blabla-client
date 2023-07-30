import 'package:blabla/screens/join/join_view_model.dart';
import 'package:blabla/screens/profile/profile_modify_birthdate_view.dart';
import 'package:blabla/screens/profile/profile_modify_country_view.dart';
import 'package:blabla/screens/profile/profile_modify_gender_view.dart';
import 'package:blabla/screens/profile/profile_modify_nickname_view.dart';
import 'package:blabla/screens/profile/profile_modify_view_model.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:blabla/widgets/profile_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:country_code/country_code.dart';

class ProfileModifyMainView extends StatelessWidget {
  const ProfileModifyMainView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProfileModifyViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        title: Text(
          "프로필 수정",
          style: BlaTxt.txt18B,
        ),
        backgroundColor: BlaColor.white,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            viewModel.isProfileChanged()
                ? showCupertinoDialog(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                          title: Text(
                            "화면을 나가면\n변경사항이 저장되지 않습니다.\n나가시겠습니까?",
                            style: BlaTxt.txt14R,
                          ),
                          actions: [
                            CupertinoDialogAction(
                              child: Text(
                                "취소",
                                style: BlaTxt.txt14R,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            CupertinoDialogAction(
                              child: Text("나가기",
                                  style: BlaTxt.txt14R
                                      .copyWith(color: BlaColor.red)),
                              onPressed: () {
                                viewModel.revert();
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ))
                : Navigator.pop(context);
          },
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              ProfileWidget(
                profileSize: 72,
                profile: "cat",
                bgSize: 120,
                bgColor: BlaColor.lightOrange,
              ),
              Container(
                width: 104,
                alignment: Alignment.center,
                margin: const EdgeInsets.fromLTRB(0, 12, 0, 24),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: BlaColor.grey100),
                child: Text(
                  "이미지 수정",
                  style: BlaTxt.txt14SB.copyWith(color: BlaColor.grey800),
                ),
              ),
              Column(
                children: [
                  infoRow("닉네임", viewModel.tempNickname, () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileModifyNicknameView(
                                  initNick: viewModel.tempNickname,
                                )));
                  }),
                  infoRow("생년월일", viewModel.tempBirthdate, () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProfileModifyBirthdateView()));
                  }),
                  infoRow("성별",
                      "${Gender.getByStr(viewModel.tempGender).emoji} ${Gender.getByStr(viewModel.tempGender).kr}",
                      () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileModifyGenderView()));
                  }),
                  infoRow("국적", CountryCode.tryParse(viewModel.tempCountryCode)!.symbol, () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileModifyCountryView()));
                  }),
                  infoRow("한국어 스킬", "Lv. 1", () {
                    print("한국어 스킬 클릭!");
                  }),
                  infoRow("영어 스킬", "Lv. 2", () {
                    print("영어 스킬 클릭!");
                  }, div: false),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomSheet: GestureDetector(
        onTap: () {},
        child: Container(
          margin: EdgeInsets.fromLTRB(
              20, 0, 20, 10 + MediaQuery.of(context).viewPadding.bottom),
          alignment: Alignment.center,
          height: 56,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: BlaColor.orange),
          child:
              Text("저장", style: BlaTxt.txt16B.copyWith(color: BlaColor.white)),
        ),
      ),
    );
  }

  Widget infoRow(String category, String content, onTap, {bool div = true}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          border: div
              ? const Border(
                  bottom: BorderSide(
                    color: BlaColor.grey300,
                    width: 1,
                  ),
                )
              : null,
        ),
        child: Row(
          children: [
            SizedBox(
              width: 80,
              child: Text(category, style: BlaTxt.txt16B),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(child: Text(content, style: BlaTxt.txt16R)),
            SvgPicture.asset(
              "assets/icons/ic_16_arrow_right.svg",
              width: 20,
              height: 20,
              colorFilter:
                  const ColorFilter.mode(BlaColor.grey600, BlendMode.srcIn),
            ),
          ],
        ),
      ),
    );
  }
}
