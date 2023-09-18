import 'package:equatable/equatable.dart';

class MemberSimple extends Equatable {
  final int id;
  final String nickname;
  final String profileImage;

  const MemberSimple({
    required this.id,
    required this.nickname,
    required this.profileImage
  });

  factory MemberSimple.fromJson(Map<String, dynamic> json) {
    return MemberSimple(
      id: json["id"],
      nickname: json["nickname"],
      profileImage: json["profileImage"].toString().toLowerCase(),
    );
  }

  @override
  List<Object?> get props => [id];
}
