import 'package:blabla/screens/my_space/mys_content_listening_view.dart';
import 'package:blabla/screens/my_space/widgets/mys_content_tile_widget.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:flutter/material.dart';

class MysCategoryWidget extends StatelessWidget {
  const MysCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("드라마, 도깨비로 한글 배우기", style: BlaTxt.txt18B),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "80",
                      style: BlaTxt.txt18B.copyWith(color: BlaColor.orange),
                    ),
                    Text("%",
                        style: BlaTxt.txt14R.copyWith(color: BlaColor.orange)),
                  ],
                )
              ],
            ),
            Stack(
              children: [
                Container(
                  height: 4,
                  width: MediaQuery.of(context).size.width - 40,
                  margin: const EdgeInsets.only(top: 12, bottom: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: BlaColor.grey100),
                ),
                Positioned(
                  left: 0,
                  child: Container(
                    height: 4,
                    width:
                        (MediaQuery.of(context).size.width - 40) * (80 / 100),
                    margin: const EdgeInsets.only(top: 12, bottom: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: BlaColor.orange),
                  ),
                )
              ],
            ),
            GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                mainAxisSpacing: 12,
                crossAxisSpacing: 10,
                crossAxisCount: 2,
                childAspectRatio: 170 / 172,
                children: List.generate(
                    3,
                    (idx) => GestureDetector(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MysContentListeningView()));
                        },
                        child: MysContentTileWidget()))),
          ],
        ));
  }
}
