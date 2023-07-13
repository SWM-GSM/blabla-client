import 'package:blabla/screens/join/join_birthdate_view.dart';
import 'package:blabla/screens/join/join_view_model.dart';
import 'package:blabla/screens/join/widgets/join_desc_widget.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class JoinNicknameView extends StatefulWidget {
  const JoinNicknameView({super.key});

  @override
  State<JoinNicknameView> createState() => _JoinNicknameViewState();
}

class _JoinNicknameViewState extends State<JoinNicknameView> {
  final nickFocus = FocusNode();
  bool isNickLenValid = false;
  String nick = "";

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<JoinViewModel>(context);

    return Scaffold(
      body: SafeArea(
        child: JoinDescWidget(
          page: JoinPage.nickname,
          title: "사용자 이름(닉네임)을\n입력해주세요",
          step: 0.25,
          widgets: [
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextField(
                    focusNode: nickFocus,
                    onChanged: (value) {
                      viewModel.initNickValid();
                      setState(() {
                        nick = value;
                        if (value.length >= 2 && value.length <= 12) {
                          isNickLenValid = true;
                        } else {
                          isNickLenValid = false;
                        }
                      });
                    },
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
                  onTap: () {
                    if (isNickLenValid) viewModel.nickDupValid(nick);
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
                    color: viewModel.isNickDupValid
                        ? BlaColor.orange
                        : BlaColor.grey700,
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
                      viewModel.isNickDupValid
                          ? BlaColor.orange
                          : BlaColor.grey600,
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
        ),
      ),
      bottomSheet: GestureDetector(
        onTap: () {
          if (isNickLenValid && viewModel.isNickDupValid) {
            viewModel.setNick(nick);
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
              color: isNickLenValid && viewModel.isNickDupValid
                  ? BlaColor.orange
                  : BlaColor.grey400),
          child:
              Text("다음", style: BlaTxt.txt16B.copyWith(color: BlaColor.white)),
        ),
      ),
    );
  }
}
