import 'package:blabla/screens/profile/profile_view_model.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:blabla/widgets/setting_box_widget.dart';
import 'package:blabla/widgets/setting_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ProfileSettingView extends StatelessWidget {
  const ProfileSettingView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProfileViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        title: Text(
          "설정",
          style: BlaTxt.txt18B,
        ),
        backgroundColor: BlaColor.white,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SvgPicture.asset(
                "assets/icons/ic_32_arrow_left.svg",
                width: 20,
                height: 20,
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
              SettingBoxWidget(
                widgets: [
                  SettingRowWidget(
                    type: SettingRowType.toggle,
                    txt: "성별",
                    status: viewModel.openGender,
                    onTap: () {
                      viewModel.changeOpenGender();
                    },
                  ),
                  SettingRowWidget(
                    type: SettingRowType.toggle,
                    txt: "생년월일",
                    status: viewModel.openBirthdate,
                    onTap: () {
                      viewModel.changeOpenBirthdate();
                    },
                  ),
                ],
                title: "프로필 공개",
              ),
              const SizedBox(height: 24),
              SettingBoxWidget(widgets: [
                SettingRowWidget(
                  type: SettingRowType.toggle,
                  txt: "알림",
                  status: viewModel.allowNotification,
                  onTap: () {
                    viewModel.changePushNotification();
                  },
                ),
              ]),
              const SizedBox(height: 24),
              SettingBoxWidget(
                widgets: [
                  SettingRowWidget(
                    type: SettingRowType.radio,
                    txt: "한국어",
                    status: true,
                    onTap: () {
                      print("테스트");
                    },
                  ),
                  SettingRowWidget(
                    type: SettingRowType.radio,
                    txt: "영어",
                    status: true,
                    onTap: () {
                      print("테스트");
                    },
                  ),
                ],
                title: "UI 언어",
              ),
              const SizedBox(height: 24),
              SettingBoxWidget(
                widgets: [
                  SettingRowWidget(
                    type: SettingRowType.link,
                    txt: "이용약관",
                    onTap: () {
                      print("테스트");
                    },
                  ),
                  SettingRowWidget(
                    type: SettingRowType.link,
                    txt: "개인정보처리방침",
                    onTap: () {
                      print("테스트");
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SettingBoxWidget(
                widgets: [
                  SettingRowWidget(
                    type: SettingRowType.btn,
                    txt: "로그아웃",
                    onTap: () {
                      print("테스트");
                    },
                  ),
                  SettingRowWidget(
                    type: SettingRowType.btn,
                    txt: "탈퇴하기",
                    txtColor: BlaColor.red,
                    onTap: () {
                      print("테스트");
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
