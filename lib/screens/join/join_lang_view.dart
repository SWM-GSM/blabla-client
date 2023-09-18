import 'package:blabla/main.dart';
import 'package:blabla/screens/join/join_view_model.dart';
import 'package:blabla/widgets/create_widget.dart';
import 'package:blabla/screens/join/widgets/join_level_widget.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:provider/provider.dart';

class JoinLangView extends StatelessWidget {
  const JoinLangView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<JoinViewModel>(context);
    return Scaffold(
      body: Column(
        children: [
          CreateWidget(
            page: JoinPage.lang,
            title: "languageWantToLearn".tr(),
            widgets: const [
              SizedBox(height: 22),
            ],
          ),
          GestureDetector(
            onTap: () {
              viewModel.setLang("ko");
            },
            child: JoinLangWidget(
              title: "korean".tr(),
              desc: "koreanUser".tr(),
              selected: viewModel.lang == "ko" ? true : false,
            ),
          ),
          GestureDetector(
            onTap: () {
              viewModel.setLang("en");
            },
            child: JoinLangWidget(
              title: "english".tr(),
              desc: "englishUser".tr(),
              selected: viewModel.lang == "en" ? true : false,
            ),
          ),
        ],
      ),
      bottomSheet: GestureDetector(
        onTap: () async {
          await viewModel.join().then((value) {
            if (value) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const Main()),
                  (route) => false);
            } else {
              showToast("failToJoin".tr());
            }
          });
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(
              20, 12, 20, 10 + MediaQuery.of(context).viewPadding.bottom),
          alignment: Alignment.center,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: () {
              if (viewModel.lang == null) {
                return BlaColor.grey400;
              } else {
                return BlaColor.orange;
              }
            }(),
          ),
          child: Text("startBlabla".tr(),
              style: BlaTxt.txt16B.copyWith(color: BlaColor.white)),
        ),
      ),
    );
  }
}
