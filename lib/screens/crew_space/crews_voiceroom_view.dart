import 'package:blabla/screens/crew_space/widgets/voiceroom_profile_widget.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CrewsVoiceroomView extends StatelessWidget {
  const CrewsVoiceroomView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        backgroundColor: BlaColor.white,
        elevation: 0.0,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "일요일 마다 언어 교환 할...",
              style: BlaTxt.txt18B,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                "6명 참여 중",
                style: BlaTxt.txt12B.copyWith(color: BlaColor.orange),
              ),
            ),
          ],
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SvgPicture.asset("assets/icons/ic_24_arrow_down.svg")),
        ),
        leadingWidth: 64,
      ),
      body: SafeArea(
          child: GridView.count(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 242),
        mainAxisSpacing: 12,
        crossAxisSpacing: 10,
        crossAxisCount: 2,
        childAspectRatio: 170 / 200,
        children: List.generate(
            6,
            (idx) => VoiceroomProfileWidget(
                  isSpeaker: idx % 2 == 0 ? true : false,
                  isMuted: idx % 2 == 0 ? false : true,
                )),
      )),
      bottomSheet: Container(
        decoration: const BoxDecoration(
          border: Border(
              top: BorderSide(
                  color: BlaColor.grey100,
                  width: 1,
                  strokeAlign: BorderSide.strokeAlignInside)),
          color: BlaColor.white,
        ),
        height: 222 + MediaQuery.of(context).padding.bottom,
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 36,
                margin: const EdgeInsets.symmetric(horizontal: 6),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: BlaColor.grey200,
                ),
                child: Wrap(
                  direction: Axis.horizontal,
                  spacing: 4,
                  children: [
                    CountryFlag.fromCountryCode(
                      "US",
                      width: 20,
                      height: 20,
                    ),
                    Text("14:20", style: BlaTxt.txt14R)
                  ],
                ),
              ),
              Container(
                height: 36,
                margin: const EdgeInsets.symmetric(horizontal: 6),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: BlaColor.grey200,
                ),
                child: Wrap(
                  direction: Axis.horizontal,
                  spacing: 4,
                  children: [
                    CountryFlag.fromCountryCode(
                      "KR",
                      width: 20,
                      height: 20,
                    ),
                    Text("17:23", style: BlaTxt.txt14R)
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Text("음성 통화 중",
              style: BlaTxt.txt16R.copyWith(color: BlaColor.grey700)),
          const SizedBox(
            height: 4,
          ),
          Text("01:23:22", style: BlaTxt.txt16B),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Wrap(
              spacing: 30,
              direction: Axis.horizontal,
              children: [
                voiceBtn("speaker", BlaColor.grey200, () {}),
                voiceBtn("mic_on", BlaColor.grey200, () {}),
                voiceBtn("call_end", BlaColor.red, () {}),
              ],
            ),
          )
        ]),
      ),
    );
  }

  Widget voiceBtn(String icon, Color color, onTap) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 56,
        width: 56,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: SvgPicture.asset(
          "assets/icons/ic_24_$icon.svg",
          width: 24,
          height: 24,
        ),
      ),
    );
  }
}
