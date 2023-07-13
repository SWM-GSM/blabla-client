import 'package:blabla/screens/join/join_view_model.dart';
import 'package:blabla/screens/join/widgets/join_desc_widget.dart';
import 'package:blabla/screens/join/widgets/join_interest_widget.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JoinInterestView extends StatelessWidget {
  const JoinInterestView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<JoinViewModel>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            JoinDescWidget(
              page: JoinPage.keyword,
              title: "블라블라에게\n당신을 알려주세요!",
              step: 0.125 * (JoinPage.keyword.index + 1),
              widgets: [
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      "관심 있는 키워드를 ",
                      style: BlaTxt.txt16R.copyWith(color: BlaColor.grey700),
                    ),
                    Text(
                      "3개 이상",
                      style: BlaTxt.txt16B.copyWith(color: BlaColor.orange),
                    ),
                    Text(
                      " 선택해주세요",
                      style: BlaTxt.txt16R.copyWith(color: BlaColor.grey700),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: viewModel.interests.length,
                itemBuilder: (context, idx) =>
                    JoinInterestWidget(interest: viewModel.interests[idx]),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        margin: EdgeInsets.fromLTRB(
            20, 10, 20, 10 + MediaQuery.of(context).viewPadding.bottom),
        child: Row(children: [
          Expanded(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: BlaColor.grey100,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "건너뛰기",
                    style: BlaTxt.txt16R.copyWith(color: BlaColor.grey800),
                  )),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: viewModel.keywords.length >= 3
                        ? BlaColor.orange
                        : BlaColor.grey400,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "완료",
                    style: BlaTxt.txt16B.copyWith(color: BlaColor.white),
                  )),
            ),
          ),
        ]),
      ),
    );
  }
}
