import 'package:blabla/screens/practice/practice_list_view.dart';
import 'package:blabla/screens/practice/practice_view_model.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:blabla/widgets/skeleton_ui_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class PracticeMainView extends StatelessWidget {
  const PracticeMainView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<PracticeViewModel>(context);
    return Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 90,
                  ),
                  viewModel.contentList.isEmpty
                      ? SkeletonBoxWidget(
                          child: Container(
                            height:
                                (MediaQuery.of(context).size.height - 120) * 0.6,
                            width:
                                (MediaQuery.of(context).size.height - 120) * 3 / 8,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: BlaColor.grey100),
                          ),
                        )
                      : CarouselSlider.builder(
                          itemCount: viewModel.contentList.length,
                          itemBuilder: (context, itemIdx, pageViewIdx) {
                            return GestureDetector(
                              onTap: () {
                                viewModel.getVideoList(
                                    viewModel.contentList[itemIdx].id);
                                Navigator.of(context, rootNavigator: true).push(
                                    MaterialPageRoute(
                                        builder: (context) => PracticeListView(
                                            imgWidth: MediaQuery.of(context)
                                                .size
                                                .width)));
                              },
                              child: AspectRatio(
                                aspectRatio: 5 / 8,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: ExtendedImage.network(
                                      viewModel.contentList[itemIdx].thumbnailUrl,
                                      fit: BoxFit.cover),
                                ),
                              ),
                            );
                          },
                          options: CarouselOptions(
                            height:
                                (MediaQuery.of(context).size.height - 120) * 0.6,
                            enlargeCenterPage: true,
                            enlargeFactor: 0.2,
                            enlargeStrategy: CenterPageEnlargeStrategy.scale,
                            enableInfiniteScroll: false,
                            autoPlay: false,
                            viewportFraction: 0.75,
                            onPageChanged: (index, reason) {
                              viewModel.setContentIdx(index);
                            },
                          ),
                        ),
                  viewModel.contentList.isEmpty
                      ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 32, bottom: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SkeletonBoxWidget(
                                    child: Container(
                                      height: 8,
                                      width:
                                          (MediaQuery.of(context).size.width - 150),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          color: BlaColor.grey100),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  SkeletonTxtWidget(style: BlaTxt.txt16B, width: 40)
                                ],
                              ),
                            ),
                            SkeletonTxtWidget(style: BlaTxt.txt20B, width: 100),
                            const SizedBox(height: 8),
                            SkeletonTxtWidget(style: BlaTxt.txt12R, width: 200),
                            SkeletonTxtWidget(style: BlaTxt.txt12R, width: 200),
                          ],
                        )
                      : Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 32, bottom: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        height: 8,
                                        width:
                                            MediaQuery.of(context).size.width - 150,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color: BlaColor.grey100),
                                      ),
                                      Positioned(
                                        left: 0,
                                        child: Container(
                                          height: 8,
                                          width:
                                              (MediaQuery.of(context).size.width -
                                                      150) *
                                                  (viewModel
                                                          .contentList[
                                                              viewModel.contentIdx]
                                                          .progress /
                                                      100),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: BlaColor.orange),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                      "${viewModel.contentList[viewModel.contentIdx].progress}%",
                                      style: BlaTxt.txt16B
                                          .copyWith(color: BlaColor.orange))
                                ],
                              ),
                            ),
                            Text(viewModel.contentList[viewModel.contentIdx].title,
                                style: BlaTxt.txt20B),
                            const SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 50),
                              child: Text(
                                viewModel
                                    .contentList[viewModel.contentIdx].description,
                                style: BlaTxt.txt12R
                                    .copyWith(overflow: TextOverflow.visible),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                ],
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
                            "mySpace".tr(),
                            style: BlaTxt.txt18B,
                          ),
                          Text(
                            viewModel.contentLangType.fullKey.tr(),
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
