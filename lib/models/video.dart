import 'dart:convert';

Video contentFromJson(String str) => Video.fromJson(json.decode(str));

class Video {
  int id;
  String title;
  String description;
  String thumbnailUrl;
  bool isCompleted;

  Video({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.isCompleted,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        thumbnailUrl: json["thumbnailUrl"],
        isCompleted: json["isCompleted"],
      );
}

class VideoDetail {
  String title;
  String description;
  String guideSentence;
  String targetSentence;
  String contentUrl;
  int startedAtSec;
  int stoppedAtSec;
  int endedAtSec;

  VideoDetail({
    required this.title,
    required this.description,
    required this.guideSentence,
    required this.targetSentence,
    required this.contentUrl,
    required this.startedAtSec,
    required this.stoppedAtSec,
    required this.endedAtSec,
  });

  factory VideoDetail.fromJson(Map<String, dynamic> json) => VideoDetail(
        title: json["title"],
        description: json["description"],
        guideSentence: json["guideSentence"],
        targetSentence: json["targetSentence"],
        contentUrl: json["contentUrl"],
        startedAtSec: json["startedAtSec"],
        stoppedAtSec: json["stoppedAtSec"],
        endedAtSec: json["endedAtSec"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "guideSentence": guideSentence,
        "targetSentence": targetSentence,
        "contentUrl": contentUrl,
        "startedAtSec": startedAtSec,
        "stoppedAtSec": stoppedAtSec,
        "endedAtSec": endedAtSec,
      };
}
