class UserProfile {
  String nickname;
  String profileImage;
  String language;

  UserProfile({
    required this.nickname,
    required this.profileImage,
    required this.language,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
      nickname: json["nickname"],
      profileImage: json["profileImage"].toString().toLowerCase(),
      language: json["learningLanguage"]);
  
  Map<String, dynamic> toJson() => {
    "nickname": nickname,
    "profileImage": profileImage,
    "learningLanguage": language,
  };
}
