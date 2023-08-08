import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MysContentTileWidget extends StatelessWidget {
  const MysContentTileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: BlaColor.grey100,
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ExtendedImage.network(
                  "https://img.youtube.com/vi/GsEjIrO1jnM/mqdefault.jpg",
                  fit: BoxFit.cover,
                  shape: BoxShape.rectangle,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "에니메이션 - 아이스 베어",
                      style: BlaTxt.txt12R.copyWith(color: BlaColor.grey700),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      "시간 약속 정하기",
                      style: BlaTxt.txt14SB,
                    ),
                  ],
                ),
              )
            ],
          ),
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
      ),
    );
  }
}
