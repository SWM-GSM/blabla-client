import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:blabla/screens/crew_space/crews_view_model.dart';
import 'package:blabla/screens/crew_space/widgets/voiceroom_profile_widget.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:blabla/utils/dotenv.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class CrewsVoiceroomView extends StatefulWidget {
  const CrewsVoiceroomView(
      {super.key, required this.token, required this.channelId});
  final String token;
  final String channelId;

  @override
  State<CrewsVoiceroomView> createState() => _CrewsVoiceroomViewState();
}

class _CrewsVoiceroomViewState extends State<CrewsVoiceroomView> {
  late RtcEngine _engine;
  late String token;
  final recorder = FlutterSoundRecorder();

  Future<void> initRecorder() async {
    recorder.openRecorder();
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
    print(widget.channelId);
    await _engine.leaveChannel();
    await _engine.joinChannel(
        "007eJxTYEjzst4bndC+QCL2+Y1vRXO3PBdNTZ4mW7Xm7PkKXZnbXvkKDMaW5gapKeZmyWZpRiaphmZJJhbGZkkWFoYpKSnGacaWCg13UxoCGRl4S5RYGBkgEMRnZ0guSi3XNTRkYAAArWwfYg==",
        widget.channelId,
        null,
        0); // 수정 - 유저 아이디
    await startRecord();
    late List<int> users;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      users =
          Provider.of<CrewsViewModel>(context, listen: false).tempGetUsers();
      print("TEST 유저수 체크 ${users.length}");
    });
  }

  void leave() async {
    late List<int> users;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      users =
          Provider.of<CrewsViewModel>(context, listen: false).tempGetUsers();
      print("TEST - 떠나기");
      print(users.length);
      if (users.length <= 1) {
        print("TEST - 한명 남음");
        Provider.of<CrewsViewModel>(context, listen: false)
            .requestCreateReport();
      }
    });
    await _engine.leaveChannel();
  }

  void addAgoraEventHandler() {
    _engine.setEventHandler(RtcEngineEventHandler(
      error: (code) {
        print("[TEST] error: $code");
        setState(() {});
      },
      joinChannelSuccess: (channel, uid, elapsed) {
        // isActivated
        late List<int> users;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Provider.of<CrewsViewModel>(context, listen: false).addUser(uid);
          users = Provider.of<CrewsViewModel>(context, listen: false)
              .tempGetUsers();
          print("TEST 유저수 체크 ${users.length}");
        });
        print("[TEST] joinChannelSuccess: $channel, $uid, $elapsed, $users");
      },
      userJoined: (uid, elapsed) {
        late List<int> users;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Provider.of<CrewsViewModel>(context, listen: false).addUser(uid);
          users = Provider.of<CrewsViewModel>(context, listen: false)
              .tempGetUsers();
          print("TEST 유저수 체크 ${users.length}");
        });
        print("[TEST] userJoined: $uid, $elapsed, $users");
      },
      leaveChannel: (stats) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Provider.of<CrewsViewModel>(context, listen: false).clearUser();
        });
        print("[TEST] leaveChannel: $stats");
      },
      userOffline: (uid, reason) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Provider.of<CrewsViewModel>(context, listen: false).removeUser(uid);
        });
        print("[TEST] userOffline: $uid, $reason");
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
    final viewModel = Provider.of<CrewsViewModel>(context);
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
          Text("01:23:22", style: BlaTxt.txt16B),
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
                    final path = await stopRecord() ?? "";
                    print("저장 경로 $path");
                    if (path != "" && await viewModel.uploadVoiceFile(path)) {
                      if (context.mounted) {
                        Navigator.pop(context);
                      } else {
                        showToast("파일 업로드에 실패했습니다");
                      }
                    }
                    leave();
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
