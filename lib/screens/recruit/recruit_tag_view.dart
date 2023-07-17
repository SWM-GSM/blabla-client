import 'package:blabla/screens/recruit/recruit_view_model.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:blabla/widgets/create_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecruitTagView extends StatelessWidget {
  const RecruitTagView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RecruitViewModel>(context);

    return Scaffold(
      body: SafeArea(
        child: CreateWidget(
          page: RecruitPage.tags,
          title: "크루 태그를\n선택해주세요",
          widgets: [
            const SizedBox(height: 30),
            GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 10,
                    childAspectRatio: 80 / 88),
                itemCount: viewModel.allCrewTags.length,
                itemBuilder: (context, idx) => GestureDetector(
                      onTap: () {
                        viewModel.setCrewTag(viewModel.allCrewTags[idx]);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: viewModel.crewTags
                                  .contains(viewModel.allCrewTags[idx])
                              ? BlaColor.lightOrange
                              : BlaColor.grey100,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(viewModel.allCrewTags[idx].emoji,
                                style: BlaTxt.txt28R),
                            const SizedBox(height: 8),
                            Text(
                              viewModel.allCrewTags[idx].name,
                              style: viewModel.crewTags
                                      .contains(viewModel.allCrewTags[idx])
                                  ? BlaTxt.txt12BH
                                      .copyWith(color: BlaColor.orange)
                                  : BlaTxt.txt12MH
                                      .copyWith(color: BlaColor.grey800),
                            )
                          ],
                        ),
                      ),
                    ))
          ],
        ),
      ),
      bottomSheet: GestureDetector(
        onTap: () {
          if (viewModel.crewTags.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecruitTagView(),
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
            color: viewModel.crewTags.isNotEmpty
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
