import 'package:blabla/screens/my_space/mys_content_speaking_view.dart';
import 'package:blabla/screens/my_space/mys_view_model.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class MysContentFeedbackView extends StatelessWidget {
  const MysContentFeedbackView({super.key});
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MysViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        title: Text(
          "아이스베어 - 시간 약속 정하기",
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
              width: 24,
              height: 24,
            ),
          ),
        ),
        leadingWidth: 64,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
            20, 0, 20, 90 + MediaQuery.of(context).padding.bottom),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: BlaColor.grey100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "문장 유사도",
                          style: BlaTxt.txt20B,
                        ),
                        starScore(viewModel.feedback!.starRating),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text("내가 영작한 문장",
                        style: BlaTxt.txt12R.copyWith(color: BlaColor.grey700)),
                    const SizedBox(height: 4),
                    Text(viewModel.feedback!.userAnswer,
                        style: BlaTxt.txt16B
                            .copyWith(overflow: TextOverflow.visible)),
                    const SizedBox(height: 16),
                    Text("정답 문장",
                        style: BlaTxt.txt12R.copyWith(color: BlaColor.grey700)),
                    const SizedBox(height: 4),
                    Text(viewModel.feedback!.answer,
                        style: BlaTxt.txt16B
                            .copyWith(overflow: TextOverflow.visible)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                viewModel.feedback!.longFeedback,
                style: BlaTxt.txt14R.copyWith(
                    color: BlaColor.grey800, overflow: TextOverflow.visible),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.fromLTRB(
            20, 12, 20, 12 + MediaQuery.of(context).padding.bottom),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: BlaColor.grey100, width: 1),
          ),
          color: BlaColor.white,
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MysContentSpeakingView(),
              ),
            );
          },
          child: Container(
            alignment: Alignment.center,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: BlaColor.orange,
            ),
            child: Text("계속하기",
                style: BlaTxt.txt16B.copyWith(color: BlaColor.white)),
          ),
        ),
      ),
    );
  }

  Widget starScore(int starNum) {
    return Wrap(
      children: [
        Wrap(
            spacing: 4,
            children: List.generate(
              starNum,
              (idx) => SvgPicture.asset("assets/icons/ic_24_star.svg",
                  width: 24,
                  height: 24,
                  colorFilter:
                      const ColorFilter.mode(BlaColor.yellow, BlendMode.srcIn)),
            )),
        if (starNum != 0) const SizedBox(width: 4),
        Wrap(
            spacing: 4,
            children: List.generate(
              3 - starNum,
              (idx) => SvgPicture.asset("assets/icons/ic_24_star.svg",
                  width: 24,
                  height: 24,
                  colorFilter: const ColorFilter.mode(
                      BlaColor.grey500, BlendMode.srcIn)),
            )),
      ],
    );
  }
}
