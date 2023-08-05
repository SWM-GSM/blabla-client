import 'dart:convert';

class User {
  final String socialLoginType;
  final String profileImage;
  final String nickname;
  final String birthDate;
  final String gender;
  final String countryCode;
  final int korLevel;
  final int engLevel;
  final List<String> keywords;
  final bool pushNotification;

  const User({
    required this.socialLoginType,
    required this.profileImage,
    required this.nickname,
    required this.birthDate,
    required this.gender,
    required this.countryCode,
    required this.korLevel,
    required this.engLevel,
    required this.keywords,
    required this.pushNotification,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        socialLoginType: json["socialLoginType"],
        profileImage: json["profileImage"],
        nickname: json["nickname"],
        birthDate: json["birthDate"],
        gender: json["gender"],
        countryCode: json["countryCode"],
        korLevel: json["korLevel"],
        engLevel: json["engLevel"],
        keywords: List<String>.from(json["keywords"].map((x) => x)),
        pushNotification: json["pushNotification"],
      );

  Map<String, dynamic> toJson() => {
        "socialLoginType": socialLoginType,
        "profileImage": profileImage,
        "nickname": nickname,
        "birthDate": birthDate,
        "gender": gender,
        "countryCode": countryCode,
        "korLevel": korLevel,
        "engLevel": engLevel,
        "keywords": List<dynamic>.from(keywords.map((x) => x)),
        "pushNotification": pushNotification,
      };
}

class UserSimple {
    String profileImage;
    String nickname;
    int korLevel;
    int engLevel;
    int signedUpAfter;
    String countryCode;
    String description;

    UserSimple({
        required this.profileImage,
        required this.nickname,
        required this.korLevel,
        required this.engLevel,
        required this.signedUpAfter,
        required this.countryCode,
        required this.description,
    });

    factory UserSimple.fromJson(Map<String, dynamic> json) => UserSimple(
        profileImage: json["profileImage"],
        nickname: json["nickname"],
        korLevel: json["korLevel"],
        engLevel: json["engLevel"],
        signedUpAfter: json["signedUpAfter"],
        countryCode: json["countryCode"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "profileImage": profileImage,
        "nickname": nickname,
        "korLevel": korLevel,
        "engLevel": engLevel,
        "signedUpAfter": signedUpAfter,
        "countryCode": countryCode,
        "description": description,
    };
}
