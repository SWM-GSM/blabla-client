import 'package:blabla/screens/profile/profile_modify_view.dart';
import 'package:blabla/screens/profile/profile_modify_view_model.dart';
import 'package:blabla/screens/profile/profile_setting_view.dart';
import 'package:blabla/screens/profile/profile_view_model.dart';
import 'package:blabla/screens/profile/report_crew_view.dart';
import 'package:blabla/screens/profile/report_personal_view.dart';
import 'package:blabla/screens/profile/widgets/profile_history_tile.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:blabla/widgets/profile_widget.dart';
import 'package:blabla/widgets/skeleton_ui_widget.dart';
import 'package:country_flags/country_flags.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ProfileMainView extends StatelessWidget {
  const ProfileMainView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProfileViewModel>(context);
    final modifyViewModel = Provider.of<ProfileModifyViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        backgroundColor: BlaColor.white,
        elevation: 0,
        title: Text(
          "myPage".tr(),
          style: BlaTxt.txt18B,
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              if (viewModel.user != null &&
                  viewModel.allowNotification != null &&
                  viewModel.lang != null) {
                Navigator.of(context, rootNavigator: true).push(
                    MaterialPageRoute(
                        builder: (context) => const ProfileSettingView()));
              } else {
                showToast("tryLater".tr());
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SvgPicture.asset(
                "assets/icons/ic_24_setting.svg",
                width: 24,
                height: 24,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "keepBlablaing".tr(),
                        style: BlaTxt.txt16M.copyWith(color: BlaColor.orange),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      viewModel.user == null
                          ? SkeletonTxtWidget(
                              style: BlaTxt.txt24BKH, width: 120)
                          : Text(
                              viewModel.user!.nickname,
                              style: BlaTxt.txt24BKH,
                            ),
                      const SizedBox(height: 8),
                      viewModel.user == null
                          ? SkeletonBoxWidget(
                              child: Container(
                              width: 100,
                              height: 24,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: BlaColor.grey100),
                            ))
                          : Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              decoration: BoxDecoration(
                                color: BlaColor.lightOrange,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                viewModel.user!.language == "ko"
                                    ? "learningKorean".tr()
                                    : "learningEnglish".tr(),
                                style: BlaTxt.txt12M
                                    .copyWith(color: BlaColor.orange),
                              ),
                            )
                    ],
                  ),
                  viewModel.user == null
                      ? SkeletonBoxWidget(
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: BlaColor.grey100,
                            ),
                          ),
                        )
                      : Stack(
                          children: [
                            ProfileWidget(
                              profileSize: 48,
                              profile: viewModel.user!.profileImage,
                              bgSize: 80,
                              bgColor: BlaColor.lightOrange,
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: GestureDetector(
                                onTap: () {
                                  modifyViewModel.init(
                                      viewModel.user!.profileImage,
                                      viewModel.user!.nickname,
                                      viewModel.user!.language);
                                  Navigator.of(context, rootNavigator: true)
                                      .push(MaterialPageRoute(
                                          builder: (context) =>
                                              ProfileModifyView(
                                                  initNick: viewModel
                                                      .user!.nickname)));
                                },
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: BlaColor.orange,
                                    border: Border.all(
                                        color: BlaColor.white, width: 1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: SvgPicture.asset(
                                    "assets/icons/ic_12_edit.svg",
                                    width: 12,
                                    height: 12,
                                    colorFilter: const ColorFilter.mode(
                                        BlaColor.white, BlendMode.srcIn),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("history".tr(), style: BlaTxt.txt20B),
                  Wrap(
                    spacing: 12,
                    children: List.generate(
                      HistoryFilter.values.length,
                      (idx) => GestureDetector(
                        onTap: () {
                          viewModel.setHistoryFilter(HistoryFilter.values[idx]);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: viewModel.filter == HistoryFilter.values[idx]
                                ? BlaColor.lightOrange
                                : BlaColor.grey100,
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                    "assets/icons/ic_16_${HistoryFilter.values[idx].icon}.svg",
                                    width: 16,
                                    height: 16,
                                    colorFilter: ColorFilter.mode(
                                        viewModel.filter ==
                                                HistoryFilter.values[idx]
                                            ? BlaColor.orange
                                            : BlaColor.grey600,
                                        BlendMode.srcIn)),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  HistoryFilter.values[idx].tag,
                                  style: viewModel.filter ==
                                          HistoryFilter.values[idx]
                                      ? BlaTxt.txt12B
                                          .copyWith(color: BlaColor.orange)
                                      : BlaTxt.txt12M
                                          .copyWith(color: BlaColor.grey600),
                                )
                              ]),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              viewModel.histories.isEmpty
                  ? Container(
                      padding: const EdgeInsets.symmetric(vertical: 80),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "🥺",
                            style: TextStyle(
                              fontSize: 44,
                              fontWeight: FontWeight.bold,
                              color: BlaColor.grey900,
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            "${"noHistory".tr()}\n${"withSpace".tr(args: [
                                  viewModel.filter == HistoryFilter.personal
                                      ? "mySpace".tr()
                                      : "crewSpace".tr()
                                ])}\n${"createHistory".tr()}",
                            style:
                                BlaTxt.txt14R.copyWith(color: BlaColor.grey800),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : Column(
                      children: List.generate(
                        viewModel.histories.length,
                        (calendarIdx) => Column(
                            children: List.generate(
                                viewModel.histories[calendarIdx].reports.length,
                                (idx) => Row(
                                      children: [
                                        if (idx == 0)
                                          SizedBox(
                                            width: 30,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "${viewModel.histories[calendarIdx].datetime.month}월",
                                                  style: BlaTxt.txt12R.copyWith(
                                                      color: BlaColor.grey700),
                                                ),
                                                Text(
                                                  "${viewModel.histories[calendarIdx].datetime.day}",
                                                  style: BlaTxt.txt20B,
                                                )
                                              ],
                                            ),
                                          ),
                                        SizedBox(width: idx == 0 ? 16 : 46),
                                        Expanded(
                                            child: GestureDetector(
                                          onTap: () {
                                            if (viewModel.histories[calendarIdx]
                                                    .reports[idx].type ==
                                                "crew") {
                                              viewModel.setCrewReport(viewModel
                                                  .histories[calendarIdx]
                                                  .reports[idx]
                                                  .id);
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          const ReportCrewView()));
                                            } else {
                                              viewModel.setPersonalReport(
                                                  viewModel
                                                      .histories[calendarIdx]
                                                      .reports[idx]
                                                      .id);
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          const ReportPersonalView()));
                                            }
                                          },
                                          child: ProfileHistoryTile(
                                            report: viewModel
                                                .histories[calendarIdx]
                                                .reports[idx],
                                          ),
                                        )),
                                      ],
                                    ))),
                      ),
                    ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget infoCol(String content, String category,
      {bool isCountry = false, bool isSkeleton = false}) {
    return SizedBox(
      width: 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isSkeleton
              ? SkeletonTxtWidget(
                  style: BlaTxt.txt20B,
                  width: 60,
                )
              : isCountry
                  ? CountryFlag.fromCountryCode(
                      content,
                      width: 24,
                      height: 24,
                    )
                  : Text(
                      content,
                      style: BlaTxt.txt20B,
                    ),
          const SizedBox(
            height: 8,
          ),
          Text(
            category,
            style: BlaTxt.txt12R.copyWith(color: BlaColor.grey700),
          ),
        ],
      ),
    );
  }
}
