import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:flutter/material.dart';

class SettingBoxWidget extends StatelessWidget {
  const SettingBoxWidget({super.key, required this.widgets, this.title = ""});
  final String title;
  final List<Widget> widgets;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != "")
          Text(
            title,
            style: BlaTxt.txt14M.copyWith(color: BlaColor.grey700),
          ),
        if (title != "")
          const SizedBox(
            height: 8,
          ),
        Container(
          decoration: BoxDecoration(
            color: BlaColor.grey100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListView.builder(
              itemBuilder: ((context, index) => Column(
                    children: [
                      widgets[index],
                      if (index != widgets.length - 1)
                        const Divider(
                          color: BlaColor.grey300,
                          height: 1,
                          thickness: 1,
                          indent: 8,
                          endIndent: 8,
                        )
                    ],
                  )),
              itemCount: widgets.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics()),
        ),
      ],
    );
  }
}
