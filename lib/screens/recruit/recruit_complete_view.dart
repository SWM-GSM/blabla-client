import 'package:blabla/main.dart';
import 'package:blabla/screens/home/crew_detail_view.dart';
import 'package:blabla/screens/home/crew_view_model.dart';
import 'package:blabla/screens/recruit/recruit_view_model.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecruitCompleteView extends StatelessWidget {
  const RecruitCompleteView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RecruitViewModel>(context);
    final crewViewModel =
        Provider.of<CrewViewModel>(context); // 수정 - 리랙토링 시 삭제 할 수 있는 방향으로 진행
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "👍",
                    style: TextStyle(
                      fontSize: 100,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "크루 생성이",
                    style: BlaTxt.txt28B,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "완료",
                        style: BlaTxt.txt28B.copyWith(color: BlaColor.orange),
                      ),
                      Text("되었습니다!", style: BlaTxt.txt28B)
                    ],
                  )
                ],
              ),
            ),
            Wrap(
              children: [
                GestureDetector(
                  onTap: () {
                    crewViewModel
                        .getCrewDetail(viewModel.crewId!)
                        .then((value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CrewDetailView(
                                    imgWidth: MediaQuery.of(context).size.width,
                                  )));
                    });
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    alignment: Alignment.center,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: BlaColor.grey100,
                    ),
                    child: Text("크루 참여 페이지 확인",
                        style: BlaTxt.txt16M.copyWith(color: BlaColor.grey700)),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    viewModel.init();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => const Main()),
                        (route) => true);
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    alignment: Alignment.center,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: BlaColor.orange,
                    ),
                    child: Text("완료",
                        style: BlaTxt.txt16B.copyWith(color: BlaColor.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
