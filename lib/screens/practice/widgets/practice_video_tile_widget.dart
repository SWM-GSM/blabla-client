import 'package:blabla/models/video.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PracticeVideoTileWidget extends StatelessWidget {
  const PracticeVideoTileWidget({super.key, required this.video});
  final Video video;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          width: MediaQuery.of(context).size.width - 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: BlaColor.grey100,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12)),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 40,
                    height: 150,
                    child: ExtendedImage.network(
                      video.thumbnailUrl,
                      fit: BoxFit.cover,
                    ),
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(video.title, style: BlaTxt.txt14SB),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(video.description,
                        style: BlaTxt.txt12R.copyWith(
                            color: BlaColor.grey700,
                            overflow: TextOverflow.visible)),
                  ],
                ),
              )
            ],
          ),
        ),
        if (video.isCompleted)
          Positioned(
              top: 28,
              right: 16,
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
