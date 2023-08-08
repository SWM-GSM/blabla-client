import 'package:blabla/screens/my_space/widgets/mys_category_widget.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:flutter/material.dart';

class MysMainView extends StatelessWidget {
  const MysMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        title: Text(
          "마이 스페이스",
          style: BlaTxt.txt18B,
        ),
        backgroundColor: BlaColor.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(5, (index) =>const MysCategoryWidget())
        ),
      )
    );
  }
}
