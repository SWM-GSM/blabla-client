import 'package:blabla/models/emoji_name_tag.dart';

class Interest {
  final String category;
  final List<EmojiNameTag> keywords;

  const Interest({
    required this.category,
    required this.keywords,
  });

  factory Interest.fromJson(Map<dynamic, dynamic> json) {
    return Interest(
      category: json["category"],
      keywords: (json["keyword"] as List).map((e) => EmojiNameTag.fromJson(e)).toList()
    );
  }
}