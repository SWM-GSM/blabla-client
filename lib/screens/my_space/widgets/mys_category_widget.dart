import 'package:blabla/models/content_category.dart';
import 'package:blabla/screens/my_space/mys_content_listening_view.dart';
import 'package:blabla/screens/my_space/mys_view_model.dart';
import 'package:blabla/screens/my_space/widgets/mys_content_tile_widget.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MysCategoryWidget extends StatelessWidget {
  const MysCategoryWidget({super.key, required this.category});
  final ContentCategory category;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MysViewModel>(context);
    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(category.contentName, style: BlaTxt.txt18B),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      category.progress.toString(),
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
                    category.contents.length,
                    (idx) => GestureDetector(
                        onTap: () {
                          viewModel.setContentId(category.contents[idx].id);
                          Navigator.of(context, rootNavigator: true)
                              .push(MaterialPageRoute(
                                  builder: (context) => MysContentListeningView(
                                        contentId: category.contents[idx].id,
                                        category: category.contentName,
                                        topic: category.contents[idx].topic,
                                      )));
                        },
                        child: MysContentTileWidget(
                            content: category.contents[idx])))),
          ],
        ));
  }
}
