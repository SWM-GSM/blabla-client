import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CrewDetailView extends StatelessWidget {
  const CrewDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 16),
            alignment: Alignment.centerLeft,
            height: 60,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset(
                "assets/icons/ic_32_arrow_left.svg",
                width: 32,
                height: 32,
              ),
            ),
          ),
          Text("크루 상세 페이지 임시")
        ],
      ),
    ));
  }
}
