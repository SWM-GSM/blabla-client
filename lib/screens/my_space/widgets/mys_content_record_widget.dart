import 'package:blabla/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum RecordStatus {
  beforeRecord,
  isRecording,
  afterRecord,
  isPlaying,
}

class MysContentRecordWidget extends StatelessWidget {
  const MysContentRecordWidget({super.key, required this.status});
  final RecordStatus status;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: BlaColor.lightOrange, width: 4),
            color: switch (status) {
          (RecordStatus.beforeRecord) => BlaColor.white,
          (RecordStatus.isRecording) => BlaColor.white,
          (RecordStatus.afterRecord) => BlaColor.orange,
          (RecordStatus.isPlaying) => BlaColor.lightOrange,
        }),
        child: switch (status) {
          (RecordStatus.beforeRecord) => SvgPicture.asset(
              "assets/icons/ic_24_mic.svg",
              width: 24,
              height: 24,
              colorFilter:
                  const ColorFilter.mode(BlaColor.orange, BlendMode.srcIn),
            ),
          (RecordStatus.isRecording) => SvgPicture.asset(
              "assets/icons/ic_24_stop.svg",
              width: 24,
              height: 24,
              colorFilter:
                  const ColorFilter.mode(BlaColor.orange, BlendMode.srcIn),
            ),
          (RecordStatus.afterRecord) => SvgPicture.asset(
              "assets/icons/ic_24_check.svg",
              width: 24,
              height: 24,
              colorFilter:
                  const ColorFilter.mode(BlaColor.white, BlendMode.srcIn),
            ),
          (RecordStatus.isPlaying) => SvgPicture.asset(
              "assets/icons/ic_24_stop.svg",
              width: 24,
              height: 24,
              colorFilter:
                  const ColorFilter.mode(BlaColor.orange, BlendMode.srcIn),
            ),
        });
  }
}
