import 'package:blabla/screens/practice/practice_view_model.dart';
import 'package:blabla/screens/practice/widgets/practice_video_widget.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:blabla/widgets/skeleton_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class PracticeTempView extends StatelessWidget {
  const PracticeTempView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<PracticeViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        title: Text(
          "더 빠른 검수를 위한 임시 화면",
          style: BlaTxt.txt18B,
        ),
        backgroundColor: BlaColor.white,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            viewModel.initVideo();
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SvgPicture.asset(
              "assets/icons/ic_32_arrow_left.svg",
              width: 24,
              height: 24,
            ),
          ),
        ),
        leadingWidth: 64,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 16,
            ),
            Text(
              "문제 영상",
              style: BlaTxt.txt20R,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: viewModel.video == null
                    ? SkeletonBoxWidget(
                        child: Container(
                            width: MediaQuery.of(context).size.width - 40,
                            height: 200,
                            color: BlaColor.black),
                      )
                    : PracticeVideoWidget(
                        contentUrl: viewModel.video!.contentUrl,
                        startAt: viewModel.video!.startedAtSec,
                        endAt: viewModel.video!.stoppedAtSec,
                      ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "정답 포함 영상",
              style: BlaTxt.txt20R,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: viewModel.video == null
                    ? SkeletonBoxWidget(
                        child: Container(
                            width: MediaQuery.of(context).size.width - 40,
                            height: 200,
                            color: BlaColor.black),
                      )
                    : PracticeVideoWidget(
                        contentUrl: viewModel.video!.contentUrl,
                        startAt: viewModel.video!.startedAtSec,
                        endAt: viewModel.video!.endedAtSec,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
