import 'package:blabla/screens/join/join_view_model.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class CreateWidget extends StatelessWidget {
  const CreateWidget({
    super.key,
    required this.page,
    required this.title,
    required this.widgets,
  });
  final dynamic page;
  final String title;
  final List<Widget> widgets;

  @override
  Widget build(BuildContext context) {
    final joinViewModel = Provider.of<JoinViewModel>(context);
    // final recruitViewModel = Provider.of<RecruitViewModel>(context);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 16),
          alignment: Alignment.centerLeft,
          height: 60,
          child: GestureDetector(
            onTap: () {
              if (page is JoinPage) {
                joinViewModel.initPage(page);
              } else {
                // recruitViewModel.initPage(page);
              }
              Navigator.pop(context);
            },
            child: SvgPicture.asset(
              "assets/icons/ic_32_arrow_left.svg",
              width: 32,
              height: 32,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  Text(title, style: BlaTxt.txt28B),
                  ...widgets,
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
