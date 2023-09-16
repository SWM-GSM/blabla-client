import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:blabla/widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:blabla/models/report.dart' as report;

class ReportFeedbackWidget extends StatelessWidget {
  const ReportFeedbackWidget({super.key, required this.feedback});
  final report.Feedback feedback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileWidget(
            profileSize: 24,
            profile: feedback.profileImage,
            bgSize: 48,
            bgColor: BlaColor.lightOrange,
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  feedback.nickname,
                  style: BlaTxt.txt14M,
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                          bottomLeft: Radius.circular(16)),
                      color: BlaColor.grey200),
                  child: Text(
                    feedback.comment,
                    style: BlaTxt.txt14R.copyWith(
                      overflow: TextOverflow.visible,
                    ),
                    softWrap: true,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
