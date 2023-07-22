class CrewSimple {
  final int id;
  final String name;
  final int maxNum;
  final int currentNum; 
  final String coverUrl;

  CrewSimple({required this.id, required this.name, required this.maxNum, required this.currentNum, required this.coverUrl});

  factory CrewSimple.fromJson(Map<String, dynamic> json) => CrewSimple(
        id: json["id"],
        name: json["name"],
        maxNum: json["maxNum"],
        currentNum: json["currentNum"],
        coverUrl: json["coverUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "maxNum": maxNum,
        "currentNum": currentNum,
        "coverUrl": coverUrl,
      };
}
