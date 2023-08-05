import 'dart:convert';

Member memberFromJson(String str) => Member.fromJson(json.decode(str));

String memberToJson(Member data) => json.encode(data.toJson());

class Member {
    int id;
    String nickname;
    String description;
    String profileImage;
    String countryCode;
    int korLevel;
    int engLevel;
    bool isLeader;

    Member({
        required this.id,
        required this.nickname,
        required this.description,
        required this.profileImage,
        required this.countryCode,
        required this.korLevel,
        required this.engLevel,
        required this.isLeader,
    });

    factory Member.fromJson(Map<dynamic, dynamic> json) => Member(
        id: json["id"],
        nickname: json["nickname"],
        description: json["description"],
        profileImage: json["profileImage"],
        countryCode: json["countryCode"],
        korLevel: json["korLevel"],
        engLevel: json["engLevel"],
        isLeader: json["isLeader"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nickname": nickname,
        "description": description,
        "profileImage": profileImage,
        "countryCode": countryCode,
        "korLevel": korLevel,
        "engLevel": engLevel,
        "isLeader": isLeader,
    };
}

class MemberSimple {
    int id;
    String nickname;
    String profileImage;

    MemberSimple({
        required this.id,
        required this.nickname,
        required this.profileImage,
    });

    factory MemberSimple.fromJson(Map<String, dynamic> json) => MemberSimple(
        id: json["id"],
        nickname: json["nickname"],
        profileImage: json["profileImage"],
    );
}

