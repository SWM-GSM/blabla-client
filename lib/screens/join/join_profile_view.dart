import 'package:blabla/screens/join/join_nickname_view.dart';
import 'package:blabla/screens/join/join_view_model.dart';
import 'package:blabla/widgets/create_widget.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JoinProfileView extends StatelessWidget {
  const JoinProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<JoinViewModel>(context);
    return Scaffold(
      body: SafeArea(
        child: CreateWidget(
          page: JoinPage.profile,
          title: "프로필 이미지를\n선택해주세요",
          widgets: [
            const SizedBox(height: 52),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                      color: BlaColor.lightOrange,
                      borderRadius: BorderRadius.circular(110)),
                  child: Image.asset(
                    "assets/imgs/img_120_profile_${viewModel.profileImg}.png",
                    width: 120,
                    height: 120,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        viewModel.changeProfile();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: BlaColor.grey200,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Text("이미지 선택",
                            style: BlaTxt.txt14SB
                                .copyWith(color: BlaColor.grey800)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      bottomSheet: GestureDetector(
        onTap: () {
          viewModel.setProfile(viewModel.profileImg);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => JoinNicknameView()),
          );
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(
              20, 0, 20, 10 + MediaQuery.of(context).viewPadding.bottom),
          alignment: Alignment.center,
          height: 56,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: BlaColor.orange),
          child:
              Text("다음", style: BlaTxt.txt16B.copyWith(color: BlaColor.white)),
        ),
      ),
    );
  }
}
