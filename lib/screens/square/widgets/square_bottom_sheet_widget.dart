import 'package:blabla/screens/square/square_view_model.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:blabla/utils/datetime_to_str.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SquareBottomSheetWidget extends StatefulWidget {
  const SquareBottomSheetWidget({super.key});

  @override
  State<SquareBottomSheetWidget> createState() => _SquareBottomSheetWidgetState();
}

class _SquareBottomSheetWidgetState extends State<SquareBottomSheetWidget> {
  String title = "";
  DateTime date =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  TimeOfDay time = TimeOfDay.now();
  bool? dateVisible; // null: 둘 다 off, true: 날짜 on, false; 시간 on

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SquareViewModel>(context);
    return Container(
      height: 460,
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: const BoxDecoration(
        color: BlaColor.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SvgPicture.asset("assets/icons/ic_24_dismiss.svg",
                    width: 24, height: 24),
              ),
              GestureDetector(
                onTap: () {
                  if (title.isNotEmpty &&
                      DateTime(date.year, date.month, date.day, time.hour,
                              time.minute)
                          .isAfter(DateTime.now())) {
                    viewModel.createSchedule(
                        title,
                        datetimeToStr(
                            DateTime(date.year, date.month, date.day, time.hour,
                                time.minute, 0),
                            StrDatetimeType.hypenDelimiter));
                    viewModel.getSchedules();
                    Navigator.pop(context);
                  }
                },
                child: SvgPicture.asset(
                  "assets/icons/ic_24_check.svg",
                  width: 24,
                  height: 24,
                  colorFilter: title.isNotEmpty &&
                          DateTime(date.year, date.month, date.day, time.hour,
                                  time.minute)
                              .isAfter(DateTime.now())
                      ? const ColorFilter.mode(BlaColor.orange, BlendMode.srcIn)
                      : const ColorFilter.mode(
                          BlaColor.grey700, BlendMode.srcIn),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
          child: TextField(
            onChanged: (value) {
              setState(() {
                title = value;
              });
            },
            style: BlaTxt.txt20SB,
            decoration: InputDecoration(
              hintText: "제목",
              hintStyle: BlaTxt.txt20M.copyWith(color: BlaColor.grey500),
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
              isDense: true,
            ),
          ),
        ),
        const Divider(
          thickness: 1,
          color: BlaColor.grey200,
        ),
        Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      dateVisible = true;
                    });
                  },
                  child: Text(
                      datetimeToStr(
                          DateTime(date.year, date.month, date.day, time.hour,
                              time.minute),
                          StrDatetimeType.strDelOnlyDate),
                      style: dateVisible == true
                          ? BlaTxt.txt16B.copyWith(color: BlaColor.orange)
                          : BlaTxt.txt16R),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      dateVisible = false;
                    });
                  },
                  child: Text(
                    time.format(context),
                    style: dateVisible == false
                        ? BlaTxt.txt16B.copyWith(color: BlaColor.orange)
                        : BlaTxt.txt16R,
                  ),
                )
              ],
            )),
        const Divider(
          thickness: 1,
          color: BlaColor.grey200,
        ),
        dateVisible == null
            ? const SizedBox()
            : dateVisible!
                ? SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: CupertinoDatePicker(
                      key: const Key("datePicker"),
                      mode: dateVisible == true
                          ? CupertinoDatePickerMode.date
                          : CupertinoDatePickerMode.time,
                      initialDateTime: date,
                      onDateTimeChanged: (value) {
                        setState(() {
                          date = value;
                        });
                      },
                    ),
                  )
                : SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: CupertinoDatePicker(
                      key: const Key("timePicker"),
                      mode: CupertinoDatePickerMode.time,
                      initialDateTime: DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day,
                          time.hour,
                          time.minute),
                      onDateTimeChanged: (value) {
                        setState(() {
                          time = TimeOfDay.fromDateTime(value);
                        });
                      },
                    ),
                  )
      ]),
    );
  }
}
