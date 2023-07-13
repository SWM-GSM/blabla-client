import 'package:blabla/screens/join/join_view_model.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class JoinDescWidget extends StatelessWidget {
  const JoinDescWidget({
    super.key,
    required this.page,
    required this.title,
    required this.step,
    required this.widgets,
  });
  final JoinPage page;
  final String title;
  final double step;
  final List<Widget> widgets;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<JoinViewModel>(context);
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 16),
          alignment: Alignment.centerLeft,
          height: 60,
          child: GestureDetector(
            onTap: () {
              viewModel.initPage(page);
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
                  LinearPercentIndicator(
                    padding: const EdgeInsets.all(0),
                    backgroundColor: BlaColor.grey100,
                    progressColor: BlaColor.grey900,
                    lineHeight: 4,
                    percent: step,
                    barRadius: const Radius.circular(4),
                    animation: true,
                    addAutomaticKeepAlive: true,
                  ),
                  const SizedBox(height: 20),
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
