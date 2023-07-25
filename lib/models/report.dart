import 'package:blabla/models/member.dart';

class Report {
  int id;
  List<MemberSimple> members;
  DateTime createdAt;
  String durationTime;

  Report({
    required this.id,
    required this.members,
    required this.createdAt,
    required this.durationTime,
  });

  factory Report.fromJson(Map<String, dynamic> json) => Report(
        id: json["id"],
        members:
            List<MemberSimple>.from(json["members"].map((x) => MemberSimple.fromJson(x))),
        createdAt: DateTime.parse(json["info"]["createdAt"]),
        durationTime: json["info"]["durationTime"],
      );
}
