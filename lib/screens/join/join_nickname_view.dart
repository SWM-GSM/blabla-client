import 'package:blabla/screens/join/join_birthdate_view.dart';
import 'package:blabla/screens/join/join_view_model.dart';
import 'package:blabla/widgets/create_widget.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class JoinNicknameView extends StatefulWidget {
  final String initNick;
  const JoinNicknameView({super.key, required this.initNick});

  @override
  State<JoinNicknameView> createState() => _JoinNicknameViewState();
}

class _JoinNicknameViewState extends State<JoinNicknameView> {
  final nickCtr = TextEditingController();
  final nickFocus = FocusNode();
  bool isNickLenValid = false;
  bool isNickDupValid = false;

  nickValid() {
    setState(() {
      isNickDupValid = false;
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
    final viewModel = Provider.of<JoinViewModel>(context);

    return Scaffold(
      body: SafeArea(
        child: CreateWidget(
          page: JoinPage.nickname,
          title: "사용자 이름(닉네임)을\n입력해주세요",
          widgets: [
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
                      if (!isNickDupValid) {
                        showToast("중복된 닉네임입니다.");
                      }
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
                      BlendMode.srcIn),
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
                      BlendMode.srcIn),
                ),
              ],
            )
          ],
        ),
      ),
      bottomSheet: GestureDetector(
        onTap: () {
          if (isNickLenValid && isNickDupValid) {
            viewModel.setNick(nickCtr.text);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => JoinBirthdateView()),
            );
          }
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(
              20,
              0,
              20,
              nickFocus.hasFocus
                  ? 20
                  : 10 + MediaQuery.of(context).viewPadding.bottom),
          alignment: Alignment.center,
          height: 56,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: isNickLenValid && isNickDupValid
                  ? BlaColor.orange
                  : BlaColor.grey400),
          child:
              Text("다음", style: BlaTxt.txt16B.copyWith(color: BlaColor.white)),
        ),
      ),
    );
  }
}
