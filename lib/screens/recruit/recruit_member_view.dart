import 'package:blabla/screens/recruit/recruit_detail_view.dart';
import 'package:blabla/screens/recruit/recruit_view_model.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:blabla/widgets/create_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecruitMemberView extends StatelessWidget {
  const RecruitMemberView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RecruitViewModel>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CreateWidget(
                page: RecruitPage.memberProp,
                title: "희망 하는 크루원을\n선택해주세요",
                widgets: [
                  const SizedBox(height: 22),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: viewModel.memProps.length,
                      itemBuilder: (context, idx) => GestureDetector(
                            onTap: () {
                              viewModel.setMemProp(viewModel.memProps[idx]);
                            },
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: 68,
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: viewModel.memProp ==
                                          viewModel.memProps[idx].tag
                                      ? BlaColor.lightOrange
                                      : BlaColor.grey100),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    viewModel.memProps[idx].emoji,
                                    style: BlaTxt.txt28BL,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    viewModel.memProps[idx].name,
                                    style: viewModel.memProp ==
                                            viewModel.memProps[idx].tag
                                        ? BlaTxt.txt16B
                                            .copyWith(color: BlaColor.orange)
                                        : BlaTxt.txt16M
                                            .copyWith(color: BlaColor.grey800),
                                  )
                                ],
                              ),
                            ),
                          ))
                ])
          ],
        ),
      ),
      bottomSheet: GestureDetector(
        onTap: () {
          if (viewModel.memProp.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecruitDetailView(),
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
            color: viewModel.memProp.isNotEmpty
                ? BlaColor.orange
                : BlaColor.grey400,
          ),
          child:
              Text("다음", style: BlaTxt.txt16B.copyWith(color: BlaColor.white)),
        ),
      ),
    );
  }
}
