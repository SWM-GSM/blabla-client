import 'package:blabla/screens/profile/profile_modify_view_model.dart';
import 'package:blabla/screens/profile/profile_view_model.dart';
import 'package:blabla/screens/profile/widgets/profile_bottom_sheet_widget.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:blabla/widgets/profile_widget.dart';
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
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        title: Text(
          "프로필 수정",
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
                            "화면을 나가면\n변경사항이 저장되지 않습니다.\n나가시겠습니까?",
                            style: BlaTxt.txt14R,
                          ),
                          actions: [
                            CupertinoDialogAction(
                              child: Text(
                                "취소",
                                style: BlaTxt.txt14R,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            CupertinoDialogAction(
                              child: Text("나가기",
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
                child: Container(
                  width: 104,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.fromLTRB(0, 12, 0, 24),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: BlaColor.grey100),
                  child: Text(
                    "이미지 변경",
                    style: BlaTxt.txt14SB.copyWith(color: BlaColor.grey800),
                  ),
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
                    "닉네임",
                    style: BlaTxt.txt16B,
                  ),
                  GestureDetector(
                    onTap: () async {
                      print("중복검사");
                      if (isNickLenValid) {
                        isNickDupValid =
                            await viewModel.nickDupValid(nickCtr.text);
                        if (!isNickDupValid) {
                          showToast("중복된 닉네임입니다");
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
                        "중복확인",
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
                    hintText: "이름(닉네임)을 입력해주세요",
                    hintStyle: BlaTxt.txt16R.copyWith(color: BlaColor.grey500),
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
                    "중복 확인",
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
                    "2~20자 이내",
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
                    "학습 언어",
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
                      child: Text(viewModel.tempLanguage == "ko" ? "한국어" : "영어",
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
                showToast("저장에 실패했습니다. 다시 시도해주세요.");
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
            child: Text("저장",
                style: BlaTxt.txt16B.copyWith(color: BlaColor.white)),
          ),
        ),
      ),
    );
  }
}
