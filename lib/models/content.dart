import 'dart:convert';

Content contentFromJson(String str) => Content.fromJson(json.decode(str));
String contentToJson(Content data) => json.encode(data.toJson());

class Content {
    String contentUrl;
    int level;
    String sentence;
    String answer;
    String language;
    String topic;
    String title;

    Content({
        required this.contentUrl,
        required this.level,
        required this.sentence,
        required this.answer,
        required this.language,
        required this.topic,
        required this.title,
    });

    factory Content.fromJson(Map<String, dynamic> json) => Content(
        contentUrl: json["contentUrl"],
        level: json["level"],
        sentence: json["sentence"],
        answer: json["answer"],
        language: json["language"],
        topic: json["topic"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "contentUrl": contentUrl,
        "level": level,
        "sentence": sentence,
        "answer": answer,
        "language": language,
        "topic": topic,
        "title": title,
    };
}
