import 'package:blabla/main.dart';
import 'package:blabla/providers/nav_provider.dart';
import 'package:blabla/screens/my_space/mys_view_model.dart';
import 'package:blabla/screens/my_space/widgets/mys_content_record_widget.dart';
import 'package:blabla/screens/my_space/widgets/mys_content_video_widget.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class MysContentSpeakingView extends StatefulWidget {
  const MysContentSpeakingView({super.key});

  @override
  State<MysContentSpeakingView> createState() => _MysContentSpeakingViewState();
}

class _MysContentSpeakingViewState extends State<MysContentSpeakingView> {
  final recorders = List.generate(3, (idx) => FlutterSoundRecorder());
  final players = List.generate(3, (idx) => FlutterSoundPlayer());
  final statuses = List.generate(3, (idx) => RecordStatus.beforeRecord);

  Future<void> initRecorder() async {
    for (final recorder in recorders) {
      await recorder.openRecorder();
    }
  }

  Future<void> initPlayer() async {
    for (final player in players) {
      await player.openPlayer();
    }
  }

  Future<void> startRecord(int idx) async {
    await recorders[idx].startRecorder(toFile: 'audio$idx.wav');
  }

  Future<String?> stopRecord(int idx) async {
    String? path = await recorders[idx].stopRecorder();
    print(path);
    return path;
  }

  void startPlay(int idx, String path) async {
    await players[idx].startPlayer(
        fromURI: path,
        whenFinished: () {
          setState(() {
            statuses[idx] = RecordStatus.afterRecord;
          });
        });
  }

  void stopPlay(int idx) async {
    await players[idx].stopPlayer();
  }

  @override
  void initState() {
    super.initState();
    initPlayer();
    initRecorder();
  }

  @override
  void dispose() {
    super.dispose();
    for (final recorder in recorders) {
      recorder.closeRecorder();
    }
    for (final player in players) {
      player.closePlayer();
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MysViewModel>(context);
    final navProvider = Provider.of<NavProvider>(context);
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 16,
            ),
            Text(
              "영상을 다시 듣고",
              style: BlaTxt.txt20R,
            ),
            Text(
              "직접 따라하며 연습해보세요!",
              style: BlaTxt.txt20B.copyWith(color: BlaColor.orange),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: MysContentVideoWidget(
                    contentUrl: "https://youtu.be/u-vHrjoO6n4",
                    startAt: 263, //62,
                    endAt: 288,
                  )),
            ),
            Text(
              "I’ll be there soon",
              style: BlaTxt.txt24B,
            ),
            const SizedBox(height: 8),
            Text(
              "나 곧 도착할 것 같아!",
              style: BlaTxt.txt14R.copyWith(color: BlaColor.grey700),
            ),
            const SizedBox(height: 40),
            Wrap(
              spacing: 40,
              children: List.generate(
                  3,
                  (idx) => GestureDetector(
                        onTap: () {
                          switch (statuses[idx]) {
                            case RecordStatus.beforeRecord:
                              startRecord(idx);
                              setState(() {
                                statuses[idx] = RecordStatus.isRecording;
                              });
                              break;
                            case RecordStatus.isRecording:
                              stopRecord(idx).then((path) {
                                viewModel.setRecordPath(idx, path!);
                                setState(() {
                                  statuses[idx] = RecordStatus.afterRecord;
                                });
                              });
                              break;
                            case RecordStatus.afterRecord:
                              startPlay(idx, viewModel.recordPathes[idx]);
                              setState(() {
                                statuses[idx] = RecordStatus.isPlaying;
                              });
                              break;
                            case RecordStatus.isPlaying:
                              stopPlay(idx);
                              setState(() {
                                statuses[idx] = RecordStatus.afterRecord;
                              });
                              break;
                          }
                        },
                        child: MysContentRecordWidget(status: statuses[idx]),
                      )),
            )
          ],
        ),
      ),
      bottomSheet: statuses.where((e) => e != RecordStatus.afterRecord).isEmpty
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
                  viewModel.uploadRecords().then((value) {
                    if (value) {
                      navProvider.changeIdx(2);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const Main()),
                          (route) => true);
                    } else {
                      showToast("업로드 실패. 다시 시도해주세요");
                    }
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: BlaColor.orange,
                  ),
                  child: Text("완료",
                      style: BlaTxt.txt16B.copyWith(color: BlaColor.white)),
                ),
              ),
            )
          : null,
    );
  }
}
