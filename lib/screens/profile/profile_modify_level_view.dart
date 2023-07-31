import 'package:blabla/screens/profile/profile_modify_view_model.dart';
import 'package:blabla/screens/profile/widgets/profile_level_widget.dart';
import 'package:blabla/screens/profile/widgets/profile_modify_widget.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ProfileModifyLevelView extends StatelessWidget {
  const ProfileModifyLevelView({super.key, required this.lang});
  final lang;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProfileModifyViewModel>(context);
    return ProfileModifyWidget(
        title: "${lang == "eng" ? "영어" : "한국어"} 레벨",
        subTitle: "${lang == "eng" ? "영어" : "한국어"} 레벨을\n선택해주세요",
        leadingTap: () {
          if (lang == "eng") {
            viewModel.tempEngLangLevel == viewModel.engLanglevel
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
                                viewModel.revertEngLangLevel();
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ));
          } else {
            viewModel.tempKorLangLevel == viewModel.korLanglevel
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
                                viewModel.revertKorLangLevel();
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ));
          }
        },
        actionTap: () {
          Navigator.pop(context);
        },
        widget: Expanded(
          child: Column(
            children: [
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  itemCount: viewModel.levelList.length,
                  itemBuilder: (context, idx) => GestureDetector(
                    onTap: () {
                      if (lang == "eng") {
                        viewModel
                            .setEngLangLevel(viewModel.levelList[idx].degree);
                      } else {
                        viewModel
                            .setKorLangLevel(viewModel.levelList[idx].degree);
                      }
                    },
                    child: ProfileLevelWidget(
                        degree: viewModel.levelList[idx].degree,
                        desc: viewModel.levelList[idx].desc,
                        selected: (() {
                          if (lang == "eng") {
                            return viewModel.tempEngLangLevel ==
                                    viewModel.levelList[idx].degree
                                ? true
                                : false;
                          } else {
                            return viewModel.tempKorLangLevel ==
                                    viewModel.levelList[idx].degree
                                ? true
                                : false;
                          }
                        })()),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
