import 'package:blabla/screens/practice/practice_video_listening_view.dart';
import 'package:blabla/screens/practice/practice_view_model.dart';
import 'package:blabla/screens/practice/widgets/practice_video_tile_widget.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class PracticeListView extends StatefulWidget {
  const PracticeListView({super.key, required this.imgWidth});
  final double imgWidth;

  @override
  State<PracticeListView> createState() => _PracticeListViewState();
}

class _PracticeListViewState extends State<PracticeListView> {
  final _scrollCtr = ScrollController();
  bool _appBarCollapsed = false;

  @override
  void initState() {
    super.initState();
    _scrollCtr.addListener(() {
      setState(() {
        if (_scrollCtr.hasClients &&
            _scrollCtr.offset >
                (widget.imgWidth -
                    WidgetsBinding.instance.window.padding.top)) {
          _appBarCollapsed = true;
        } else {
          _appBarCollapsed = false;
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollCtr.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<PracticeViewModel>(context);
    return WillPopScope(
      onWillPop: () async {
        viewModel.initVideoList();
        return true;
      },
      child: Scaffold(
        body: viewModel.videoList == null
            ? const Center(
                child: CircularProgressIndicator(
                color: BlaColor.orange,
              ))
            : NestedScrollView(
                controller: _scrollCtr,
                headerSliverBuilder: (context, bool isScrolled) {
                  return [
                    SliverAppBar(
                      backgroundColor: BlaColor.white,
                      expandedHeight:
                          widget.imgWidth - MediaQuery.of(context).padding.top,
                      toolbarHeight: 64,
                      floating: false,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Stack(children: [
                          ExtendedImage.network(
                            viewModel.videoList!.thumbnailUrl,
                            fit: BoxFit.cover,
                            width: widget.imgWidth,
                            height: widget.imgWidth,
                          ),
                          Container(
                            height: widget.imgWidth / 3,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                  BlaColor.black.withOpacity(0.4),
                                  BlaColor.black.withOpacity(0),
                                ])),
                          ),
                        ]),
                      ),
                      collapsedHeight: 64,
                      elevation: 0.1,
                      leadingWidth: 64,
                      leading: GestureDetector(
                        onTap: () {
                          viewModel.initVideoList();
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 44,
                          height: 44,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: BlaColor.white.withOpacity(0.3)),
                          child: SvgPicture.asset(
                            "assets/icons/ic_32_arrow_left.svg",
                            width: 24,
                            height: 24,
                            colorFilter: ColorFilter.mode(
                                _appBarCollapsed
                                    ? BlaColor.black
                                    : BlaColor.white,
                                BlendMode.srcIn),
                          ),
                        ),
                      ),
                    ),
                  ];
                },
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 12),
                          child: Text(
                            viewModel.videoList!.title,
                            style: BlaTxt.txt28B,
                          ),
                        ),
                        Text(
                          viewModel.videoList!.description,
                          style: BlaTxt.txt14R.copyWith(
                              color: BlaColor.grey800,
                              overflow: TextOverflow.visible),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Column(
                            children: viewModel.videoList!.contentDetails
                                .map((e) => GestureDetector(
                                    onTap: () {
                                      if (e.isCompleted) {
                                        showToast("alreadyLearned".tr());
                                      } else {
                                        viewModel.getVideo(e.id);
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    PracticeVideoListeningView(
                                                        videoId: e.id,
                                                        title: e.title))));
                                      }
                                    },
                                    child: PracticeVideoTileWidget(video: e)))
                                .toList()),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
