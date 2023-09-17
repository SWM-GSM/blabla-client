import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ProfileSettingTermView extends StatelessWidget {
  const ProfileSettingTermView(
      {super.key, required this.title, required this.url});
  final String title;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 64,
          title: Text(
            title,
            style: BlaTxt.txt18B,
          ),
          backgroundColor: BlaColor.white,
          elevation: 0,
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SvgPicture.asset(
                "assets/icons/ic_32_arrow_left.svg",
                width: 24,
                height: 24,
              ),
            ),
          ),
          leadingWidth: 64,
          actions: [
            Container(
              width: 64,
              color: Colors.transparent,
            ),
          ],
        ),
        body: SafeArea(
          child: WebViewWidget(
            controller: WebViewController()
              ..loadRequest(Uri.parse(url))
              ..setJavaScriptMode(JavaScriptMode.unrestricted),
          ),
        ));
  }
}
