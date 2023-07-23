import 'package:blabla/models/member.dart';

class CrewSimple {
  final int id;
  final String name;
  final int maxNum;
  final int currentNum; 
  final String coverImage;

  CrewSimple({required this.id, required this.name, required this.maxNum, required this.currentNum, required this.coverImage});

  factory CrewSimple.fromJson(Map<String, dynamic> json) => CrewSimple(
        id: json["id"],
        name: json["name"],
        maxNum: json["maxNum"],
        currentNum: json["currentNum"],
        coverImage: json["coverImage"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "maxNum": maxNum,
        "currentNum": currentNum,
        "coverImage": coverImage,
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
    String coverImage;
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
        required this.coverImage,
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
        coverImage: json["coverImage"],
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
        "coverImage": coverImage,
        "createdAt": createdAt,
        "tags": List<dynamic>.from(tags.map((x) => x)),
    };
}

class CrewDetail {
    String name;
    String description;
    String meetingCycle;
    int maxNum;
    int currentNum;
    int korLevel;
    String korLevelText;
    int engLevel;
    String engLevelText;
    String preferMember;
    String detail;
    bool autoApproval;
    String coverImage;
    List<Member> members;
    List<String> tags;

    CrewDetail({
        required this.name,
        required this.description,
        required this.meetingCycle,
        required this.maxNum,
        required this.currentNum,
        required this.korLevel,
        required this.korLevelText,
        required this.engLevel,
        required this.engLevelText,
        required this.preferMember,
        required this.detail,
        required this.autoApproval,
        required this.coverImage,
        required this.members,
        required this.tags,
    });

    factory CrewDetail.fromJson(Map<String, dynamic> json) => CrewDetail(
        name: json["name"],
        description: json["description"],
        meetingCycle: json["meetingCycle"],
        maxNum: json["maxNum"],
        currentNum: json["currentNum"],
        korLevel: json["korLevel"],
        korLevelText: json["korLevelText"],
        engLevel: json["engLevel"],
        engLevelText: json["engLevelText"],
        preferMember: json["preferMember"],
        detail: json["detail"],
        autoApproval: json["autoApproval"],
        coverImage: json["coverImage"],
        members: List<Member>.from(json["members"].map((x) => Member.fromJson(x))),
        tags: List<String>.from(json["tags"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "meetingCycle": meetingCycle,
        "maxNum": maxNum,
        "currentNum": currentNum,
        "korLevel": korLevel,
        "korLevelText": korLevelText,
        "engLevel": engLevel,
        "engLevelText": engLevelText,
        "preferMember": preferMember,
        "detail": detail,
        "autoApproval": autoApproval,
        "coverImage": coverImage,
        "members": List<dynamic>.from(members.map((x) => x.toJson())),
        "tags": List<dynamic>.from(tags.map((x) => x)),
    };
}