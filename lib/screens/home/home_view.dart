import 'package:blabla/screens/home/crew_list_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(
                      settings: RouteSettings(name: "/CrewListView"),
                      builder: (context) => CrewListView()));
              },
              child: Text("하이")),
          Text("임시홈"),
        ],
      ),
    ),
    );
  }
}
