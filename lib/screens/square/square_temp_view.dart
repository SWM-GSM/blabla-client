import 'package:blabla/main.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SquareTempView extends StatelessWidget {
  const SquareTempView({super.key, required this.txt});
  final String txt;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Main()),
                (route) => false);
          },
          child: SvgPicture.asset("assets/icons/ic_24_dismiss.svg", width: 24, height: 24,),
        ),
        title: Text("임시"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Text(txt,
              style: BlaTxt.txt10BK.copyWith(overflow: TextOverflow.visible)),
        ),
      ),
    );
  }
}
