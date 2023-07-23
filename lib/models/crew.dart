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

class Crew {
    int id;
    String name;
    int maxNum;
    int currentNum;
    int korLevel;
    int engLevel;
    bool autoApproval;
    String coverUrl;
    String createdAt;
    List<String> tags;

    Crew({
        required this.id,
        required this.name,
        required this.maxNum,
        required this.currentNum,
        required this.korLevel,
        required this.engLevel,
        required this.autoApproval,
        required this.coverUrl,
        required this.createdAt,
        required this.tags,
    });

    factory Crew.fromJson(Map<String, dynamic> json) => Crew(
        id: json["id"],
        name: json["name"],
        maxNum: json["maxNum"],
        currentNum: json["currentNum"],
        korLevel: json["korLevel"],
        engLevel: json["engLevel"],
        autoApproval: json["autoApproval"],
        coverUrl: json["coverUrl"],
        createdAt: json["createdAt"],
        tags: List<String>.from(json["tags"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "maxNum": maxNum,
        "currentNum": currentNum,
        "korLevel": korLevel,
        "engLevel": engLevel,
        "autoApproval": autoApproval,
        "coverUrl": coverUrl,
        "createdAt": createdAt,
        "tags": List<dynamic>.from(tags.map((x) => x)),
    };
}
