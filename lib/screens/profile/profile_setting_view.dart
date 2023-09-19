import 'package:blabla/screens/profile/profile_setting_web_view.dart';
import 'package:blabla/screens/profile/profile_view_model.dart';
import 'package:blabla/services/login.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:blabla/utils/dotenv.dart';
import 'package:blabla/widgets/setting_box_widget.dart';
import 'package:blabla/widgets/setting_row_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:restart_app/restart_app.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileSettingView extends StatelessWidget {
  const ProfileSettingView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProfileViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        title: Text(
          "setting".tr(),
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
                  txt: "notification".tr(),
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
                    txt: "korean".tr(),
                    status: viewModel.lang == "ko",
                    onTap: () {
                      if (viewModel.lang != "ko") {
                        viewModel.setLang("ko");
                        showCupertinoDialog(
                            context: context,
                            builder: (context) => CupertinoAlertDialog(
                                  title: Text(
                                    "restartApp".tr(),
                                    style: BlaTxt.txt14R,
                                  ),
                                  actions: [
                                    CupertinoDialogAction(
                                      child: Text(
                                        "later".tr(),
                                        style: BlaTxt.txt14R,
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    CupertinoDialogAction(
                                      child: Text("restart".tr(),
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
                    txt: "english".tr(),
                    status: viewModel.lang == "en",
                    onTap: () {
                      if (viewModel.lang != "en") {
                        viewModel.setLang("en");
                        showCupertinoDialog(
                            context: context,
                            builder: (context) => CupertinoAlertDialog(
                                  title: Text(
                                    "restartApp".tr(),
                                    style: BlaTxt.txt14R,
                                  ),
                                  actions: [
                                    CupertinoDialogAction(
                                      child: Text(
                                        "later".tr(),
                                        style: BlaTxt.txt14R,
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    CupertinoDialogAction(
                                      child: Text("restart".tr(),
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
                title: "uiLanguage".tr(),
              ),
              const SizedBox(height: 24),
              SettingBoxWidget(
                widgets: [
                  SettingRowWidget(
                    type: SettingRowType.link,
                    txt: "termsOfUse".tr(),
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(
                              builder: (context) => ProfileSettingTermView(
                                  title: "termsOfUse".tr(),
                                  url: env["TERM_URL"])));
                    },
                  ),
                  SettingRowWidget(
                    type: SettingRowType.link,
                    txt: "privacyPolicy".tr(),
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(
                              builder: (context) => ProfileSettingTermView(
                                  title: "privacyPolicy".tr(),
                                  url: env["PRIVACY_URL"])));
                    },
                  ),
                  SettingRowWidget(
                      type: SettingRowType.link,
                      txt: "contactUs".tr(),
                      onTap: () async {
                        await launchUrl(Uri.parse(env["TALK_URL"]!));
                      })
                ],
              ),
              const SizedBox(height: 24),
              SettingBoxWidget(
                widgets: [
                  SettingRowWidget(
                    type: SettingRowType.btn,
                    txt: "logout".tr(),
                    onTap: () {
                      showCupertinoDialog(
                          context: context,
                          builder: (context) => CupertinoAlertDialog(
                                title: Text(
                                  "areYouLogout".tr(),
                                  style: BlaTxt.txt14R,
                                ),
                                actions: [
                                  CupertinoDialogAction(
                                    child: Text(
                                      "yes".tr(),
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
                                      Restart.restartApp(webOrigin: "/");
                                    },
                                  ),
                                  CupertinoDialogAction(
                                    child:
                                        Text("no".tr(), style: BlaTxt.txt14R),
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
                    txt: "quit".tr(),
                    txtColor: BlaColor.red,
                    onTap: () {
                      showCupertinoDialog(
                          context: context,
                          builder: (context) => CupertinoAlertDialog(
                                title: Text(
                                  "withdrawalWarning".tr(),
                                  style: BlaTxt.txt14R,
                                ),
                                actions: [
                                  CupertinoDialogAction(
                                    child: Text(
                                      "quit".tr(),
                                      style: BlaTxt.txt14R
                                          .copyWith(color: BlaColor.red),
                                    ),
                                    onPressed: () async {
                                      if (await viewModel.withdrawal()) {
                                        Restart.restartApp(webOrigin: "/");
                                      } else {
                                        showToast("failToWithdrawal".tr());
                                      }
                                    },
                                  ),
                                  CupertinoDialogAction(
                                    child: Text("cancel".tr(),
                                        style: BlaTxt.txt14R),
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
