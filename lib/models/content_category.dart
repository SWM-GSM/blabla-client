import 'package:blabla/models/content.dart';

class ContentCategory {
  String contentName;
  double progress;
  List<Content> contents;

  ContentCategory({
    required this.contentName,
    required this.progress,
    required this.contents,
  });

  factory ContentCategory.fromJson(Map<String, dynamic> json) => ContentCategory(
        contentName: json["contentName"],
        progress: json["progress"],
        contents: List<Content>.from(
            json["contents"].map((x) => Content.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "contentName": contentName,
        "progress": progress,
        "contents": List<dynamic>.from(contents.map((x) => x.toJson())),
      };
}
