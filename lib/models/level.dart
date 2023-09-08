class Level {
  final int degree;
  final String desc;
  
  const Level({
    required this.degree,
    required this.desc,
  });

  factory Level.fromJson(Map<dynamic, dynamic> json) {
    return Level(
      degree: json["degree"],
      desc: json["description"],
    );
  }
}