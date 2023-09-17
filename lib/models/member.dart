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
        profileImage: json["profileImage"].toString().toLowerCase(),
    );
}

