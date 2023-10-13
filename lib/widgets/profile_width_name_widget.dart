import 'package:blabla/models/member.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:blabla/widgets/profile_widget.dart';
import 'package:flutter/material.dart';

class ProfileWidthNameWidget extends StatelessWidget {
  const ProfileWidthNameWidget({super.key, required this.member});
  final MemberSimple member;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      width: 62,
      margin: const EdgeInsets.only(right: 10),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfileWidget(
              profileSize: 24,
              profile: member.profileImage,
              bgSize: 48,
              bgColor: BlaColor.lightOrange,
            ),
            Text(
              member.nickname,
              style: BlaTxt.txt12M.copyWith(color: BlaColor.grey800),
            )
          ]),
    );
  }
}
