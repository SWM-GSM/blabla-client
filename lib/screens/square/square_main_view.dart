import 'package:blabla/screens/square/widgets/square_schedule_widget.dart';
import 'package:blabla/screens/square/square_calendar_view.dart';
import 'package:blabla/screens/square/square_view_model.dart';
import 'package:blabla/screens/square/square_voiceroom_view.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
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
          "크루 스페이스",
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
                  Text("square.upcomingEvents".tr(), style: BlaTxt.txt20B),
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
                          "더보기",
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
                : SquareScheduleWidget(
                    type: ScheduleWidgetType.none,
                    schedule: viewModel.upcomingSchedule),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "보이스룸",
                      style: BlaTxt.txt20B,
                    ),
                    Row(
                      children: [
                        Text(
                          "6명 참여중",
                          style:
                              BlaTxt.txt14M.copyWith(color: BlaColor.grey700),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18, bottom: 16),
                  child: Wrap(
                    spacing: 8,
                    alignment: WrapAlignment.center,
                    children: [
                      const ProfileWidget(
                          profileSize: 36,
                          profile: "lion",
                          bgSize: 60,
                          bgColor: BlaColor.lightOrange),
                      const ProfileWidget(
                        profileSize: 36,
                        profile: "dog",
                        bgSize: 60,
                        bgColor: Color(0xFFEDE5E4),
                      ),
                      const ProfileWidget(
                        profileSize: 36,
                        profile: "chick",
                        bgSize: 60,
                        bgColor: Color(0xFFF8F7F9),
                      ),
                      Container(
                          height: 60,
                          width: 60,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: BlaColor.grey300,
                          ),
                          child: Text(
                            "+2",
                            style:
                                BlaTxt.txt20B.copyWith(color: BlaColor.grey700),
                          )),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    if (viewModel.myId != null && viewModel.agora != null) {
                      final permission = await Permission.microphone.request();
                      if (permission == PermissionStatus.granted) {
                        if (context.mounted) {
                          viewModel.joinChannel();
                          Navigator.of(context, rootNavigator: true)
                              .push(MaterialPageRoute(
                                  builder: (context) => SquareVoiceroomView(
                                        id: viewModel.myId!,
                                        token: viewModel.agora!.token,
                                        channelId: "blablah",
                                      )));
                        }
                      } else if (permission ==
                          PermissionStatus.permanentlyDenied) {
                        openAppSettings();
                      }
                    } else {
                      showToast("잠시 후 다시 시도해주세요");
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
                      "참여하기",
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
