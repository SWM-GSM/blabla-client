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
}
