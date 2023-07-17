class User {
  final String socialLoginType;
  final String profileImg;
  final String nickname;
  final String birthdate;
  final String gender;
  final String countryCode;
  final int korLevel;
  final int engLevel;
  final List<String> keywords;
  final bool pushNotification;

  const User({
    required this.socialLoginType,
    required this.profileImg,
    required this.nickname,
    required this.birthdate,
    required this.gender,
    required this.countryCode,
    required this.korLevel,
    required this.engLevel,
    required this.keywords,
    required this.pushNotification,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        socialLoginType: json["socialLoginType"],
        profileImg: json["profileImage"],
        nickname: json["nickname"],
        birthdate: json["birthDate"],
        gender: json["gender"],
        countryCode: json["countryCode"],
        korLevel: json["korLevel"],
        engLevel: json["engLevel"],
        keywords: List<String>.from(json["keywords"].map((x) => x)),
        pushNotification: json["pushNotification"],
      );

  Map<String, dynamic> toJson() => {
        "socialLoginType": socialLoginType,
        "profileImage": profileImg,
        "nickname": nickname,
        "birthDate": birthdate,
        "gender": gender,
        "countryCode": countryCode,
        "korLevel": korLevel,
        "engLevel": engLevel,
        "keywords": List<dynamic>.from(keywords.map((x) => x)),
        "pushNotification": pushNotification,
      };
}
