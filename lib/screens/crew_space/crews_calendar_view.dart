import 'package:blabla/models/member.dart';
import 'package:blabla/models/schedule.dart';
import 'package:blabla/screens/crew_space/widgets/crews_schedule_widget.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:table_calendar/table_calendar.dart';

class CrewsCalendarView extends StatelessWidget {
  const CrewsCalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    Map<DateTime, List<Schedule>> schedules = {
      DateTime(2023, 8, 5): [
        Schedule(
            id: 1,
            title: "배고파",
            meetingTime: DateTime(2023, 8, 1),
            members: List.generate(
              1,
              (index) =>
                  MemberSimple(id: 1, nickname: "김민지", profileImage: "cat"),
            ),
            dday: 1)
      ],
    };
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        backgroundColor: BlaColor.white,
        elevation: 0,
        title: Text(
          "일정",
          style: BlaTxt.txt18B,
        ),
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                TableCalendar(
                  headerStyle: HeaderStyle(
                    titleCentered: true,
                    formatButtonVisible: false,
                    titleTextStyle: BlaTxt.txt18B,
                    leftChevronIcon: SvgPicture.asset(
                      "assets/icons/ic_20_arrow_left.svg",
                      width: 20,
                      height: 20,
                      colorFilter: const ColorFilter.mode(
                          BlaColor.black, BlendMode.srcIn),
                    ),
                    leftChevronMargin: EdgeInsets.zero,
                    leftChevronPadding: EdgeInsets.zero,
                    rightChevronIcon: SvgPicture.asset(
                      "assets/icons/ic_20_arrow_right.svg",
                      width: 20,
                      height: 20,
                      colorFilter: const ColorFilter.mode(
                          BlaColor.black, BlendMode.srcIn),
                    ),
                    rightChevronMargin: EdgeInsets.zero,
                    rightChevronPadding: EdgeInsets.zero,
                    headerPadding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  daysOfWeekHeight: 50,
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle:
                        BlaTxt.txt16M.copyWith(color: BlaColor.grey700),
                    weekendStyle:
                        BlaTxt.txt14B.copyWith(color: BlaColor.grey700),
                  ),
                  calendarStyle: CalendarStyle(
                    cellMargin: const EdgeInsets.all(4),
                    outsideDaysVisible: true,
                    isTodayHighlighted: false,
                    selectedDecoration: const BoxDecoration(
                      color: BlaColor.black,
                      shape: BoxShape.circle,
                    ),
                    defaultTextStyle: BlaTxt.txt16R,
                    weekendTextStyle: BlaTxt.txt16R,
                  ),
                  focusedDay: DateTime(2023, 8, 1),
                  firstDay: DateTime(2023, 1, 1),
                  lastDay: DateTime(2030, 12, 31),
                  eventLoader: (day) =>
                      schedules[DateTime(day.year, day.month, day.day)] ?? [],
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, date, events) {
                      if (events.isNotEmpty) {
                        return Container(
                            width: (MediaQuery.of(context).size.width - 40) / 7,
                            padding: const EdgeInsets.all(4),
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: BlaColor.lightOrange,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              "${date.day}",
                              style: BlaTxt.txt16B
                                  .copyWith(color: BlaColor.orange),
                            ));
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, idx) {
                return CrewsScheduleWidget(
                    type: ScheduleWidgetType.join,
                    schedule: Schedule(
                        id: 1,
                        title: "배고파",
                        meetingTime: DateTime(2023, 8, 1),
                        members: List.generate(
                          1,
                          (index) => MemberSimple(
                              id: 1, nickname: "김민지", profileImage: "cat"),
                        ),
                        dday: 1));
              },
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        height: 80 + MediaQuery.of(context).padding.bottom,
        padding: EdgeInsets.fromLTRB(
            20, 11, 20, 12 + MediaQuery.of(context).padding.bottom),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: BlaColor.grey100, width: 1),
          ),
          color: BlaColor.white,
        ),
        child: GestureDetector(
          onTap: () {},
          child: Container(
            alignment: Alignment.center,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: BlaColor.orange,
            ),
            child: Text(
              "일정 만들기",
              style: BlaTxt.txt16B.copyWith(color: BlaColor.white),
            ),
          ),
        ),
      ),
    );
  }
}
