import 'package:blabla/screens/profile/profile_modify_view_model.dart';
import 'package:blabla/screens/profile/widgets/profile_modify_widget.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:blabla/utils/datetime_to_str.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileModifyBirthdateView extends StatelessWidget {
  const ProfileModifyBirthdateView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProfileModifyViewModel>(context);
    DateTime birthdate = DateTime(
        int.parse(viewModel.tempBirthdate.split(".")[0]),
        int.parse(viewModel.tempBirthdate.split(".")[1]),
        int.parse(viewModel.tempBirthdate.split(".")[2]));

    return ProfileModifyWidget(
        title: "생년월일",
        subTitle: "생년월일을\n입력해주세요",
        leadingTap: () {
          viewModel.tempBirthdate ==
                  datetimeToStr(birthdate, StrDatetimeType.dotDelimiterSimple)
              ? Navigator.pop(context)
              : showCupertinoDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                        title: Text(
                          "화면을 나가면\n변경사항이 저장되지 않습니다.\n나가시겠습니까?",
                          style: BlaTxt.txt14R,
                        ),
                        actions: [
                          CupertinoDialogAction(
                            child: Text(
                              "취소",
                              style: BlaTxt.txt14R,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          CupertinoDialogAction(
                            child: Text("나가기",
                                style: BlaTxt.txt14R
                                    .copyWith(color: BlaColor.red)),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ));
        },
        actionTap: () {
          viewModel.setBirthdate(
              datetimeToStr(birthdate, StrDatetimeType.dotDelimiterSimple));
          Navigator.pop(context);
        },
        widget: Column(
          children: [
            const SizedBox(height: 30),
            SizedBox(
              height: 200,
              child: CupertinoDatePicker(
                initialDateTime: birthdate,
                maximumDate: DateTime.now(),
                onDateTimeChanged: (value) {
                  birthdate = value;
                },
                mode: CupertinoDatePickerMode.date,
                dateOrder: DatePickerDateOrder.ymd,
              ),
            )
          ],
        ));
  }
}
