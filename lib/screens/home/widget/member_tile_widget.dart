import 'package:blabla/models/member.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:blabla/widgets/level_widget.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MemberTileWidget extends StatelessWidget {
  const MemberTileWidget({super.key, required this.member});
  final Member member;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: 76,
                height: 76,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                    color: BlaColor.lightOrange, shape: BoxShape.circle),
                child: Image.asset(
                  "assets/imgs/img_120_profile_${member.profileImage}.png",
                  width: 44,
                  height: 44,
                  fit: BoxFit.cover,
                ),
              ),
              if (member.isLeader)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 32,
                    height: 32,
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        shape: BoxShape.circle,
                        color: BlaColor.orange),
                    child: SvgPicture.asset(
                      "assets/icons/ic_16_crown.svg",
                      width: 16,
                      height: 16,
                    ),
                  ),
                )
            ],
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                member.nickname,
                style: BlaTxt.txt16M,
              ),
              const SizedBox(height: 4),
              Text(member.description,
                  style: BlaTxt.txt12R.copyWith(color: BlaColor.grey700)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: BlaColor.grey200),
                      child: CountryFlag.fromCountryCode(member.countryCode,
                          width: 16, height: 16)),
                  const SizedBox(width: 8),
                  LevelWidget(lang: "KR", level: member.korLevel),
                  const SizedBox(width: 8),
                  LevelWidget(lang: "EN", level: member.engLevel),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
