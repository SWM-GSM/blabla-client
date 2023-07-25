import 'package:blabla/screens/crew_space/crews_main_view.dart';
import 'package:blabla/screens/crew_space/crews_view_model.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class CrewsJoinedView extends StatelessWidget {
  const CrewsJoinedView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CrewsViewModel>(context);
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 64,
          title: Text(
            "가입한 크루",
            style: BlaTxt.txt18B,
          ),
          backgroundColor: BlaColor.white,
          elevation: 0,
          centerTitle: true,
        ),
        body: SafeArea(
            child: GridView.count(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                mainAxisSpacing: 16,
                crossAxisSpacing: 10,
                crossAxisCount: 2,
                childAspectRatio: 170 / 220,
                children: List.generate(
                    viewModel.myCrewList.length,
                    (idx) => GestureDetector(
                          onTap: () async {
                            await viewModel
                                .initCrew(viewModel.myCrewList[idx].id)
                                .then((value) {
                              Navigator.of(context, rootNavigator: true).push(
                                  MaterialPageRoute(
                                      settings: const RouteSettings(
                                          name: "/CrewsMainView"),
                                      builder: (context) => CrewsMainView()));
                            });
                          },
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      "assets/imgs/img_360_crew_${viewModel.myCrewList[idx].coverImage}.png",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: 96,
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(12),
                                        bottomRight: Radius.circular(12)),
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        BlaColor.black.withOpacity(0.7),
                                        BlaColor.black.withOpacity(0.0),
                                      ],
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        viewModel.myCrewList[idx].name,
                                        maxLines: 2,
                                        style: BlaTxt.txt14SB
                                            .copyWith(color: BlaColor.white),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            "assets/icons/ic_16_team.svg",
                                            width: 16,
                                            height: 16,
                                            colorFilter: const ColorFilter.mode(
                                                BlaColor.white,
                                                BlendMode.srcIn),
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            viewModel.myCrewList[idx].currentNum
                                                .toString(),
                                            style: BlaTxt.txt12SB.copyWith(
                                                color: BlaColor.white),
                                          ),
                                          Text(
                                            " / ${viewModel.myCrewList[idx].maxNum}",
                                            style: BlaTxt.txt12R.copyWith(
                                                color: BlaColor.white
                                                    .withOpacity(0.6)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )))));
  }
}
