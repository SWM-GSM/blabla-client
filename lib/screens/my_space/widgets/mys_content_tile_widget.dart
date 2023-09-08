import 'package:blabla/models/content.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MysContentTileWidget extends StatelessWidget {
  const MysContentTileWidget({super.key, required this.content});
  final Content content;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            width: (MediaQuery.of(context).size.width - 50) / 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: BlaColor.grey100,
            )),
        SizedBox(
          width: MediaQuery.of(context).size.width - 50 / 2,
          height: (MediaQuery.of(context).size.width - 50) / 2 / 170 * 108,
          child: ExtendedImage.network(
            content.thumbnailUrl,
            fit: BoxFit.fitWidth,
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(12),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${content.genre} - ${content.contentName}",
                      style: BlaTxt.txt12R.copyWith(color: BlaColor.grey700),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      content.topic,
                      style: BlaTxt.txt14SB,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        if (content.isCompleted)
          Positioned(
              top: 10,
              left: 10,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: BlaColor.orange,
                ),
                child: SvgPicture.asset(
                  "assets/icons/ic_16_check.svg",
                  width: 16,
                  height: 16,
                ),
              ))
      ],
    );
  }
}
