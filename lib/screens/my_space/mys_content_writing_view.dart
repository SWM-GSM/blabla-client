import 'package:avatar_glow/avatar_glow.dart';
import 'package:blabla/screens/my_space/mys_view_model.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:blabla/widgets/chat_bubble_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

enum WritingStatus {
  beforeWriting,
  isWriting,
  afterWriting,
  beforeFeedback,
  afterFeedback,
}

class MysContentWritingView extends StatefulWidget {
  const MysContentWritingView({super.key});

  @override
  State<MysContentWritingView> createState() => _MysContentWritingViewState();
}

class _MysContentWritingViewState extends State<MysContentWritingView> {
  stt.SpeechToText _speech = stt.SpeechToText();
  WritingStatus _status = WritingStatus.beforeWriting;
  bool _isListening = false;
  String _txt = "";
  // Animation animation =
  List<Widget> feedBackBubbles = [];
  bool _isFeedbackEnded = false;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _startListening() async {
    bool speechAvailable = await _speech.initialize(
        onStatus: (val) => print("onStatus: $val"),
        onError: (val) => print("onError: $val"));
    if (speechAvailable) {
      setState(() {
        _isListening = true;
        _status = WritingStatus.isWriting;
      });
      _speech.listen(
          onResult: (result) => setState(() {
                _txt = result.recognizedWords;
              }));
    } else {
      showToast("잠시 뒤에 다시 시도해주세요.");
    }
  }

  void _stopListening() async {
    setState(() {
      _isListening = false;
      _status = WritingStatus.afterWriting;
    });
    _speech.stop();
  }

