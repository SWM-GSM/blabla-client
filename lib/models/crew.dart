import 'package:blabla/models/level.dart';
import 'package:blabla/models/member.dart';

class CrewSimple {
  final int id;
  final String name;
  final int maxNum;
  final int currentNum;
  final String coverImage;

  CrewSimple(
      {required this.id,
      required this.name,
      required this.maxNum,
      required this.currentNum,
      required this.coverImage});

  factory CrewSimple.fromJson(Map<String, dynamic> json) => CrewSimple(
        id: json["id"],
        name: json["name"],
        maxNum: json["maxNum"],
        currentNum: json["currentNum"],
        coverImage: json["coverImage"],
      );
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
}

class CrewDetail {
  String name;
  String description;
  String meetingCycle;
  int maxNum;
  int currentNum;
  Level korLevel;
  Level engLevel;
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
    required this.engLevel,
    required this.preferMember,
    required this.detail,
    required this.autoApproval,
    required this.coverImage,
    required this.members,
    required this.tags,
  });

  factory CrewDetail.fromJson(Map<dynamic, dynamic> json) => CrewDetail(
        name: json["name"],
        description: json["description"],
        meetingCycle: json["meetingCycle"],
        maxNum: json["maxNum"],
        currentNum: json["currentNum"],
        korLevel: Level(
          degree: json["korLevel"],
          desc: json["korLevelText"],
        ),
        engLevel: Level(
          degree: json["engLevel"],
          desc: json["engLevelText"],
        ),
        preferMember: json["preferMember"],
        detail: json["detail"],
        autoApproval: json["autoApproval"],
        coverImage: json["coverImage"],
        members:
            List<Member>.from(json["members"].map((x) => Member.fromJson(x))),
        tags: List<String>.from(json["tags"].map((x) => x)),
      );
}

class CrewToJson {
  String coverImage;
  String name;
  String description;
  String meetingCycle;
  List<String> tags;
  int maxNum;
  int engLevel;
  int korLevel;
  String preferMember;
  String detail;
  bool autoApproval;

  CrewToJson({
    required this.coverImage,
    required this.name,
    required this.description,
    required this.meetingCycle,
    required this.tags,
    required this.maxNum,
    required this.engLevel,
    required this.korLevel,
    required this.preferMember,
    required this.detail,
    required this.autoApproval,
  });

  factory CrewToJson.fromJson(Map<String, dynamic> json) => CrewToJson(
        coverImage: json["coverImage"],
        name: json["name"],
        description: json["description"],
        meetingCycle: json["meetingCycle"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        maxNum: json["maxNum"],
        engLevel: json["engLevel"],
        korLevel: json["korLevel"],
        preferMember: json["preferMember"],
        detail: json["detail"],
        autoApproval: json["autoApproval"],
      );

  Map<String, dynamic> toJson() => {
        "coverImage": coverImage,
        "name": name,
        "description": description,
        "meetingCycle": meetingCycle,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "maxNum": maxNum,
        "engLevel": engLevel,
        "korLevel": korLevel,
        "preferMember": preferMember,
        "detail": detail,
        "autoApproval": autoApproval,
      };
}
