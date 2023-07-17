import 'package:blabla/screens/recruit/recruit_view_model.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:blabla/widgets/create_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecruitCycleView extends StatelessWidget {
  const RecruitCycleView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RecruitViewModel>(context);
    return Scaffold(
      body: SafeArea(
        child: CreateWidget(
          page: RecruitPage.cycle,
          title: "크루의 희망 모임 주기를\n선택해주세요",
          widgets: [
            const SizedBox(height: 30),
            GridView.count(
              shrinkWrap: true,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              crossAxisCount: 3,
              childAspectRatio: 2 / 1,
              children: List.generate(
                CrewCycle.values.length,
                (idx) => GestureDetector(
                  onTap: () {
                    viewModel.setCycle(idx);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: viewModel.cycle == CrewCycle.values[idx]
                            ? BlaColor.lightOrange
                            : BlaColor.grey100),
                    child: Text(
                      CrewCycle.values[idx].name,
                      style: viewModel.cycle == CrewCycle.values[idx]
                          ? BlaTxt.txt16B.copyWith(color: BlaColor.orange)
                          : BlaTxt.txt16M.copyWith(color: BlaColor.grey800),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecruitCycleView(),
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(
              20, 10, 20, 10 + MediaQuery.of(context).viewPadding.bottom),
          alignment: Alignment.center,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: viewModel.cycle != null ? BlaColor.orange : BlaColor.grey400,
          ),
          child:
              Text("다음", style: BlaTxt.txt16B.copyWith(color: BlaColor.white)),
        ),
      ),
    );
  }
}
