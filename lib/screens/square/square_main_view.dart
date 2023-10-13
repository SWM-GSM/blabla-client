import 'package:blabla/screens/square/widgets/square_schedule_widget.dart';
import 'package:blabla/screens/square/square_calendar_view.dart';
import 'package:blabla/screens/square/square_view_model.dart';
import 'package:blabla/screens/square/square_voiceroom_view.dart';
import 'package:blabla/services/amplitude.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:blabla/utils/datetime_to_str.dart';
import 'package:blabla/widgets/profile_widget.dart';
import 'package:blabla/widgets/skeleton_ui_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class SquareMainView extends StatelessWidget {
  const SquareMainView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SquareViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        backgroundColor: BlaColor.white,
        elevation: 0,
        title: Text(
          "crewSpace".tr(),
          style: BlaTxt.txt18B,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("upcomingEvents".tr(), style: BlaTxt.txt20B),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  const SquareCalendarView()));
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "more".tr(),
                          style:
                              BlaTxt.txt14ML.copyWith(color: BlaColor.grey600),
                        ),
                        SvgPicture.asset("assets/icons/ic_16_arrow_right.svg",
                            width: 16, height: 16)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            viewModel.schedules == null
                ? SkeletonBoxWidget(
                    child: Container(
                      height: 144,
                      margin: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: BlaColor.grey100,
                      ),
                    ),
                  )
                : viewModel.upcomingSchedule == null
                    ? const SquareScheduleWidget(
                        type: ScheduleWidgetType.none, schedule: null)
                    : SquareScheduleWidget(
                        type: ScheduleWidgetType.upcodming,
                        schedule: viewModel.upcomingSchedule),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "voiceRoom".tr(),
                      style: BlaTxt.txt20B,
                    ),
                    viewModel.updateTime == null
                        ? SkeletonTxtWidget(style: BlaTxt.txt12R, width: 190)
                        : Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Text(
                                  "${datetimeToStr(viewModel.updateTime!, StrDatetimeType.hypenDelimiter)} ${"update".tr()}",
                                  style: BlaTxt.txt12R
                                      .copyWith(color: BlaColor.grey700),
                                ),
                              ),
                              const SizedBox(width: 4),
                              GestureDetector(
                                  onTap: () {
                                    viewModel.getVoiceRoomList();
                                  },
                                  child: SvgPicture.asset(
                                      "assets/icons/ic_20_refresh.svg",
                                      width: 20,
                                      height: 20))
                            ],
                          ),
                  ],
                ),
                viewModel.voiceroomList == null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Wrap(
                            spacing: 8,
                            alignment: WrapAlignment.center,
                            children: List.generate(
                                3,
                                (_) => SkeletonBoxWidget(
                                        child: Container(
                                      height: 60,
                                      width: 60,
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.only(right: 8),
                                      padding: const EdgeInsets.all(12),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: BlaColor.grey300,
                                      ),
                                    )))),
                      )
                    : viewModel.voiceroomList!.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("🔊", style: BlaTxt.txt20BL),
                                const SizedBox(height: 8),
                                Text("tryStartingVoiceRoom".tr(),
                                    style: BlaTxt.txt14R
                                        .copyWith(color: BlaColor.grey700)),
                              ],
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Wrap(
                                    spacing: 8,
                                    alignment: WrapAlignment.center,
                                    children: List.generate(
                                        viewModel.voiceroomList!.length > 3
                                            ? 3
                                            : viewModel.voiceroomList!.length,
                                        (idx) => ProfileWidget(
                                              profileSize: 36,
                                              profile: viewModel
                                                  .voiceroomList![idx]
                                                  .profileImage,
                                              bgSize: 60,
                                              bgColor: BlaColor.lightOrange,
                                            ))),
                                if (viewModel.voiceroomList!.length > 3)
                                  Container(
                                      height: 60,
                                      width: 60,
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.only(left: 8),
                                      padding: const EdgeInsets.all(12),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: BlaColor.grey300,
                                      ),
                                      child: Text(
                                        "+${viewModel.voiceroomList!.length - 3}}",
                                        style: BlaTxt.txt20B
                                            .copyWith(color: BlaColor.grey700),
                                      )),
                              ],
                            ),
                          ),
                GestureDetector(
                  onTap: () async {
                    AnalyticsConfig().btnClick("Square_JoinBtn");
                    final permission = await Permission.microphone.request();
                    if (permission == PermissionStatus.granted) {
                      await viewModel.joinChannel();
                      if (context.mounted) {
                        Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    const SquareVoiceroomView()));
                      }
                    } else if (permission ==
                        PermissionStatus.permanentlyDenied) {
                      openAppSettings();
                    } else {
                      showToast("allowMicPermission".tr());
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 48,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: BlaColor.orange,
                    ),
                    child: Text(
                      "join".tr(),
                      style: BlaTxt.txt14B.copyWith(color: BlaColor.white),
                    ),
                  ),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
