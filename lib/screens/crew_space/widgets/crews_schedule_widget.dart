import 'package:blabla/models/schedule.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:blabla/utils/datetime_to_str.dart';
import 'package:blabla/widgets/profile_widget.dart';
import 'package:flutter/material.dart';

enum ScheduleWidgetType {
  none,
  upcodming,
  join,
}

class CrewsScheduleWidget extends StatelessWidget {
  const CrewsScheduleWidget(
      {super.key, required this.type, required this.schedule});
  final ScheduleWidgetType type;
  final ScheduleSimple? schedule;

  @override
  Widget build(BuildContext context) {
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
                    "D-${schedule!.dday}",
                    style: BlaTxt.txt16B.copyWith(color: BlaColor.orange),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    datetimeToStr(
                        schedule!.meetingTime, StrDatetimeType.strDelimiter),
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
        return Container();
    }
  }
}
