import 'package:blabla/screens/profile/profile_modify_view_model.dart';
import 'package:blabla/screens/profile/profile_view_model.dart';
import 'package:blabla/screens/profile/widgets/profile_interest_widget.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ProfileModifyInterestView extends StatelessWidget {
  const ProfileModifyInterestView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProfileModifyViewModel>(context);
    final profileViewModel = Provider.of<ProfileViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        backgroundColor: BlaColor.white,
        elevation: 0,
        title: Text(
          "관심사",
          style: BlaTxt.txt18B,
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            listEquals(viewModel.interests, viewModel.tempInterests)
                ? Navigator.pop(context)
                : showCupertinoDialog(
                    context: context,
                    builder: (context) {
                      return CupertinoAlertDialog(
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
                              viewModel.revertInterests();
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SvgPicture.asset(
              "assets/icons/ic_32_arrow_left.svg",
              width: 24,
              height: 24,
            ),
          ),
        ),
        leadingWidth: 64,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 12, 0, 8),
              child: Row(
                children: [
                  Text(
                    "관심 있는 키워드를 ",
                    style: BlaTxt.txt16R.copyWith(color: BlaColor.grey700),
                  ),
                  Text(
                    "3개 이상",
                    style: BlaTxt.txt16B.copyWith(color: BlaColor.orange),
                  ),
                  Text(
                    " 선택해주세요",
                    style: BlaTxt.txt16R.copyWith(color: BlaColor.grey700),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(
                    bottom: 80 + MediaQuery.of(context).viewPadding.bottom),
                itemCount: viewModel.interestList.length,
                itemBuilder: (context, idx) => ProfileInterestWidget(
                    interest: viewModel.interestList[idx]),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.fromLTRB(
            20, 12, 20, 10 + MediaQuery.of(context).viewPadding.bottom),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: BlaColor.grey100, width: 1),
          ),
          color: BlaColor.white,
        ),
        child: Row(children: [
          Expanded(
            child: GestureDetector(
              onTap: () async {
                viewModel.initInterestList([]);
                await viewModel.saveInterests().then((value) {
                  if (value) {
                    profileViewModel.init();
                    Navigator.pop(context);
                  } else {
                    showToast("저장에 실패했습니다. 다시 시도해주세요.");
                  }
                });
              },
              child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: BlaColor.grey100,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "초기화",
                    style: BlaTxt.txt16R.copyWith(color: BlaColor.grey800),
                  )),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: GestureDetector(
              onTap: () async {
                viewModel.initInterestList(viewModel.tempInterests);
                await viewModel.saveInterests().then((value) {
                  if (value) {
                    profileViewModel.init();
                    Navigator.pop(context);
                  } else {
                    showToast("저장에 실패했습니다. 다시 시도해주세요.");
                  }
                });
              },
              child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: viewModel.tempInterests.length >= 3
                        ? BlaColor.orange
                        : BlaColor.grey400,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "완료",
                    style: BlaTxt.txt16B.copyWith(color: BlaColor.white),
                  )),
            ),
          ),
        ]),
      ),
    );
  }
}
