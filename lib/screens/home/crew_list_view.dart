import 'package:blabla/screens/recruit/recruit_profile_view.dart';
import 'package:flutter/material.dart';

class CrewListView extends StatelessWidget {
  const CrewListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(
                        settings: RouteSettings(name: "/RecruitProfileView"),
                        builder: (context) => RecruitProfileView()));
                },
                child: Text("임시 크루 생성 버튼")),
            Text("임시크루리스트"),
          ],
        ),
      ),
    ));
  }
}