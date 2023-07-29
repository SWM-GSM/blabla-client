import 'package:blabla/screens/join/join_view_model.dart';
import 'package:blabla/screens/profile/profile_modify_view_model.dart';
import 'package:blabla/screens/profile/widgets/profile_modify_widget.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileModifyGenderView extends StatelessWidget {
  const ProfileModifyGenderView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProfileModifyViewModel>(context);
    return ProfileModifyWidget(
      title: "성별",
      subTitle: "성별을 선택해주세요",
      leadingTap: () {
        viewModel.tempGender == viewModel.gender
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
                              style:
                                  BlaTxt.txt14R.copyWith(color: BlaColor.red)),
                          onPressed: () {
                            viewModel.revertGender();
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ));
      },
      actionTap: () {
        Navigator.pop(context);
      },
      widget: Column(
        children: [
          const SizedBox(height: 30),
          Row(
            children: List.generate(
                3,
                (idx) => Expanded(
                      child: GestureDetector(
                        onTap: () {
                          viewModel.setGender(Gender.values[idx].name);
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: idx != 2 ? 10 : 0),
                          height: 52,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Gender.values[idx].name ==
                                      viewModel.tempGender
                                  ? BlaColor.lightOrange
                                  : BlaColor.grey100,
                              borderRadius: BorderRadius.circular(16)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(Gender.values[idx].emoji,
                                    style: BlaTxt.txt24M),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  Gender.values[idx].kr,
                                  style: Gender.values[idx].name ==
                                          viewModel.tempGender
                                      ? BlaTxt.txt16B
                                          .copyWith(color: BlaColor.orange)
                                      : BlaTxt.txt16M
                                          .copyWith(color: BlaColor.grey800),
                                )
                              ]),
                        ),
                      ),
                    )),
          )
        ],
      ),
    );
  }
}
