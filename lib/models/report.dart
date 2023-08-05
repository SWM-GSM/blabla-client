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
        members: List<MemberSimple>.from(
            json["members"].map((x) => MemberSimple.fromJson(x))),
        createdAt: DateTime.parse(json["info"]["createdAt"]),
        durationTime: json["info"]["durationTime"],
      );
}

class ReportDetail {
  DateTime createdAt;
  String durationTime;
  List<MemberSimple> members;
  String bubbleChart;
  List<Word> words;
  double korRatio;
  double engRatio;
  List<Feedback> feedbacks;

  ReportDetail({
    required this.createdAt,
    required this.durationTime,
    required this.members,
    required this.bubbleChart,
    required this.words,
    required this.korRatio,
    required this.engRatio,
    required this.feedbacks,
  });

  factory ReportDetail.fromJson(Map<String, dynamic> json) => ReportDetail(
        createdAt: DateTime.parse(json["info"]["createdAt"]),
        durationTime: json["info"]["durationTime"],
        members: List<MemberSimple>.from(
            json["members"].map((x) => MemberSimple.fromJson(x))),
        bubbleChart: json["bubbleChart"],
        words: List<Word>.from(
            json["keyword"].map((x) => Word.fromJson(x))),
        korRatio: json["languageRatio"]["korean"],
        engRatio: json["languageRatio"]["english"],
        feedbacks: List<Feedback>.from(
            json["feedbacks"].map((x) => Feedback.fromJson(x))),
      );
}

class Feedback {
  String nickname;
  String profileImage;
  String comment;

  Feedback({
    required this.nickname,
    required this.profileImage,
    required this.comment,
  });

  factory Feedback.fromJson(Map<String, dynamic> json) => Feedback(
        nickname: json["nickname"],
        profileImage: json["profileImage"],
        comment: json["comment"],
      );
}

class Word {
  String name;
  int count;

  Word({
    required this.name,
    required this.count,
  });

  factory Word.fromJson(Map<String, dynamic> json) => Word(
        name: json["name"],
        count: json["count"],
      );
}
