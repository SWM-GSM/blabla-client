import 'package:blabla/screens/practice/practice_video_writing_view.dart';
import 'package:blabla/screens/practice/practice_view_model.dart';
import 'package:blabla/screens/practice/widgets/practice_video_widget.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:blabla/widgets/skeleton_ui_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class PracticeVideoListeningView extends StatelessWidget {
  const PracticeVideoListeningView({
    super.key,
    required this.videoId,
    required this.title,
  });
  final int videoId;
  final String title;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<PracticeViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        title: viewModel.video == null
            ? Text(
                title,
                style: BlaTxt.txt18B,
              )
            : Text(
                viewModel.video!.title,
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
        actions: [
          Container(width: 64, color: Colors.transparent,),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 16,
          ),
          Text(
            "listenCarefully".tr(),
            style: BlaTxt.txt20R,
          ),
          Text(
            "sayNext".tr(),
            style: BlaTxt.txt20B.copyWith(color: BlaColor.orange),
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
        ],
      ),
      bottomSheet: Container(
        padding: EdgeInsets.fromLTRB(
            20, 12, 20, 12 + MediaQuery.of(context).padding.bottom),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: BlaColor.grey100, width: 1),
          ),
          color: BlaColor.white,
        ),
        child: GestureDetector(
          onTap: () {
            if (viewModel.video != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PracticeVideoWritingView(
                    lang: viewModel.contentLangType == ContentLangType.en
                        ? "ko-KR"
                        : "en-US",
                  ),
                ),
              );
            } else {
              showToast("loadingContent".tr());
            }
          },
          child: Container(
            alignment: Alignment.center,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: BlaColor.orange,
            ),
            child: Text("next".tr(),
                style: BlaTxt.txt16B.copyWith(color: BlaColor.white)),
          ),
        ),
      ),
    );
  }
}
