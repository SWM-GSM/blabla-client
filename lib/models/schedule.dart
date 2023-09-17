import 'package:blabla/models/member.dart';

class ScheduleSimple {
  int id;
  String title;
  int dday;
  DateTime meetingTime;
  List<String> profiles;

  ScheduleSimple({
    required this.id,
    required this.title,
    required this.dday,
    required this.meetingTime,
    required this.profiles,
  });

  factory ScheduleSimple.fromJson(Map<String, dynamic> json) => ScheduleSimple(
        id: json["id"],
        title: json["title"],
        dday: json["dday"],
        meetingTime: DateTime.parse(json["meetingTime"]),
        profiles: List<String>.from(
            json["profiles"].map((x) => x.toString().toLowerCase())),
      );
}

class Schedule {
  int id;
  String title;
  DateTime meetingTime;
  List<MemberSimple> members;
  int dday;
  String status;

  Schedule({
    required this.id,
    required this.title,
    required this.meetingTime,
    required this.members,
    required this.dday,
    required this.status,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        id: json["id"],
        title: json["title"],
        meetingTime: DateTime.parse(json["meetingTime"]),
        members: List<MemberSimple>.from(
            json["members"].map((x) => MemberSimple.fromJson(x))),
        dday: json["dday"],
        status: json["status"],
      );
}