  void _getFeedBack(BuildContext context) async {
    final viewModel = Provider.of<MysViewModel>(context, listen: false);
    int _feedbackDelaySecond = 1;
    await Future.delayed(Duration(seconds: _feedbackDelaySecond)).then((value) {
      setState(() {
        feedBackBubbles.add(const ChatBubbleWidget(
          type: ChatBubbleType.receiver,
          txt: "AI가 영작한 문장을 분석하고 있어요!",
          isFirst: true,
        ));
      });
    });
    await Future.delayed(Duration(seconds: _feedbackDelaySecond)).then((value) {
      setState(() {
        feedBackBubbles.add(Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 40),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.66 - 52,
                  ),
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: BlaColor.grey200,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16)),
                  ),
                  child: const SpinKitThreeBounce(
                    color: BlaColor.grey700,
                    size: 20,
                    duration: Duration(seconds: 1),
                  ),
                ),
              ],
            ),
          ],
        ));
      });
    });
    await viewModel.getFeedback(_txt).then((value) {
      setState(() {
        feedBackBubbles.removeLast();
        feedBackBubbles.add(const ChatBubbleWidget(
            type: ChatBubbleType.receiver, txt: "Nice Try! 🥰"));
      });
    });
    await Future.delayed(Duration(seconds: _feedbackDelaySecond)).then((value) {
      setState(() {
        feedBackBubbles.add(const ChatBubbleWidget(
            type: ChatBubbleType.receiver,
            txt: "좋은 시도에요!\n영어로 생각하는 습관이 길러지고 있어요!"));
        _isFeedbackEnded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_status) {
      case WritingStatus.beforeWriting:
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 64,
            title: Text(
              "아이스베어 - 시간 약속 정하기",
              style: BlaTxt.txt18B,
            ),
            backgroundColor: BlaColor.white,
            elevation: 0,
            centerTitle: true,
            leading: GestureDetector(
              onTap: () {
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
          body: const Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ChatBubbleWidget(
                  type: ChatBubbleType.receiver,
                  txt: "다음으로 올 문장을 영작해주세요!",
                  isFirst: true,
                ),
                ChatBubbleWidget(type: ChatBubbleType.receiver, txt: "만나서 반가워!")
              ],
            ),
          ),
          bottomSheet: Padding(
            padding: EdgeInsets.only(
                bottom: 20 + MediaQuery.of(context).padding.bottom),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 64,
                ),
                GestureDetector(
                  onTap: _startListening,
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: BlaColor.orange),
                    child: SvgPicture.asset("assets/icons/ic_48_mic.svg",
                        width: 48, height: 48),
                  ),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: BlaColor.grey300,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/ic_28_keyboard.svg",
                      width: 28,
                      height: 28,
                      colorFilter: const ColorFilter.mode(
                          BlaColor.grey800, BlendMode.srcIn),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      case WritingStatus.isWriting:
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 64,
            title: Text(
              "아이스베어 - 시간 약속 정하기",
              style: BlaTxt.txt18B,
            ),
            backgroundColor: BlaColor.white,
            elevation: 0,
            centerTitle: true,
            leading: GestureDetector(
              onTap: () {
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
          body: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ChatBubbleWidget(
                  type: ChatBubbleType.receiver,
                  txt: "다음으로 올 문장을 영작해주세요!",
                  isFirst: true,
                ),
                const ChatBubbleWidget(
                    type: ChatBubbleType.receiver, txt: "만나서 반가워!"),
                ChatBubbleWidget(type: ChatBubbleType.sender, txt: _txt)
              ],
            ),
          ),
          bottomSheet: Padding(
            padding: EdgeInsets.only(
                bottom: 20 + MediaQuery.of(context).padding.bottom),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 64,
                ),
                GestureDetector(
                  onTap: _stopListening,
                  child: AvatarGlow(
                    animate: _isListening,
                    glowColor: BlaColor.orange,
                    endRadius: 60,
                    duration: const Duration(milliseconds: 2000),
                    repeatPauseDuration: const Duration(milliseconds: 50),
                    repeat: true,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: BlaColor.orange),
                      child: SvgPicture.asset("assets/icons/ic_48_stop.svg",
                          width: 48, height: 48),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: BlaColor.grey300,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/ic_28_keyboard.svg",
                      width: 28,
                      height: 28,
                      colorFilter: const ColorFilter.mode(
                          BlaColor.grey800, BlendMode.srcIn),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      case WritingStatus.afterWriting:
        return Scaffold(
            appBar: AppBar(
              toolbarHeight: 64,
              title: Text(
                "아이스베어 - 시간 약속 정하기",
                style: BlaTxt.txt18B,
              ),
              backgroundColor: BlaColor.white,
              elevation: 0,
              centerTitle: true,
              leading: GestureDetector(
                onTap: () {
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
            body: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ChatBubbleWidget(
                    type: ChatBubbleType.receiver,
                    txt: "다음으로 올 문장을 영작해주세요!",
                    isFirst: true,
                  ),
                  const ChatBubbleWidget(
                      type: ChatBubbleType.receiver, txt: "만나서 반가워!"),
                  ChatBubbleWidget(type: ChatBubbleType.sender, txt: _txt)
                ],
              ),
            ),
            bottomSheet: Padding(
              padding: EdgeInsets.fromLTRB(
                  20, 0, 20, 12 + MediaQuery.of(context).viewPadding.bottom),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // PageTransitionSwitcher(
                  //   transitionBuilder: (child, animation, secondary) => FadeThroughTransition(
                  //     animation: animation,
                  //     secondaryAnimation: secondary,
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       children: [
                  //         Container(
                  //           alignment: Alignment.center,
                  //           padding: const EdgeInsets.all(16),
                  //           decoration: BoxDecoration(
                  //             shape: BoxShape.circle,
                  //             color: BlaColor.orange,
                  //             border:
                  //                 Border.all(color: BlaColor.lightOrange, width: 8),
                  //           ),
                  //           child: SvgPicture.asset(
                  //             "assets/icons/ic_24_check.svg",
                  //             width: 24,
                  //             height: 24,
                  //             colorFilter: const ColorFilter.mode(
                  //                 BlaColor.white, BlendMode.srcIn),
                  //           ),
                  //         ),
                  //         const SizedBox(
                  //           height: 12,
                  //         ),
                  //         Text(
                  //           "영작 완료",
                  //           style: BlaTxt.txt20SB,
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: BlaColor.orange,
                          border:
                              Border.all(color: BlaColor.lightOrange, width: 4),
                        ),
                        child: SvgPicture.asset(
                          "assets/icons/ic_24_check.svg",
                          width: 24,
                          height: 24,
                          colorFilter: const ColorFilter.mode(
                              BlaColor.white, BlendMode.srcIn),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        "영작 완료",
                        style: BlaTxt.txt20SB,
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _status = WritingStatus.beforeWriting;
                        _txt = "";
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: BlaColor.grey200,
                      ),
                      child: Text(
                        "다시 시도하기",
                        style: BlaTxt.txt16M.copyWith(color: BlaColor.grey700),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _status = WritingStatus.beforeFeedback;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: BlaColor.orange,
                      ),
                      child: Text(
                        "피드백 받기",
                        style: BlaTxt.txt16B.copyWith(color: BlaColor.white),
                      ),
                    ),
                  ),
                ],
              ),
            ));
      case WritingStatus.beforeFeedback:
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 64,
            title: Text(
              "아이스베어 - 시간 약속 정하기",
              style: BlaTxt.txt18B,
            ),
            backgroundColor: BlaColor.white,
            elevation: 0,
            centerTitle: true,
            leading: GestureDetector(
              onTap: () {
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
          body: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ChatBubbleWidget(
                  type: ChatBubbleType.receiver,
                  txt: "다음으로 올 문장을 영작해주세요!",
                  isFirst: true,
                ),
                const ChatBubbleWidget(
                    type: ChatBubbleType.receiver, txt: "만나서 반가워!"),
                ChatBubbleWidget(type: ChatBubbleType.sender, txt: _txt),
                Column(
                  children: feedBackBubbles,
                )
              ],
            ),
          ),
          bottomSheet: _isFeedbackEnded
              ? Container(
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
                      print("피드백 페이지 이동");
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: BlaColor.orange,
                      ),
                      child: Text("자세한 피드백 보러가기",
                          style: BlaTxt.txt16B.copyWith(color: BlaColor.white)),
                    ),
                  ),
                )
              : null,
        );
      default:
        return Container();
    }
  }
}
