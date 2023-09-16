import 'package:blabla/main.dart';
import 'package:blabla/screens/join/join_view_model.dart';
import 'package:blabla/widgets/create_widget.dart';
import 'package:blabla/screens/join/widgets/join_level_widget.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:provider/provider.dart';

class JoinLangView extends StatelessWidget {
  const JoinLangView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<JoinViewModel>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CreateWidget(
              page: JoinPage.lang,
              title: "배우고 싶은 언어를\n선택해주세요",
              widgets: [
                SizedBox(height: 22),
              ],
            ),
            GestureDetector(
              onTap: () {
                viewModel.setLang("ko");
              },
              child: JoinLangWidget(
                title: "한국어",
                desc: "한국어를 배우고 싶은 사용자입니다",
                selected: viewModel.lang == "ko" ? true : false,
              ),
            ),
            GestureDetector(
              onTap: () {
                viewModel.setLang("en");
              },
              child: JoinLangWidget(
                title: "영어",
                desc: "영어를 배우고 싶은 사용자입니다",
                selected: viewModel.lang == "en" ? true : false,
              ),
            ),
          ],
        ),
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
              showToast("회원가입에 실패했습니다. 다시 시도해주세요.");
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
          child:
              Text("블라블라 시작하기", style: BlaTxt.txt16B.copyWith(color: BlaColor.white)),
        ),
      ),
    );
  }
}
