import 'package:blabla/screens/profile/profile_view_model.dart';
import 'package:blabla/screens/profile/widgets/report_feedback_widget.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:blabla/utils/datetime_to_str.dart';
import 'package:blabla/widgets/profile_width_name_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ReportCrewView extends StatelessWidget {
  const ReportCrewView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProfileViewModel>(context);
    final bubbleColors = [
      BlaColor.coral500,
      BlaColor.coral400,
      BlaColor.coral300,
      BlaColor.coral200,
      BlaColor.coral100
    ];

    return WillPopScope(
      onWillPop: () async {
        viewModel.initCrewReport();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 64,
          title: Text(
            "crewReport".tr(),
            style: BlaTxt.txt18B,
          ),
          backgroundColor: BlaColor.white,
          elevation: 0,
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              viewModel.initCrewReport();
              Navigator.pop(context);
            },
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SvgPicture.asset(
                  "assets/icons/ic_32_arrow_left.svg",
                  width: 24,
                  height: 24,
                  colorFilter:
                      const ColorFilter.mode(BlaColor.black, BlendMode.srcIn),
                )),
          ),
          leadingWidth: 64,
        ),
        body: viewModel.report == null
            ? const Center(
                child: CircularProgressIndicator(
                color: BlaColor.orange,
              ))
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "basicInfo".tr(),
                              style: BlaTxt.txt20B,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "creationTime".tr(),
                                  style: BlaTxt.txt14M
                                      .copyWith(color: BlaColor.grey700),
                                ),
                                Text(
                                  datetimeToStr(viewModel.report!.createdAt,
                                      StrDatetimeType.dotDelimiter),
                                  style: BlaTxt.txt16SB,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "timeTaken".tr(),
                                  style: BlaTxt.txt14M
                                      .copyWith(color: BlaColor.grey700),
                                ),
                                Text(
                                  viewModel.report!.durationTime,
                                  style: BlaTxt.txt16SB,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "participants".tr(),
                                  style: BlaTxt.txt20B,
                                ),
                                Text(
                                  " ${viewModel.report!.members.length}${"members".tr()}",
                                  style: BlaTxt.txt20R
                                      .copyWith(color: BlaColor.grey700),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Wrap(
                                runSpacing: 20,
                                children: List.generate(
                                    viewModel.report!.members.length,
                                    (idx) => ProfileWidthNameWidget(
                                        member:
                                            viewModel.report!.members[idx]))),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "keyKeywords".tr(),
                              style: BlaTxt.txt20B,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 40),
                                child: ExtendedImage.network(
                                  viewModel.report!.bubbleChart,
                                  width: 284,
                                ),
                              ),
                            ),
                            Column(
                                children: List.generate(
                              viewModel.report!.words.length,
                              (idx) => Column(
                                children: [
                                  chartLabel(
                                      bubbleColors[idx],
                                      viewModel.report!.words[idx].name,
                                      viewModel.report!.words[idx].count),
                                  if (idx - 1 != viewModel.report!.words.length)
                                    const SizedBox(
                                      height: 16,
                                    )
                                ],
                              ),
                            ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "languageUsageRatio".tr(),
                              style: BlaTxt.txt20B,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              viewModel.report!.korRatio >
                                      viewModel.report!.engRatio
                                  ? "usesKoreanMore".tr()
                                  : "usesEnglishMore".tr(),
                              style: BlaTxt.txt12R
                                  .copyWith(color: BlaColor.grey700),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            if (viewModel.report!.korRatio == 100 ||
                                viewModel.report!.engRatio == 100)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 24,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: viewModel.report!.korRatio >
                                              viewModel.report!.engRatio
                                          ? BlaColor.orange
                                          : BlaColor.green,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 8,
                                        height: 8,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: viewModel.report!.korRatio >
                                                  viewModel.report!.engRatio
                                              ? BlaColor.orange
                                              : BlaColor.green,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        viewModel.report!.korRatio >
                                                viewModel.report!.engRatio
                                            ? "korean".tr()
                                            : "english".tr(),
                                        style: BlaTxt.txt12R
                                            .copyWith(color: BlaColor.grey800),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    viewModel.report!.korRatio >
                                            viewModel.report!.engRatio
                                        ? "${viewModel.report!.korRatio}%"
                                        : "${viewModel.report!.engRatio}%",
                                    style: BlaTxt.txt14B,
                                  ),
                                ],
                              )
                            else
                              Row(
                                children: [
                                  Flexible(
                                      flex: viewModel.report!.korRatio.toInt(),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 24,
                                            decoration: const BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.horizontal(
                                                        left:
                                                            Radius.circular(12),
                                                        right:
                                                            Radius.circular(4)),
                                                color: BlaColor.orange),
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 8,
                                                height: 8,
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: BlaColor.orange),
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              Text(
                                                "korean".tr(),
                                                style: BlaTxt.txt12R.copyWith(
                                                    color: BlaColor.grey800),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            "${viewModel.report!.korRatio}%",
                                            style: BlaTxt.txt14B,
                                          ),
                                        ],
                                      )),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Flexible(
                                    flex: viewModel.report!.engRatio.toInt(),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 24,
                                          decoration: const BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.horizontal(
                                                      left: Radius.circular(4),
                                                      right:
                                                          Radius.circular(12)),
                                              color: BlaColor.green),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 8,
                                              height: 8,
                                              decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: BlaColor.green),
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              "english".tr(),
                                              style: BlaTxt.txt12R.copyWith(
                                                  color: BlaColor.grey800),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          "${viewModel.report!.engRatio}%",
                                          style: BlaTxt.txt14B,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "crewMemberFeedback".tr(),
                                  style: BlaTxt.txt20B,
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                viewModel.report!.feedbacks.isEmpty
                                    ? SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Column(
                                          children: [
                                            Text(
                                              "👻",
                                              style: BlaTxt.txt20BL,
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              "noFeedback".tr(),
                                              style: BlaTxt.txt14R.copyWith(
                                                  color: BlaColor.grey800),
                                            )
                                          ],
                                        ),
                                      )
                                    : Column(
                                        children: List.generate(
                                          viewModel.report!.feedbacks.length,
                                          (idx) => ReportFeedbackWidget(
                                              feedback: viewModel
                                                  .report!.feedbacks[idx]),
                                        ),
                                      )
                              ])),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget chartLabel(Color color, String keyword, int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 8),
            Text(
              keyword,
              style: BlaTxt.txt14M,
            )
          ],
        ),
        Text(
          "$count${"times".tr()}",
          style: BlaTxt.txt14R.copyWith(color: BlaColor.grey700),
        ),
      ],
    );
  }
}
