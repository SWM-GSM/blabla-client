import 'package:blabla/screens/my_space/mys_content_writing_view.dart';
import 'package:blabla/screens/my_space/mys_view_model.dart';
import 'package:blabla/screens/my_space/widgets/mys_content_video_widget.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:blabla/widgets/skeleton_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class MysContentListeningView extends StatefulWidget {
  const MysContentListeningView(
      {super.key,
      required this.contentId,
      required this.category,
      required this.topic});
  final int contentId;
  final String category;
  final String topic;

  @override
  State<MysContentListeningView> createState() =>
      _MysContentListeningViewState();
}

class _MysContentListeningViewState extends State<MysContentListeningView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MysViewModel>(context, listen: false)
          .setContentId(widget.contentId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MysViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        title: viewModel.content == null
            ? Text(
                "${widget.category} - ${widget.topic}",
                style: BlaTxt.txt18B,
              )
            : Text(
                "${viewModel.content!.contentName} - ${viewModel.content!.topic}",
                style: BlaTxt.txt18B,
              ),
        backgroundColor: BlaColor.white,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            viewModel.setContentId(0);
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 16,
          ),
          Text(
            "상황을 잘 듣고",
            style: BlaTxt.txt20R,
          ),
          Text(
            "다음으로 올 말을 생각해보세요!",
            style: BlaTxt.txt20B.copyWith(color: BlaColor.orange),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: viewModel.content == null
                  ? SkeletonBoxWidget(
                      child: Container(
                          width: MediaQuery.of(context).size.width - 40,
                          height: 200,
                          color: BlaColor.black),
                    )
                  : MysContentVideoWidget(
                      contentUrl: viewModel.content!.contentUrl,
                      startAt: viewModel.content!.startedAtSec,
                      endAt: viewModel.content!.stoppedAtSec,
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
            if (viewModel.content != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MysContentWritingView(),
                ),
              );
            } else {
              showToast("컨텐츠 로딩중입니다.");
            }
          },
          child: Container(
            alignment: Alignment.center,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: BlaColor.orange,
            ),
            child: Text("다음",
                style: BlaTxt.txt16B.copyWith(color: BlaColor.white)),
          ),
        ),
      ),
    );
  }
}
