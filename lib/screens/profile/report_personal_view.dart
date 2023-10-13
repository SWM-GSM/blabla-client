import 'package:blabla/screens/profile/profile_view_model.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ReportPersonalView extends StatelessWidget {
  const ReportPersonalView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProfileViewModel>(context);
    return WillPopScope(
      onWillPop: () async {
        viewModel.initPersonalReport();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 64,
          title: Text(
            "feedback".tr(),
            style: BlaTxt.txt18B,
          ),
          backgroundColor: BlaColor.white,
          elevation: 0,
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
              viewModel.initPersonalReport();
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
          actions: [
            Container(
              width: 64,
              color: Colors.transparent,
            ),
          ],
        ),
        body: viewModel.feedback == null
            ? Padding(
                padding: EdgeInsets.only(
                    bottom: 90 + MediaQuery.of(context).padding.bottom),
                child: const Center(
                    child: CircularProgressIndicator(
                  color: BlaColor.orange,
                )),
              )
            : Padding(
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
                                  "sentenceSimilarity".tr(),
                                  style: BlaTxt.txt20B,
                                ),
                                starScore(viewModel.feedback!.contextRating),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text("myTranslatedSentence".tr(),
                                style: BlaTxt.txt12R
                                    .copyWith(color: BlaColor.grey700)),
                            const SizedBox(height: 4),
                            Text(viewModel.feedback!.userSentence,
                                style: BlaTxt.txt16B
                                    .copyWith(overflow: TextOverflow.visible)),
                            const SizedBox(height: 16),
                            Text("correctSentence".tr(),
                                style: BlaTxt.txt12R
                                    .copyWith(color: BlaColor.grey700)),
                            const SizedBox(height: 4),
                            Text(viewModel.feedback!.targetSentence,
                                style: BlaTxt.txt16B
                                    .copyWith(overflow: TextOverflow.visible)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        viewModel.feedback!.longFeedback,
                        style: BlaTxt.txt14R.copyWith(
                            color: BlaColor.grey800,
                            overflow: TextOverflow.visible),
                      ),
                    ],
                  ),
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
