class History {
  DateTime datetime;
  List<HistoryReport> reports;

  History({
    required this.datetime,
    required this.reports,
  });

  factory History.fromJson(Map<String, dynamic> json) => History(
        datetime: DateTime.parse(json["datetime"]),
        reports: List<HistoryReport>.from(
            json["reports"].map((x) => HistoryReport.fromJson(x))),
      );
}

class HistoryReport {
  int id;
  String type;
  String title;
  String subTitle;

  HistoryReport(
      {required this.id,
      required this.type,
      required this.title,
      required this.subTitle});

  factory HistoryReport.fromJson(Map<String, dynamic> json) => HistoryReport(
        id: json["id"],
        type: json["type"],
        title: json["info"]["title"],
        subTitle: json["info"]["subTitle"],
      );
}
