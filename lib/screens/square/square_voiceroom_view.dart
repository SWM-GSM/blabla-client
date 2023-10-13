import 'dart:async';
import 'package:audio_session/audio_session.dart';
import 'package:blabla/main.dart';
import 'package:blabla/screens/square/square_feedback_view.dart';
import 'package:blabla/screens/square/square_view_model.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:blabla/utils/change_into_two_digit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class SquareVoiceroomView extends StatefulWidget {
  const SquareVoiceroomView({super.key});
  @override
  State<SquareVoiceroomView> createState() => _SquareVoiceroomViewState();
}

class _SquareVoiceroomViewState extends State<SquareVoiceroomView> {
  bool isMuted = false;
  bool isSpeaker = false;
  late final Timer timer;
  int seconds = 0;
  final recorder = FlutterSoundRecorder();

  Future<void> initRecorder() async {
    await recorder.openRecorder();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        seconds++;
      });
    });
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions:
          AVAudioSessionCategoryOptions.allowBluetooth |
              AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: AVAudioSessionMode.spokenAudio,
      avAudioSessionRouteSharingPolicy:
          AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: const AndroidAudioAttributes(
        contentType: AndroidAudioContentType.speech,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.voiceCommunication,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
      androidWillPauseWhenDucked: true,
    ));
  }

  Future<void> startRecord() async {
    try {
      final dir = (await getTemporaryDirectory()).path;
      await recorder.startRecorder(
        toFile: "$dir/crew.wav",
        codec: Codec.pcm16WAV,
      );
    } catch (e) {
      print("녹음기 켜기 실패");
    }
  }

  Future<String?> stopRecord() async {
    timer.cancel();
    String? path = await recorder.stopRecorder();
    final dir = (await getTemporaryDirectory()).path;
    if (path == "") {
      return "$dir/crew.wav";
    } else {
      return path;
    }
  }

  @override
  void initState() {
    super.initState();
    initRecorder();
    startRecord();
  }

  @override
  void dispose() {
    super.dispose();
    recorder.closeRecorder();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SquareViewModel>(context);
    return WillPopScope(
      onWillPop: () async {
        viewModel.setSelectedDate(DateTime.now());
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 64,
          backgroundColor: BlaColor.white,
          elevation: 0.0,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "voiceRoom".tr(),
                style: BlaTxt.txt18B,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  "${viewModel.voiceroomList!.length}${"participating".tr()}",
                  style: BlaTxt.txt12B.copyWith(color: BlaColor.orange),
                ),
              ),
            ],
          ),
          centerTitle: true,
        ),
        body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(
              bottom: 180 + MediaQuery.of(context).padding.bottom),
          child: Image.asset(
            "assets/imgs/img_240_logo.png",
            width: 300,
            height: 300,
          ),
        ),
        // GridView.count(
        //   padding: const EdgeInsets.fromLTRB(20, 20, 20, 242),
        //   mainAxisSpacing: 12,
        //   crossAxisSpacing: 10,
        //   crossAxisCount: 2,
        //   childAspectRatio: 170 / 200,
        //   children: List.generate(
        //       6,
        //       (idx) => VoiceroomProfileWidget(
        //             isSpeaker: idx % 2 == 0 ? true : false,
        //             isMuted: idx % 2 == 0 ? false : true,
        //           )),
        // ),
        bottomSheet: Container(
          decoration: const BoxDecoration(
            border: Border(
                top: BorderSide(
                    color: BlaColor.grey100,
                    width: 1,
                    strokeAlign: BorderSide.strokeAlignInside)),
            color: BlaColor.white,
          ),
          height: 180 + MediaQuery.of(context).padding.bottom,
          width: MediaQuery.of(context).size.width,
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            const SizedBox(
              height: 28,
            ),
            Text("inVoiceCall".tr(),
                style: BlaTxt.txt16R.copyWith(color: BlaColor.grey700)),
            const SizedBox(
              height: 4,
            ),
            Text(
                "${changeIntoTwoDigit(Duration(seconds: seconds).inHours.remainder(60))}:${changeIntoTwoDigit(Duration(seconds: seconds).inMinutes.remainder(60))}:${changeIntoTwoDigit(Duration(seconds: seconds).inSeconds.remainder(60))}",
                style: BlaTxt.txt16B),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Wrap(
                spacing: 30,
                direction: Axis.horizontal,
                children: [
                  voiceBtn(isSpeaker ? "speaker_on" : "speaker_off",
                      BlaColor.grey200, () {
                    setState(() {
                      isSpeaker = !isSpeaker;
                      viewModel.engine.setEnableSpeakerphone(isSpeaker);
                    });
                  }),
                  voiceBtn(isMuted ? "mic_off" : "mic_on", BlaColor.grey200,
                      () {
                    setState(() {
                      isMuted = !isMuted;
                      viewModel.engine.muteLocalAudioStream(isMuted);
                    });
                  }),
                  voiceBtn(
                    "call_end",
                    BlaColor.red,
                    () async {
                      viewModel.leaveChannel();
                      final path = await stopRecord() ?? "";

                      if (await viewModel.uploadVoiceFile(path) != 0) {
                        // 보이스 파일 업로드 성공
                        if (context.mounted) {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SquareFeedbackView()),
                              (route) => false);
                        }
                        viewModel.makeWithMemberList();
                        await viewModel.getVoiceRoomList();
                        if (viewModel.voiceroomList!.isEmpty) {
                          await viewModel.requestCreateReport();
                        }
                      } else {
                        // 보이스 파일 업로드 실패
                        if (context.mounted) {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const Main()),
                              (route) => false);
                        }
                      }
                    },
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }

  Widget voiceBtn(String icon, Color color, onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        width: 56,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: SvgPicture.asset(
          "assets/icons/ic_24_$icon.svg",
          width: 24,
          height: 24,
        ),
      ),
    );
  }
}
