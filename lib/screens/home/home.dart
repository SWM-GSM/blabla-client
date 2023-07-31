import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = FlutterSecureStorage();

    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: ElevatedButton(
            onPressed: () async {
              print(await storage.read(key: "accessToken"));
            },
            child: Text("토큰 출력")),
      ),
    ));
  }
}
