class Interest {
  final String category;
  final List<Keyword> keywords;

  const Interest({
    required this.category,
    required this.keywords,
  });

  factory Interest.fromJson(Map<dynamic, dynamic> json) {
    return Interest(
      category: json["category"],
      keywords: (json["keyword"] as List).map((e) => Keyword.fromJson(e)).toList() // Keyword.fromJson(json["keyword"]),
    );
  }
}

class Keyword {
  final String emoji;
  final String name;
  final String tag;

  const Keyword({
    required this.emoji,
    required this.name,
    required this.tag,
  });

  factory Keyword.fromJson(Map<String, dynamic> json) {
    return Keyword(emoji: json["emoji"], name: json["name"], tag: json["tag"]);
  }
}