import 'package:blabla/screens/recruit/recruit_level_view.dart';
import 'package:blabla/screens/recruit/recruit_view_model.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:blabla/widgets/create_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class RecruitNumberView extends StatefulWidget {
  const RecruitNumberView({super.key});

  @override
  State<RecruitNumberView> createState() => _RecruitNumberViewState();
}

class _RecruitNumberViewState extends State<RecruitNumberView> {
  int inputNum = 0;
  final numFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RecruitViewModel>(context);

    return Scaffold(
      body: SafeArea(
        child: CreateWidget(
          page: RecruitPage.memberNum,
          title: "크루 최대 인원 수를\n입력해주세요",
          widgets: [
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 24,
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        if (value == "") {
                          inputNum = 0;
                        } else {
                          inputNum = int.parse(value);
                        }
                      });
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                    ],
                    focusNode: numFocus,
                    scrollPadding: EdgeInsets.zero,
                    maxLength: 1,
                    style: BlaTxt.txt20R,
                    decoration: InputDecoration(
                      hintText: "0",
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
                Text(
                  "명",
                  style: BlaTxt.txt20M.copyWith(color: BlaColor.grey800),
                )
              ],
            )
          ],
        ),
      ),
      bottomSheet: GestureDetector(
        onTap: () {
          numFocus.unfocus();
          if (inputNum != 0) {
            viewModel.setNum(inputNum);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RecruitLevelView()),
            );
          }
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(
              20,
              0,
              20,
              numFocus.hasFocus
                  ? 20
                  : 10 + MediaQuery.of(context).viewPadding.bottom),
          alignment: Alignment.center,
          height: 56,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: inputNum != 0 ? BlaColor.orange : BlaColor.grey400),
          child:
              Text("다음", style: BlaTxt.txt16B.copyWith(color: BlaColor.white)),
        ),
      ),
    );
  }
}
