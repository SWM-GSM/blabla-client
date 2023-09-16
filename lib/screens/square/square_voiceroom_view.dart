import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:blabla/screens/square/square_temp_view.dart';
import 'package:blabla/screens/square/square_view_model.dart';
import 'package:blabla/screens/square/widgets/voiceroom_profile_widget.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:blabla/utils/change_into_two_digit.dart';
import 'package:blabla/utils/dotenv.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SquareVoiceroomView extends StatefulWidget {
  const SquareVoiceroomView(
      {super.key,
      required this.id,
      required this.token,
      required this.channelId});
  final int id;
  final String token;
  final String channelId;

  @override
  State<SquareVoiceroomView> createState() => _SquareVoiceroomViewState();
}

class _SquareVoiceroomViewState extends State<SquareVoiceroomView> {
  late RtcEngine _engine;
  late String token;
  final recorder = FlutterSoundRecorder();
  String tempTxt = "";

  String tempTxtMake(String defaultTxt, String addTxt) {
    return defaultTxt = "$tempTxt\n$addTxt";
  }

  Future<void> initRecorder() async {
    await recorder.openRecorder();
    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

  Future<void> startRecord() async {
    await recorder.startRecorder(toFile: 'crew.wav');
  }

  Future<String?> stopRecord() async {
    String? path = await recorder.stopRecorder();
    print(path);
    return path;
  }

  Future<void> initAgora() async {
    _engine = await RtcEngine.create(env["AGORA_APP_ID"]);
    await _engine.enableAudio();
    await _engine.setEnableSpeakerphone(true);
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Broadcaster);
    addAgoraEventHandler();
    join();
  }

  void join() async {
    await _engine.leaveChannel();
    await _engine.joinChannel(widget.token, widget.channelId, null, widget.id);
    await startRecord();
    print(widget.token);
    print("TEST - 조인");
    // late List<int> users;
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   users =
    //       Provider.of<CrewsViewModel>(context, listen: false).tempGetUsers();
    //   print("TEST 유저수 체크 ${users.length}");
    // });
  }

  void leave() async {
    late List<int> users;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("TEST - 떠나기");
    });
    await _engine.leaveChannel();
  }

  void addAgoraEventHandler() {
    _engine.setEventHandler(RtcEngineEventHandler(
      error: (code) {
        print("[H-TEST] error: $code");
        setState(() {});
      },
      apiCallExecuted: (error, api, result) {
        print("[H-TEST] apiCallExecuted: $error, $api, $result");
      },
      rejoinChannelSuccess: (channel, uid, elapsed) {
        print("[H-TEST] rejoinChannelSuccess: $channel, $uid, $elapsed");
      },
      joinChannelSuccess: (channel, uid, elapsed) {
        print("[H-TEST] joinChannelSuccess: $channel, $uid, $elapsed");
        setState(() {
          tempTxt = tempTxtMake(
              tempTxt, "[H-TEST] joinChannelSuccess: $channel, $uid, $elapsed");
        });
      },
      userJoined: (uid, elapsed) {
        print("[[H-TEST] userJoined: $uid, $elapsed");
        setState(() {
          tempTxt =
              tempTxtMake(tempTxt, "[[H-TEST] userJoined: $uid, $elapsed");
        });
      },
      leaveChannel: (stats) {
        print("[H-TEST] leaveChannel: ${stats.userCount}");
        setState(() {
          tempTxt =
              tempTxtMake(tempTxt, "[H-TEST] leaveChannel: ${stats.userCount}");
        });
      },
      userOffline: (uid, reason) {
        print("[H-TEST] userOffline: $uid, $reason");
        setState(() {
          tempTxt = tempTxtMake(tempTxt, "[H-TEST] userOffline: $uid, $reason");
        });
      },
    ));
  }

  @override
  void initState() {
    super.initState();
    initRecorder();
    initAgora();
  }

  @override
  void dispose() {
    super.dispose();
    // _users.clear();
    recorder.closeRecorder();
    _engine.leaveChannel();
    _engine.destroy();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SquareViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        backgroundColor: BlaColor.white,
        elevation: 0.0,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "일요일 마다 언어 교환 할...",
              style: BlaTxt.txt18B,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                "6명 참여 중",
                style: BlaTxt.txt12B.copyWith(color: BlaColor.orange),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: GridView.count(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 242),
        mainAxisSpacing: 12,
        crossAxisSpacing: 10,
        crossAxisCount: 2,
        childAspectRatio: 170 / 200,
        children: List.generate(
            6,
            (idx) => VoiceroomProfileWidget(
                  isSpeaker: idx % 2 == 0 ? true : false,
                  isMuted: idx % 2 == 0 ? false : true,
                )),
      )),
      bottomSheet: Container(
        decoration: const BoxDecoration(
          border: Border(
              top: BorderSide(
                  color: BlaColor.grey100,
                  width: 1,
                  strokeAlign: BorderSide.strokeAlignInside)),
          color: BlaColor.white,
        ),
        height: 222 + MediaQuery.of(context).padding.bottom,
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 36,
                margin: const EdgeInsets.symmetric(horizontal: 6),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: BlaColor.grey200,
                ),
                child: Wrap(
                  direction: Axis.horizontal,
                  spacing: 4,
                  children: [
                    CountryFlag.fromCountryCode(
                      "US",
                      width: 20,
                      height: 20,
                    ),
                    Text("14:20", style: BlaTxt.txt14R)
                  ],
                ),
              ),
              Container(
                height: 36,
                margin: const EdgeInsets.symmetric(horizontal: 6),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: BlaColor.grey200,
                ),
                child: Wrap(
                  direction: Axis.horizontal,
                  spacing: 4,
                  children: [
                    CountryFlag.fromCountryCode(
                      "KR",
                      width: 20,
                      height: 20,
                    ),
                    Text("17:23", style: BlaTxt.txt14R)
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Text("음성 통화 중",
              style: BlaTxt.txt16R.copyWith(color: BlaColor.grey700)),
          const SizedBox(
            height: 4,
          ),
          StreamBuilder<RecordingDisposition>(
            stream: recorder.onProgress,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                    "${changeIntoTwoDigit(snapshot.data!.duration.inHours.remainder(60))}:${changeIntoTwoDigit(snapshot.data!.duration.inMinutes.remainder(60))}:${changeIntoTwoDigit(snapshot.data!.duration.inSeconds.remainder(60))}",
                    style: BlaTxt.txt16B);
              } else {
                return Text("00:00:00", style: BlaTxt.txt16B);
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Wrap(
              spacing: 30,
              direction: Axis.horizontal,
              children: [
                voiceBtn("speaker", BlaColor.grey200, () {}),
                voiceBtn("mic_on", BlaColor.grey200, () {}),
                voiceBtn(
                  "call_end",
                  BlaColor.red,
                  () async {
                    leave();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SquareTempView(
                                  txt: tempTxt,
                                )));
                    // Navigator.pop(context);
                    // final path = await stopRecord() ?? "";
                    // print("저장 경로 $path");
                    // if (path != "" && await viewModel.uploadVoiceFile(path)) {
                    //   leave();
                    //   await viewModel.getReports();
                    //   if (context.mounted) {
                    //     Navigator.pop(context);
                    //   } else {
                    //     showToast("파일 업로드에 실패했습니다");
                    //   }
                    // }
                  },
                ),
              ],
            ),
          )
        ]),
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
