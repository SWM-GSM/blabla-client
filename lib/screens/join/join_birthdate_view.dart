import 'package:blabla/screens/join/join_gender_view.dart';
import 'package:blabla/screens/join/join_view_model.dart';
import 'package:blabla/widgets/create_widget.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JoinBirthdateView extends StatelessWidget {
  const JoinBirthdateView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<JoinViewModel>(context);
    DateTime birthdate = DateTime(2000,1,1);

    return Scaffold(
      body: SafeArea(
        child: CreateWidget(
        page: JoinPage.birthdate,
        title: "생년월일을\n입력해주세요", widgets: [
          const SizedBox(height: 30),
          SizedBox(
            height: 200,
            child: CupertinoDatePicker(
              initialDateTime: DateTime(2000,1,1),
              maximumDate: DateTime.now(),
              onDateTimeChanged: (value) {
                birthdate = value;
              },
              mode: CupertinoDatePickerMode.date,
              dateOrder: DatePickerDateOrder.ymd,
              
            ),
          )
        ]),
      ),
      bottomSheet: GestureDetector(
        onTap: () {
          viewModel.setBirthdate(birthdate);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => JoinGenderView()),
          );
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(
              20, 0, 20, 10 + MediaQuery.of(context).viewPadding.bottom),
          alignment: Alignment.center,
          height: 56,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: BlaColor.orange),
          child:
              Text("다음", style: BlaTxt.txt16B.copyWith(color: BlaColor.white)),
        ),
      ),
    );
  }
}