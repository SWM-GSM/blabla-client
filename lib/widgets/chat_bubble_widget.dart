import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:flutter/material.dart';

enum ChatBubbleType { receiver, sender }

class ChatBubbleWidget extends StatelessWidget {
  const ChatBubbleWidget(
      {super.key, required this.type, required this.txt, this.isFirst = false});
  final ChatBubbleType type;
  final String txt;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ChatBubbleType.sender:
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.66,
              ),
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: BlaColor.orange,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(4)),
              ),
              child: Text(
                txt,
                style: BlaTxt.txt14M.copyWith(color: BlaColor.white),
                textAlign: TextAlign.end,
                maxLines: null,
              ),
            ),
          ],
        );
      case ChatBubbleType.receiver:
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isFirst
                ? Image.asset("assets/imgs/img_140_logo.png", width: 40, height: 40)
                : const SizedBox(width: 40),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isFirst) Text("BlaBla", style: BlaTxt.txt14M),
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
                  child: Text(txt,
                      style: BlaTxt.txt14M.copyWith(color: BlaColor.grey900)),
                ),
              ],
            ),
          ],
        );
    }
  }
}
