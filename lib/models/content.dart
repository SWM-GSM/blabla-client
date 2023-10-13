import 'package:blabla/models/video.dart';

class Content {
  int id;
  String title;
  String description;
  String thumbnailUrl;
  double progress;

  Content({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.progress,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        thumbnailUrl: json["thumbnailUrl"],
        progress: json["progress"],
      );
}

class ContentDetail {
  String title;
  String description;
  String thumbnailUrl;
  List<Video> contentDetails;

  ContentDetail({
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.contentDetails,
  });

  factory ContentDetail.fromJson(Map<String, dynamic> json) => ContentDetail(
        title: json["title"],
        description: json["description"],
        thumbnailUrl: json["thumbnailUrl"],
        contentDetails: List<Video>.from(
            json["contentDetails"].map((x) => Video.fromJson(x))),
      );
}
