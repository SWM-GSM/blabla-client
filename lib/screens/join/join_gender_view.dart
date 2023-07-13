import 'package:blabla/screens/join/join_country_view.dart';
import 'package:blabla/screens/join/join_view_model.dart';
import 'package:blabla/screens/join/widgets/join_desc_widget.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JoinGenderView extends StatelessWidget {
  const JoinGenderView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<JoinViewModel>(context);
    return Scaffold(
      body: SafeArea(
        child: JoinDescWidget(
          page: JoinPage.gender,
          title: "사용자의 성별을\n입력해주세요",
          step: 0.5,
          widgets: [
            const SizedBox(height: 30),
            Row(
              children: List.generate(
                  3,
                  (idx) => Expanded(
                        child: GestureDetector(
                          onTap: () {
                            viewModel.setGender(Gender.values[idx].toString());
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: idx != 2 ? 10 : 0),
                            height: 52,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Gender.values[idx].toString() ==
                                        viewModel.gender
                                    ? BlaColor.lightOrange
                                    : BlaColor.grey100,
                                borderRadius: BorderRadius.circular(16)),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(Gender.values[idx].emoji,
                                      style: BlaTxt.txt24M),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    Gender.values[idx].kr,
                                    style: Gender.values[idx].toString() ==
                                            viewModel.gender
                                        ? BlaTxt.txt16B
                                            .copyWith(color: BlaColor.orange)
                                        : BlaTxt.txt16M
                                            .copyWith(color: BlaColor.grey800),
                                  )
                                ]),
                          ),
                        ),
                      )),
            )
          ],
        ),
      ),
      bottomSheet: GestureDetector(
        onTap: () {
          if (viewModel.gender.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => JoinCountryView()),
            );
          }
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(
              20, 0, 20, 10 + MediaQuery.of(context).viewPadding.bottom),
          alignment: Alignment.center,
          height: 56,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: viewModel.gender.isNotEmpty
                  ? BlaColor.orange
                  : BlaColor.grey400),
          child:
              Text("다음", style: BlaTxt.txt16B.copyWith(color: BlaColor.white)),
        ),
      ),
    );
  }
}
