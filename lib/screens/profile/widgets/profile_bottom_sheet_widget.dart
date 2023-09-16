import 'package:blabla/screens/profile/profile_modify_view_model.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ProfileBottomSheetWidget extends StatelessWidget {
  const ProfileBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProfileModifyViewModel>(context);
    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24), topRight: Radius.circular(24)),
          color: Colors.white),
      child: Wrap(alignment: WrapAlignment.center, children: [
        GestureDetector(
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Text("배울 언어", style: BlaTxt.txt18B)),
        ),
        GestureDetector(
          onTap: () {
            viewModel.setLanguage("ko");
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "한국어",
                    style: viewModel.tempLanguage == "ko"
                        ? BlaTxt.txt16B.copyWith(color: BlaColor.orange)
                        : BlaTxt.txt16R,
                  ),
                  if (viewModel.tempLanguage == "ko")
                    SvgPicture.asset(
                      "assets/icons/ic_20_check.svg",
                      width: 20,
                      height: 20,
                      colorFilter: const ColorFilter.mode(
                          BlaColor.orange, BlendMode.srcIn),
                    ),
                ]),
          ),
        ),
        GestureDetector(
          onTap: () {
            viewModel.setLanguage("en");
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "영어",
                    style: viewModel.tempLanguage == "en"
                        ? BlaTxt.txt16B.copyWith(color: BlaColor.orange)
                        : BlaTxt.txt16R,
                  ),
                  if (viewModel.tempLanguage == "en")
                    SvgPicture.asset(
                      "assets/icons/ic_20_check.svg",
                      width: 20,
                      height: 20,
                      colorFilter: const ColorFilter.mode(
                          BlaColor.orange, BlendMode.srcIn),
                    ),
                ]),
          ),
        ),
      ]),
    );
  }
}
