import 'package:blabla/screens/profile/profile_modify_view_model.dart';
import 'package:blabla/screens/profile/profile_view_model.dart';
import 'package:blabla/screens/profile/widgets/profile_bottom_sheet_widget.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:blabla/widgets/profile_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ProfileModifyView extends StatefulWidget {
  const ProfileModifyView({super.key, required this.initNick});
  final String initNick;

  @override
  State<ProfileModifyView> createState() => _ProfileModifyViewState();
}

class _ProfileModifyViewState extends State<ProfileModifyView> {
  final nickCtr = TextEditingController();
  final nickFocus = FocusNode();
  bool isNickLenValid = true;
  bool isNickDupValid = true;

  nickValid() {
    setState(() {
      if (widget.initNick == nickCtr.text) {
        isNickDupValid = true;
      } else {
        isNickDupValid = false;
      }
      if (nickCtr.text.length >= 2 && nickCtr.text.length <= 20) {
        isNickLenValid = true;
      } else {
        isNickLenValid = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    nickCtr.addListener(nickValid);
    nickCtr.text = widget.initNick;
  }

  @override
  void dispose() {
    super.dispose();
    nickCtr.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProfileModifyViewModel>(context);
    final profileViewModel = Provider.of<ProfileViewModel>(context);
    return WillPopScope(
      onWillPop: () async {
        if (viewModel.isProfileChanged()) {
          showCupertinoDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                    title: Text(
                      "ifLeave".tr(),
                      style: BlaTxt.txt14R,
                    ),
                    actions: [
                      CupertinoDialogAction(
                        child: Text(
                          "cancel".tr(),
                          style: BlaTxt.txt14R,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      CupertinoDialogAction(
                        child: Text("leave".tr(),
                            style: BlaTxt.txt14R.copyWith(color: BlaColor.red)),
                        onPressed: () {
                          viewModel.revert();
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ));
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 64,
          title: Text(
            "editProfile".tr(),
            style: BlaTxt.txt18B,
          ),
          backgroundColor: BlaColor.white,
          elevation: 0,
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              viewModel.isProfileChanged()
                  ? showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                            title: Text(
                              "ifLeave".tr(),
                              style: BlaTxt.txt14R,
                            ),
                            actions: [
                              CupertinoDialogAction(
                                child: Text(
                                  "cancel".tr(),
                                  style: BlaTxt.txt14R,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              CupertinoDialogAction(
                                child: Text("leave".tr(),
                                    style: BlaTxt.txt14R
                                        .copyWith(color: BlaColor.red)),
                                onPressed: () {
                                  viewModel.revert();
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ))
                  : Navigator.pop(context);
            },
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
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                ProfileWidget(
                  profileSize: 72,
                  profile: viewModel.tempProfileImage,
                  bgSize: 120,
                  bgColor: BlaColor.lightOrange,
                ),
                GestureDetector(
                  onTap: () {
                    viewModel.setProfileImage();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.fromLTRB(0, 12, 0, 24),
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: BlaColor.grey100),
                        child: Text(
                          "changeImage".tr(),
                          style: BlaTxt.txt14SB.copyWith(color: BlaColor.grey800),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "nickname".tr(),
                      style: BlaTxt.txt16B,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (isNickLenValid) {
                          isNickDupValid =
                              await viewModel.nickDupValid(nickCtr.text);
                          if (!isNickDupValid) {
                            showToast("isDupNickname".tr());
                          } else {
                            viewModel.setNickname(nickCtr.text);
                          }
                        }
                        setState(() {});
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isNickLenValid
                                ? BlaColor.orange
                                : BlaColor.grey700,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          color: isNickLenValid
                              ? BlaColor.lightOrange
                              : BlaColor.grey300,
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 7),
                        child: Text(
                          "checkValidity".tr(),
                          style: BlaTxt.txt12R.copyWith(
                            color: isNickLenValid
                                ? BlaColor.orange
                                : BlaColor.grey700,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 12,
                    bottom: 8,
                  ),
                  child: TextField(
                    controller: nickCtr,
                    focusNode: nickFocus,
                    scrollPadding: EdgeInsets.zero,
                    maxLength: 20,
                    style: BlaTxt.txt16R,
                    decoration: InputDecoration(
                      hintText: "enterUserName".tr(),
                      hintStyle:
                          BlaTxt.txt16R.copyWith(color: BlaColor.grey500),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                      counterText: "",
                    ),
                  ),
                ),
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: BlaColor.grey300,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "checkValidity".tr(),
                      style: BlaTxt.txt14M.copyWith(
                        color:
                            isNickDupValid ? BlaColor.orange : BlaColor.grey700,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    SvgPicture.asset(
                      "assets/icons/ic_20_check.svg",
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                          isNickDupValid ? BlaColor.orange : BlaColor.grey600,
                          BlendMode.srcIn),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      "twoToTwelveCharacters".tr(),
                      style: BlaTxt.txt14M.copyWith(
                        color:
                            isNickLenValid ? BlaColor.orange : BlaColor.grey600,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    SvgPicture.asset(
                      "assets/icons/ic_20_check.svg",
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                          isNickLenValid ? BlaColor.orange : BlaColor.grey600,
                          BlendMode.srcIn),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "languageToLearn".tr(),
                      style: BlaTxt.txt16B,
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) =>
                                const ProfileBottomSheetWidget());
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                          top: 12,
                          bottom: 8,
                        ),
                        child: Text(
                            viewModel.tempLanguage == "ko"
                                ? "korean".tr()
                                : "english".tr(),
                            style: BlaTxt.txt16R),
                      ),
                    ),
                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: BlaColor.grey300,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomSheet: Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: BlaColor.grey100, width: 1),
            ),
            color: BlaColor.white,
          ),
          child: GestureDetector(
            onTap: () {
              viewModel.saveProfile().then((value) {
                if (value) {
                  profileViewModel.initProfile();
                  Navigator.pop(context);
                } else {
                  showToast("failToSave".tr());
                }
              });
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(
                  20,
                  12,
                  20,
                  (nickFocus.hasFocus)
                      ? 12
                      : 12 + MediaQuery.of(context).viewPadding.bottom),
              alignment: Alignment.center,
              height: 56,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: BlaColor.orange),
              child: Text("save".tr(),
                  style: BlaTxt.txt16B.copyWith(color: BlaColor.white)),
            ),
          ),
        ),
      ),
    );
  }
}
