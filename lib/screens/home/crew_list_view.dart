import 'package:blabla/screens/home/crew_view_model.dart';
import 'package:blabla/screens/home/widget/crew_tile_widget.dart';
import 'package:blabla/screens/recruit/recruit_profile_view.dart';
import 'package:blabla/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CrewListView extends StatelessWidget {
  const CrewListView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CrewViewModel>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20),
              alignment: Alignment.centerLeft,
              height: 64,
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: viewModel.isLoading
                        ? List.filled(
                            10,
                            const CrewTileWidget(
                                crew: null, tileType: CrewTileType.list))
                        : viewModel.crewList
                            .map(
                              (e) => CrewTileWidget(
                                  crew: e, tileType: CrewTileType.list),
                            )
                            .toList()),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
              settings: RouteSettings(name: "/RecruitProfileView"),
              builder: (context) => RecruitProfileView()));
        },
        backgroundColor: BlaColor.orange,
        child: SvgPicture.asset(
          "assets/icons/ic_20_add.svg",
          width: 20,
          height: 20,
        ),
      ),
    );
  }
}
