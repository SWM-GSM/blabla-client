import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class VoiceroomProfileWidget extends StatelessWidget {
  const VoiceroomProfileWidget(
      {super.key, required this.isSpeaker, required this.isMuted});
  final bool isSpeaker; // 수정 - 임시 변수
  final bool isMuted; // 수정 - 임시 변수

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFFFF6DE),
            borderRadius: BorderRadius.circular(24),
            border: isSpeaker
                ? Border.all(
                    color: BlaColor.orange,
                    width: 4,
                    strokeAlign: BorderSide.strokeAlignInside)
                : null,
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/imgs/img_120_profile_cat.png",
                  width: 100,
                  height: 100,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    color: BlaColor.black.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CountryFlag.fromCountryCode('KR', width: 20, height: 16),
                      const SizedBox(
                        width: 4,
                      ),
                      Flexible(
                          child: Text("하나둘셋",
                              style: BlaTxt.txt12B
                                  .copyWith(color: BlaColor.white)))
                    ],
                  ),
                )
              ]),
        ),
        if (isMuted)
          Positioned(
              top: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: BlaColor.red,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  "assets/icons/ic_20_mic_off.svg",
                  width: 20,
                  height: 20,
                ),
              ))
      ],
    );
  }
}
