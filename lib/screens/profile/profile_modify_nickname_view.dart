import 'package:blabla/screens/profile/profile_modify_view_model.dart';
import 'package:blabla/screens/profile/widgets/profile_modify_widget.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ProfileModifyNicknameView extends StatefulWidget {
  const ProfileModifyNicknameView({super.key, required this.initNick});
  final String initNick;

  @override
  State<ProfileModifyNicknameView> createState() =>
      _ProfileModifyNicknameViewState();
}

class _ProfileModifyNicknameViewState extends State<ProfileModifyNicknameView> {
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
      if (nickCtr.text.length >= 2 && nickCtr.text.length <= 12) {
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
    return ProfileModifyWidget(
        title: "닉네임",
        subTitle: "사용자 이름(닉네임)을\n입력해주세요",
        leadingTap: () {
          widget.initNick == nickCtr.text
              ? Navigator.pop(context)
              : showCupertinoDialog(
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
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ));
        },
        actionTap: () {
          if (!isNickDupValid) {
            showToast("유효하지 않은 닉네임입니다.");
          } else {
            viewModel.setNickname(nickCtr.text);
            Navigator.pop(context);
          }
        },
        widget: Column(
          children: [
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextField(
                    controller: nickCtr,
                    focusNode: nickFocus,
                    scrollPadding: EdgeInsets.zero,
                    maxLength: 12,
                    style: BlaTxt.txt20R,
                    decoration: InputDecoration(
                      hintText: "이름(닉네임)을 입력해주세요",
                      hintStyle:
                          BlaTxt.txt20R.copyWith(color: BlaColor.grey500),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                      counterText: "",
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () async {
                    if (isNickLenValid) {
                      isNickDupValid =
                          await viewModel.nickDupValid(nickCtr.text);
                    } else {
                      showToast("중복된 닉네임입니다.");
                    }
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:
                            isNickLenValid ? BlaColor.orange : BlaColor.grey700,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: isNickLenValid
                          ? BlaColor.lightOrange
                          : BlaColor.grey300,
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 7),
                    child: Text(
                      "중복확인",
                      style: BlaTxt.txt12R.copyWith(
                        color:
                            isNickLenValid ? BlaColor.orange : BlaColor.grey700,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "중복 확인",
                  style: BlaTxt.txt14M.copyWith(
                    color: isNickDupValid ? BlaColor.orange : BlaColor.grey700,
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
                      BlendMode.color),
                ),
                const SizedBox(width: 16),
                Text(
                  "2~12자 이내",
                  style: BlaTxt.txt14M.copyWith(
                    color: isNickLenValid ? BlaColor.orange : BlaColor.grey600,
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
                      BlendMode.color),
                ),
              ],
            )
          ],
        ));
  }
}
