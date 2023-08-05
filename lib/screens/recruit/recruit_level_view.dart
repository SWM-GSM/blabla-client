import 'package:blabla/screens/recruit/recruit_member_view.dart';
import 'package:blabla/screens/recruit/recruit_view_model.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:blabla/widgets/create_widget.dart';
import 'package:blabla/widgets/custom_slider_thumb_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecruitLevelView extends StatelessWidget {
  const RecruitLevelView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RecruitViewModel>(context);
    return Scaffold(
      body: SafeArea(
        child: CreateWidget(
            page: RecruitPage.langLv,
            title: "크루 참여 가능\n언어 레벨을 선택해주세요",
            widgets: viewModel.levels.isNotEmpty
                ? [
                    const SizedBox(height: 30),
                    levelDetail(context, "영어"),
                    const SizedBox(height: 40),
                    levelDetail(context, "한국어")
                  ]
                : []),
      ),
      bottomSheet: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RecruitMemberView()),
          );
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(
              20, 0, 20, 10 + MediaQuery.of(context).viewPadding.bottom),
          alignment: Alignment.center,
          height: 56,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: BlaColor.orange),
          child:
              Text("다음", style: BlaTxt.txt16B.copyWith(color: BlaColor.white)),
        ),
      ),
    );
  }

  Widget levelDetail(BuildContext context, String lang) {
    final viewModel = Provider.of<RecruitViewModel>(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("최소 $lang 레벨", style: BlaTxt.txt16M),
                const SizedBox(height: 4),
                Text(
                  lang == "영어"
                      ? viewModel.levels[viewModel.engLv - 1].desc
                      : viewModel.levels[viewModel.korLv - 1].desc,
                  style: BlaTxt.txt14R.copyWith(color: BlaColor.grey700),
                )
              ],
            ),
            Container(
              alignment: Alignment.center,
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                  color: BlaColor.lightOrange,
                  borderRadius: BorderRadius.circular(24)),
              child: Text(
                  "Lv. ${lang == "영어" ? viewModel.engLv : viewModel.korLv}",
                  style: BlaTxt.txt14BK.copyWith(color: BlaColor.orange)),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SliderTheme(
          data: SliderThemeData(
              trackHeight: 8,
              thumbShape: CustomSliderThumbWidget(),
              activeTrackColor: BlaColor.orange,
              activeTickMarkColor: BlaColor.white.withOpacity(0.3),
              inactiveTickMarkColor: BlaColor.grey300,
              overlayColor: BlaColor.black.withOpacity(0.16),
              overlayShape: SliderComponentShape.noThumb),
          child: Slider(
              inactiveColor: BlaColor.grey100,
              thumbColor: BlaColor.orange,
              value: lang == "영어"
                  ? viewModel.engLv.toDouble()
                  : viewModel.korLv.toDouble(),
              min: 1,
              max: 5,
              divisions: 4,
              onChanged: (value) {
                lang == "영어"
                    ? viewModel.setEngLv(value.toInt())
                    : viewModel.setKorLv(value.toInt());
              }),
        ),
      ],
    );
  }
}
