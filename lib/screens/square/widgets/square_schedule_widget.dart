import 'package:blabla/screens/profile/profile_view_model.dart';
import 'package:blabla/screens/square/square_view_model.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:blabla/utils/datetime_to_str.dart';
import 'package:blabla/widgets/profile_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum ScheduleWidgetType {
  none,
  upcodming,
  join,
}

class SquareScheduleWidget extends StatelessWidget {
  const SquareScheduleWidget(
      {super.key, required this.type, required this.schedule});
  final ScheduleWidgetType type;
  final dynamic schedule;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SquareViewModel>(context);
    final profileViewModel = Provider.of<ProfileViewModel>(context);
    switch (type) {
      case ScheduleWidgetType.none:
        return Container(
          height: 144,
          margin: const EdgeInsets.fromLTRB(20, 16, 20, 20),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: BlaColor.grey100,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "📆",
                style: BlaTxt.txt20BL,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "다가오는 일정이 없어요!",
                style: BlaTxt.txt14R.copyWith(color: BlaColor.grey700),
              ),
            ],
          ),
        );
      case ScheduleWidgetType.upcodming:
        return Container(
          margin: const EdgeInsets.fromLTRB(20, 16, 20, 20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: BlaColor.grey100,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "D${schedule!.dday < 0 ? "+${(schedule!.dday) * (-1)}" : "-${schedule!.dday}"}",
                    style: BlaTxt.txt16B.copyWith(color: BlaColor.orange),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    datetimeToStr(
                      schedule!.meetingTime,
                      StrDatetimeType.strDelimiter,
                      lang: profileViewModel.lang ?? "en",
                    ),
                    style: BlaTxt.txt16R.copyWith(color: BlaColor.grey700),
                  ),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    schedule!.title,
                    style: BlaTxt.txt16B,
                    maxLines: 1,
                  )),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Wrap(
                  direction: Axis.horizontal,
                  spacing: 8,
                  children: List.generate(
                    schedule!.profiles.length,
                    (idx) => ProfileWidget(
                      profileSize: 24,
                      profile: schedule!.profiles[idx],
                      bgSize: 48,
                      bgColor: Color(0xFFFFF6DE),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      case ScheduleWidgetType.join:
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: BlaColor.grey100,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "D${schedule!.dday < 0 ? "+${(schedule!.dday) * (-1)}" : "-${schedule!.dday}"}",
                    style: BlaTxt.txt16B.copyWith(color: BlaColor.orange),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    datetimeToStr(
                        schedule!.meetingTime, StrDatetimeType.strDelimiter,
                        lang: profileViewModel.lang ?? "en"),
                    style: BlaTxt.txt16R.copyWith(color: BlaColor.grey700),
                  ),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    schedule!.title,
                    style: BlaTxt.txt16B,
                    maxLines: 1,
                  )),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Wrap(
                  direction: Axis.horizontal,
                  spacing: 8,
                  children: List.generate(
                    schedule!.members.length,
                    (idx) => ProfileWidget(
                      profileSize: 24,
                      profile: schedule!.members[idx].profileImage,
                      bgSize: 48,
                      bgColor: Color(0xFFFFF6DE),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              if (schedule.status == "ENDED")
                Container()
              else if (schedule.status == "JOINED")
                GestureDetector(
                    onTap: () {
                      viewModel.cancelSchedule(schedule.id);
                    },
                    child: Container(
                      height: 48,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: BlaColor.grey300,
                      ),
                      child: Text(
                        "cancelParticipation".tr(),
                        style: BlaTxt.txt14B.copyWith(color: BlaColor.grey600),
                      ),
                    ))
              else
                GestureDetector(
                    onTap: () {
                      viewModel.joinSchedule(schedule.id);
                    },
                    child: Container(
                      height: 48,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: BlaColor.lightOrange,
                      ),
                      child: Text(
                        "join".tr(),
                        style: BlaTxt.txt14B.copyWith(color: BlaColor.orange),
                      ),
                    )),
            ],
          ),
        );
    }
  }
}
