class CrewTag {
  final String name;
  final String emoji;
  final String tag;
  
  const CrewTag({
    required this.name,
    required this.emoji,
    required this.tag,
  });

  factory CrewTag.fromJson(Map<String, dynamic> json) {
    return CrewTag(
      name: json["name"],
      emoji: json["emoji"],
      tag: json["tag"],
    );
  }
}