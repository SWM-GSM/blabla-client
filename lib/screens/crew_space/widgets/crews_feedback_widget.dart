import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:blabla/widgets/profile_widget.dart';
import 'package:flutter/material.dart';

class CrewsFeedbackWidget extends StatelessWidget {
  const CrewsFeedbackWidget({super.key, required this.profile});
  final String profile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileWidget(
            profileSize: 24,
            profile: profile,
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
                  "Bernardo",
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
                    "민감자는 조금 배가 고픈 것 같은 목소리네요 좀 더 자신감있게 말해도 될 것 같아요!",
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
