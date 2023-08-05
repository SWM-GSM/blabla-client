import 'package:blabla/screens/recruit/recruit_number_view.dart';
import 'package:blabla/screens/recruit/recruit_view_model.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:blabla/widgets/create_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecruitJoinwayView extends StatelessWidget {
  const RecruitJoinwayView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RecruitViewModel>(context);
    return Scaffold(
      body: SafeArea(
        child: CreateWidget(
          page: RecruitPage.joinWay,
          title: "크루 가입 방식을\n선택해주세요",
          widgets: [
            const SizedBox(height: 22),
            way(context, "승인 없이 가입", "신청과 동시에 크루에 자동으로 가입됩니다", false),
            way(context, "승인 후 가입", "크루장의 승인을 받은 후 크루에 가입됩니다", true),
          ],
        ),
      ),
      bottomSheet: GestureDetector(
        onTap: () {
          if (viewModel.autoApproval != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecruitNumberView(),
              ),
            );
          }
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(
              20, 10, 20, 10 + MediaQuery.of(context).viewPadding.bottom),
          alignment: Alignment.center,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: viewModel.autoApproval != null
                ? BlaColor.orange
                : BlaColor.grey400,
          ),
          child:
              Text("다음", style: BlaTxt.txt16B.copyWith(color: BlaColor.white)),
        ),
      ),
    );
  }

  Widget way(BuildContext context, String title, String subTitle, bool value) {
    final viewModel = Provider.of<RecruitViewModel>(context);
    return GestureDetector(
      onTap: () {
        viewModel.setApproval(value);
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: viewModel.autoApproval == value
                ? BlaColor.lightOrange
                : BlaColor.grey100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(title,
              style: BlaTxt.txt16B.copyWith(
                  color: viewModel.autoApproval == value
                      ? BlaColor.orange
                      : BlaColor.grey900)),
          const SizedBox(height: 4),
          Text(subTitle,
              style: BlaTxt.txt16R.copyWith(
                  color: viewModel.autoApproval == value
                      ? BlaColor.semiLightOrange
                      : BlaColor.grey700)),
        ]),
      ),
    );
  }
}
