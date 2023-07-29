import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileModifyWidget extends StatelessWidget {
  const ProfileModifyWidget(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.leadingTap,
      required this.actionTap,
      required this.widget,
      });
  final String title;
  final String subTitle;
  final dynamic leadingTap;
  final dynamic actionTap;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 64,
          title: Text(
            title,
            style: BlaTxt.txt18B,
          ),
          backgroundColor: BlaColor.white,
          elevation: 0,
          centerTitle: true,
          leading: GestureDetector(
            onTap: leadingTap,
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
          actions: [
            GestureDetector(
                onTap: actionTap,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
                  child: Text("완료",
                      style: BlaTxt.txt16SB.copyWith(color: BlaColor.orange)),
                ))
          ],
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(subTitle, style: BlaTxt.txt28B,),
              widget,
            ],
          ),
        )));
  }
}
