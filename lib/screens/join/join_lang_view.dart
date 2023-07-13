import 'package:blabla/models/level.dart';
import 'package:blabla/screens/join/join_interest_view.dart';
import 'package:blabla/screens/join/join_view_model.dart';
import 'package:blabla/screens/join/widgets/join_desc_widget.dart';
import 'package:blabla/screens/join/widgets/join_level_widget.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JoinLangView extends StatelessWidget {
  const JoinLangView({super.key, required this.lang});
  final String lang;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<JoinViewModel>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            JoinDescWidget(
              page: lang == "eng" ? JoinPage.engLv : JoinPage.korLv,
              title: "${viewModel.nickname}님의",
              step: 0.125 *
                  (lang == "eng"
                      ? JoinPage.engLv.index + 1
                      : (JoinPage.korLv.index + 1)),
              widgets: [
                Text("${lang == "eng" ? "영어" : "한국어"} 스피킹 레벨",
                    style: BlaTxt.txt28B.copyWith(color: BlaColor.orange)),
                Text(
                  "어디쯤이라고 생각하시나요?",
                  style: BlaTxt.txt28R,
                ),
                const SizedBox(height: 22),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: viewModel.levels.length,
                itemBuilder: (context, idx) => GestureDetector(
                  onTap: () {
                    if (lang == "eng") {
                      viewModel.setEngLangLevel(viewModel.levels[idx].degree);
                    } else {
                      viewModel.setKorLangLevel(viewModel.levels[idx].degree);
                    }
                  },
                  child: JoinLevelWidget(
                      degree: viewModel.levels[idx].degree,
                      desc: viewModel.levels[idx].desc,
                      selected: (() {
                        if (lang == "eng") {
                          return viewModel.engLangLevel == viewModel.levels[idx].degree
                              ? true
                              : false;
                        } else {
                          return viewModel.korLangLevel == viewModel.levels[idx].degree
                              ? true
                              : false;
                        }
                      })()),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: GestureDetector(
        onTap: () {
          if (lang == "eng") {
            if (viewModel.engLangLevel != 0) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => JoinLangView(lang: "kor")),
              );
            }
          } else {
            if (viewModel.korLangLevel != 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => JoinInterestView()),
              );
            }
          }
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(
              20, 10, 20, 10 + MediaQuery.of(context).viewPadding.bottom),
          alignment: Alignment.center,
          height: 56,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: viewModel.countryCode.isNotEmpty // 수정
                  ? BlaColor.orange
                  : BlaColor.grey400),
          child:
              Text("다음", style: BlaTxt.txt16B.copyWith(color: BlaColor.white)),
        ),
      ),
    );
  }
}
