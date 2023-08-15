import 'dart:convert';

Content contentFromJson(String str) => Content.fromJson(json.decode(str));

class Content {
  int id;
  String contentName;
  String genre;
  String topic;
  String thumbnailUrl;
  bool isCompleted;

  Content({
    required this.id,
    required this.contentName,
    required this.genre,
    required this.topic,
    required this.thumbnailUrl,
    required this.isCompleted,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json["id"],
        contentName: json["contentName"],
        genre: json["genre"],
        topic: json["topic"],
        thumbnailUrl: json["thumbnailUrl"],
        isCompleted: json["isCompleted"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "contentName": contentName,
        "genre": genre,
        "topic": topic,
        "thumbnailUrl": thumbnailUrl,
        "isCompleted": isCompleted,
    };
}

class ContentDetail {
    String contentUrl;
    int startedAtSec;
    int stoppedAtSec;
    int endAtSec;
    String sentence;
    String answer;
    String topic;
    String contentName;
    String genre;

    ContentDetail({
        required this.contentUrl,
        required this.startedAtSec,
        required this.stoppedAtSec,
        required this.endAtSec,
        required this.sentence,
        required this.answer,
        required this.topic,
        required this.contentName,
        required this.genre,
    });

    factory ContentDetail.fromJson(Map<String, dynamic> json) => ContentDetail(
        contentUrl: json["contentUrl"],
        startedAtSec: json["startedAtSec"],
        stoppedAtSec: json["stoppedAtSec"],
        endAtSec: json["endAtSec"],
        sentence: json["sentence"],
        answer: json["answer"],
        topic: json["topic"],
        contentName: json["contentName"],
        genre: json["genre"],
    );

    Map<String, dynamic> toJson() => {
        "contentUrl": contentUrl,
        "startedAtSec": startedAtSec,
        "stoppedAtSec": stoppedAtSec,
        "endAtSec": endAtSec,
        "sentence": sentence,
        "answer": answer,
        "topic": topic,
        "contentName": contentName,
        "genre": genre,
    };
}
