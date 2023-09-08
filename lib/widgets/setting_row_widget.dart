import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum SettingRowType {
  toggle,
  link,
  btn,
  radio,
}

class SettingRowWidget extends StatelessWidget {
  const SettingRowWidget(
      {super.key,
      required this.type,
      required this.txt,
      required this.onTap,
      this.status = false,
      this.txtColor = BlaColor.black});
  final SettingRowType type;
  final String txt;
  final Function onTap;
  final Color txtColor;
  final bool status;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              txt,
              style: BlaTxt.txt14M.copyWith(color: txtColor),
            ),
            switch (type) {
              SettingRowType.toggle => SizedBox(
                  height: 20,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: CupertinoSwitch(
                      value: status,
                      onChanged: (value) async {
                        await onTap();
                      },
                    ),
                  ),
                ),
              SettingRowType.radio => Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: BlaColor.grey300,
                      ),
                      width: 20,
                      height: 20,
                    ),
                    if (status)
                      Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: BlaColor.defGreen,
                        ),
                        width: 10,
                        height: 10,
                      ),
                  ],
                ),
              // SizedBox(
              //     height: 20,
              //     width: 20,
              //     child: FittedBox(
              //       fit: BoxFit.contain,
              //       child: Radio(
              //         value: 0,
              //         groupValue: 1,
              //         onChanged: (value) {
              //           print(value);
              //         },
              //       ),
              //     ),
              //   ),
              SettingRowType.link => SvgPicture.asset(
                  "assets/icons/ic_20_arrow_right.svg",
                  width: 20,
                  height: 20,
                  colorFilter:
                      const ColorFilter.mode(BlaColor.grey700, BlendMode.srcIn),
                ),
              SettingRowType.btn => SizedBox(),
            }
          ],
        ),
      ),
    );
  }
}
