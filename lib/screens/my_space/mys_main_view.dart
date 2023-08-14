import 'package:blabla/screens/my_space/mys_view_model.dart';
import 'package:blabla/screens/my_space/widgets/mys_category_widget.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class MysMainView extends StatelessWidget {
  const MysMainView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MysViewModel>(context);
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 64,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 64),
            child: SingleChildScrollView(
              child: viewModel.categoryList.isEmpty
                  ? Column(
                      children: List.generate(
                        5,
                        (index) => const MysCategoryWidget(category: null),
                      ),
                    )
                  : Column(
                      children: List.generate(
                        viewModel.categoryList.length,
                        (index) => MysCategoryWidget(
                            category: viewModel.categoryList[index]),
                      ),
                    ),
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 64,
              color: BlaColor.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GestureDetector(
                      onTap: () {
                        viewModel.changeContentLangType(true);
                      },
                      child: SvgPicture.asset(
                        "assets/icons/ic_24_tri_left.svg",
                        colorFilter: ColorFilter.mode(
                            viewModel.contentLangType.index == 0
                                ? BlaColor.grey700
                                : BlaColor.black,
                            BlendMode.srcIn),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "마이 스페이스",
                        style: BlaTxt.txt18B,
                      ),
                      Text(
                        viewModel.contentLangType.korName, // 수정 - 한국어 / 영어 구분
                        style: BlaTxt.txt14M,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GestureDetector(
                      onTap: () {
                        viewModel.changeContentLangType(false);
                      },
                      child: SvgPicture.asset(
                        "assets/icons/ic_24_tri_right.svg",
                        colorFilter: ColorFilter.mode(
                            viewModel.contentLangType.index ==
                                    ContentLangType.values.length - 1
                                ? BlaColor.grey700
                                : BlaColor.black,
                            BlendMode.srcIn),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
