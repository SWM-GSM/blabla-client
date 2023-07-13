import 'package:blabla/models/country.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class JoinCountryWidget extends StatelessWidget {
  const JoinCountryWidget(
      {super.key, required this.country, required this.selected});
  final Country country;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 60,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(country.flag, style: BlaTxt.txt28R),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                country.name,
                style: selected
                    ? BlaTxt.txt16B.copyWith(color: BlaColor.orange)
                    : BlaTxt.txt16R,
              ),
            ),
            const SizedBox(width: 12),
            if (selected) SvgPicture.asset("assets/icons/ic_24_check.svg"),
          ]),
    );
  }
}
