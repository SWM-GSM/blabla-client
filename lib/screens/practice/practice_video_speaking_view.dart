import 'package:audioplayers/audioplayers.dart';
import 'package:blabla/main.dart';
import 'package:blabla/providers/nav_provider.dart';
import 'package:blabla/screens/practice/practice_view_model.dart';
import 'package:blabla/screens/practice/widgets/practice_video_record_widget.dart';
import 'package:blabla/screens/practice/widgets/practice_video_widget.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';

class PracticeVideoSpeakingView extends StatefulWidget {
  const PracticeVideoSpeakingView({super.key});

  @override
  State<PracticeVideoSpeakingView> createState() =>
      _PracticeVideoSpeakingViewState();
}

class _PracticeVideoSpeakingViewState extends State<PracticeVideoSpeakingView> {
  late final List<Record> recorders;
  late final List<AudioPlayer> players;
  final statuses = List.generate(3, (idx) => RecordStatus.beforeRecord);
  bool canRecord = true;

  Future<void> initRecorder() async {
    recorders = List.generate(3, (idx) => Record());
  }

  Future<void> initPlayer() async {
    players = List.generate(3, (idx) => AudioPlayer());
    for (var player in players) {
      player = AudioPlayer();
      player.setReleaseMode(ReleaseMode.stop);
    }
  }

  Future<void> startRecord(int idx) async {
    if (await Permission.microphone.status != PermissionStatus.granted) {
      await Permission.microphone.request();
    } else {
      final dir = (await getTemporaryDirectory()).path;
      try {
        await recorders[idx].start(path: "$dir/audio$idx.wav");
      } catch (e) {
        showToast("unableToRecord".tr());
        setState(() {
          canRecord = false;
          statuses[idx] = RecordStatus.beforeRecord;
        });
      }
    }
  }

  Future<String?> stopRecord(int idx) async {
    String? path = await recorders[idx].stop();
    print(path);
    return path;
  }

  void startPlay(int idx, String path) async {
    await players[idx].play(UrlSource(path));
    players[idx].onPlayerComplete.listen((event) {
      setState(() {
        statuses[players.indexOf(players[idx])] = RecordStatus.afterRecord;
      });
    });
  }

  void stopPlay(int idx) async {
    await players[idx].stop();
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
      recorder.dispose();
    }
    for (final player in players) {
      player.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<PracticeViewModel>(context);
    final navProvider = Provider.of<NavProvider>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        title: Text(
          viewModel.video!.title,
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
        actions: [
          Container(
            width: 64,
            color: Colors.transparent,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 16,
            ),
            Text(
              "practiceForListening".tr(),
              style: BlaTxt.txt20R,
            ),
            Text(
              "practiceForRepeating".tr(),
              style: BlaTxt.txt20B.copyWith(color: BlaColor.orange),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: PracticeVideoWidget(
                    contentUrl: viewModel.video!.contentUrl,
                    startAt: viewModel.video!.startedAtSec,
                    endAt: viewModel.video!.endedAtSec,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                viewModel.video!.targetSentence,
                style: BlaTxt.txt24B.copyWith(overflow: TextOverflow.visible),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                viewModel.video!.guideSentence,
                style: BlaTxt.txt14R.copyWith(
                    color: BlaColor.grey700, overflow: TextOverflow.visible),
                textAlign: TextAlign.center,
              ),
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
                        child: PracticeVideoRecordWidget(status: statuses[idx]),
                      )),
            )
          ],
        ),
      ),
      bottomSheet: statuses
                  .where((e) => e != RecordStatus.afterRecord)
                  .isEmpty ||
              canRecord == false
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
                  if (canRecord) {
                    viewModel.uploadRecords().then((value) {
                      if (value) {
                        navProvider.changeIdx(2);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Main()),
                            (route) => false);
                      } else {
                        showToast("failToUpload".tr());
                      }
                    });
                  } else {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const Main()),
                        (route) => false);
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: BlaColor.orange,
                  ),
                  child: Text("complete".tr(),
                      style: BlaTxt.txt16B.copyWith(color: BlaColor.white)),
                ),
              ),
            )
          : null,
    );
  }
}
