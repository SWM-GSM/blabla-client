import 'package:blabla/screens/home/crew_view_model.dart';
import 'package:blabla/screens/home/widget/member_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class CrewDetailView extends StatelessWidget {
  const CrewDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CrewViewModel>(context);
    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 16),
            alignment: Alignment.centerLeft,
            height: 60,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset(
                "assets/icons/ic_32_arrow_left.svg",
                width: 32,
                height: 32,
              ),
            ),
          ),
          Column(
              children: viewModel.crew!.members
                  .map((e) => MemberTileWidget(member: e))
                  .toList())
        ],
      ),
    ));
  }
}
