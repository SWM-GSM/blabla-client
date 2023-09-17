import 'package:blabla/screens/onboarding.dart';
import 'package:blabla/screens/profile/profile_view_model.dart';
import 'package:blabla/services/login.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:blabla/widgets/setting_box_widget.dart';
import 'package:blabla/widgets/setting_row_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:restart_app/restart_app.dart';

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
              SettingBoxWidget(widgets: [
                SettingRowWidget(
                  type: SettingRowType.toggle,
                  txt: "알림",
                  status: viewModel.allowNotification!,
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
                    status: viewModel.lang == "ko",
                    onTap: () {
                      if (viewModel.lang != "ko") {
                        viewModel.setLang("ko");
                        showCupertinoDialog(
                            context: context,
                            builder: (context) => CupertinoAlertDialog(
                                  title: Text(
                                    "앱을 재시작해야\n설정 언어가 반영됩니다.\n바로 재시작 하시겠습니까?",
                                    style: BlaTxt.txt14R,
                                  ),
                                  actions: [
                                    CupertinoDialogAction(
                                      child: Text(
                                        "나중에",
                                        style: BlaTxt.txt14R,
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    CupertinoDialogAction(
                                      child: Text("재시작",
                                          style: BlaTxt.txt14R
                                              .copyWith(color: BlaColor.black)),
                                      onPressed: () {
                                        Restart.restartApp(webOrigin: "/");
                                      },
                                    ),
                                  ],
                                ));
                      }
                    },
                  ),
                  SettingRowWidget(
                    type: SettingRowType.radio,
                    txt: "영어",
                    status: viewModel.lang == "en",
                    onTap: () {
                      if (viewModel.lang != "en") {
                        viewModel.setLang("en");
                        showCupertinoDialog(
                            context: context,
                            builder: (context) => CupertinoAlertDialog(
                                  title: Text(
                                    "앱을 재시작해야\n설정 언어가 반영됩니다.\n바로 재시작 하시겠습니까?",
                                    style: BlaTxt.txt14R,
                                  ),
                                  actions: [
                                    CupertinoDialogAction(
                                      child: Text(
                                        "나중에",
                                        style: BlaTxt.txt14R,
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    CupertinoDialogAction(
                                      child: Text("재시작",
                                          style: BlaTxt.txt14R
                                              .copyWith(color: BlaColor.black)),
                                      onPressed: () {
                                        Restart.restartApp(webOrigin: "/");
                                      },
                                    ),
                                  ],
                                ));
                      }
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
                      showCupertinoDialog(
                          context: context,
                          builder: (context) => CupertinoAlertDialog(
                                title: Text(
                                  "로그아웃 하시곘습니까?",
                                  style: BlaTxt.txt14R,
                                ),
                                actions: [
                                  CupertinoDialogAction(
                                    child: Text(
                                      "예",
                                      style: BlaTxt.txt14R,
                                    ),
                                    onPressed: () async {
                                      const storage = FlutterSecureStorage();
                                      switch (
                                          await storage.read(key: "platform")) {
                                        case "GOOGLE":
                                          Login.google.service.logout();
                                        case "APPLE":
                                          Login.apple.service.logout();
                                      }
                                      await storage.deleteAll();
                                      if (context.mounted) {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const OnBoarding()),
                                            (route) => false);
                                      }
                                    },
                                  ),
                                  CupertinoDialogAction(
                                    child: Text("아니오", style: BlaTxt.txt14R),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ));
                    },
                  ),
                  SettingRowWidget(
                    type: SettingRowType.btn,
                    txt: "탈퇴하기",
                    txtColor: BlaColor.red,
                    onTap: () {
                      showCupertinoDialog(
                          context: context,
                          builder: (context) => CupertinoAlertDialog(
                                title: Text(
                                  "탈퇴하실 경우\n계정 정보가 모두 삭제 됩니다.\n탈퇴 하시겠습니까?",
                                  style: BlaTxt.txt14R,
                                ),
                                actions: [
                                  CupertinoDialogAction(
                                    child: Text(
                                      "탈퇴하기",
                                      style: BlaTxt.txt14R
                                          .copyWith(color: BlaColor.red),
                                    ),
                                    onPressed: () async {
                                      if (await viewModel.withdrawal()) {
                                        if (context.mounted) {
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const OnBoarding()),
                                              (route) => false);
                                        }
                                      } else {
                                        showToast("회원 탈퇴 실패. 다시 시도 해주세요");
                                      }
                                    },
                                  ),
                                  CupertinoDialogAction(
                                    child: Text("취소", style: BlaTxt.txt14R),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ));
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
