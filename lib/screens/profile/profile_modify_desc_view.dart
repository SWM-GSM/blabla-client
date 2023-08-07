import 'package:blabla/screens/profile/profile_modify_view_model.dart';
import 'package:blabla/screens/profile/profile_view_model.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ProfileModifyDescView extends StatefulWidget {
  const ProfileModifyDescView({super.key, required this.initDesc});
  final String initDesc;

  @override
  State<ProfileModifyDescView> createState() => _ProfileModifyDescViewState();
}

class _ProfileModifyDescViewState extends State<ProfileModifyDescView> {
  final descFocus = FocusNode();
  final descCtr = TextEditingController();

  @override
  void initState() {
    super.initState();
    descCtr.text = widget.initDesc;
  }

  @override
  void dispose() {
    super.dispose();
    descCtr.dispose();
    descFocus.dispose();
  }

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
          "자기소개",
          style: BlaTxt.txt18B,
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            viewModel.description == descCtr.text
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
                              descFocus.unfocus();
                              viewModel.revertDescription();
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
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 96),
              child: SingleChildScrollView(
                child: Wrap(
                  runSpacing: 20,
                  children: [
                    TextField(
                      controller: descCtr,
                      focusNode: descFocus,
                      scrollPadding: EdgeInsets.zero,
                      maxLines: null,
                      style: BlaTxt.txt16R,
                      decoration: InputDecoration(
                        hintText: "자기소개를 입력해주세요",
                        hintStyle:
                            BlaTxt.txt16R.copyWith(color: BlaColor.grey500),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        isDense: true,
                        counterText: "",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomSheet: GestureDetector(
        onTap: () async {
          viewModel.setDescription(descCtr.text);
          descFocus.unfocus();
          if (await viewModel.saveDescription()) {
            profileViewModel.init();
            showToast("입력하신 내용이 저장되었습니다.");
          } else {
            showToast("저장에 실패했습니다. 다시 시도해주세요.");
          }
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(
              20,
              0,
              20,
              descFocus.hasFocus
                  ? 20
                  : 10 + MediaQuery.of(context).viewPadding.bottom),
          alignment: Alignment.center,
          height: 56,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: BlaColor.orange),
          child:
              Text("저장", style: BlaTxt.txt16B.copyWith(color: BlaColor.white)),
        ),
      ),
    );
  }
}
