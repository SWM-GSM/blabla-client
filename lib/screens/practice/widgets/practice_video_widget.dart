import 'package:blabla/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PracticeVideoWidget extends StatefulWidget {
  const PracticeVideoWidget(
      {super.key,
      required this.contentUrl,
      required this.startAt,
      required this.endAt});
  final String contentUrl;
  final int startAt;
  final int endAt;

  @override
  State<PracticeVideoWidget> createState() => _PracticeVideoWidgetState();
}

class _PracticeVideoWidgetState extends State<PracticeVideoWidget> {
  late YoutubePlayerController _videoCtr;
  bool replayBtnOn = false;

  @override
  void initState() {
    super.initState();
    _videoCtr = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.contentUrl)!,
        flags: YoutubePlayerFlags(
          startAt: widget.startAt,
          endAt: widget.endAt,
          autoPlay: false,
          mute: false,
          disableDragSeek: true,
          loop: false,
          isLive: false,
          forceHD: true,
          enableCaption: false,
          hideThumbnail: true,
        ));
  }

  @override
  void dispose() {
    super.dispose();
    _videoCtr.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        YoutubePlayer(
          controller: _videoCtr,
          showVideoProgressIndicator: false,
          onReady: () {
            _videoCtr.addListener(() {
              if (_videoCtr.value.position.inMilliseconds >=
                  widget.endAt * 1000 - 500) {
                _videoCtr.pause();
                setState(() {
                  replayBtnOn = true;
                });
              }
            });
          },
          bottomActions: const [],
        ),
        if (replayBtnOn)
          GestureDetector(
            onTap: () {
              setState(() {
                replayBtnOn = false;
              });
              _videoCtr.seekTo(Duration(seconds: widget.startAt));
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                  color: BlaColor.grey600, shape: BoxShape.circle),
              child: SvgPicture.asset(
                "assets/icons/ic_32_replay.svg",
                width: 32,
                height: 32,
              ),
            ),
          ),
      ],
    );
  }
}
