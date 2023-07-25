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
        profiles: List<String>.from(json["profiles"].map((x) => x)),
      );
}
