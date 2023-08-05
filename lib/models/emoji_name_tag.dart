class EmojiNameTag {
  final String name;
  final String emoji;
  final String tag;
  
  const EmojiNameTag({
    required this.name,
    required this.emoji,
    required this.tag,
  });

  factory EmojiNameTag.fromJson(Map<String, dynamic> json) {
    return EmojiNameTag(
      name: json["name"],
      emoji: json["emoji"],
      tag: json["tag"],
    );
  }
}