import 'package:blabla/models/emoji_name_tag.dart';
import 'package:blabla/utils/datetime_to_str.dart';

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

class UserProfile {
  String nickname;
  String description;
  String profileImage;
  DateTime birthDate;
  String gender;
  String countryCode;
  int korLevel;
  int engLevel;
  int signedUpAfter;
  List<EmojiNameTag> keywords;

  UserProfile({
    required this.nickname,
    required this.description,
    required this.profileImage,
    required this.birthDate,
    required this.gender,
    required this.countryCode,
    required this.korLevel,
    required this.engLevel,
    required this.signedUpAfter,
    required this.keywords,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        nickname: json["nickname"],
        description: json["description"],
        profileImage: json["profileImage"],
        birthDate: DateTime.parse(json["birthDate"]),
        gender: json["gender"],
        countryCode: json["countryCode"],
        korLevel: json["korLevel"],
        engLevel: json["engLevel"],
        signedUpAfter: json["signedUpAfter"],
        keywords: List<EmojiNameTag>.from(
            json["keywords"].map((x) => EmojiNameTag.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "profileImage": profileImage,
        "nickname": nickname,
        "birthDate": datetimeToStr(birthDate, StrDatetimeType.hypenDelOnlyDate),
        "gender": gender,
        "countryCode": countryCode,
        "korLevel": korLevel,
        "engLevel": engLevel,
      };
}
