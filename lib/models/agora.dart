class Agora {
  String token;
  int expiresIn;
  int? reportId; // 수정 - 임시로 nullable
  // String channelId;

  Agora({
    required this.token,
    required this.expiresIn,
    required this.reportId,
    // required this.channelId,
  });

  factory Agora.fromJson(Map<String, dynamic> json) => Agora(
        token: json["token"],
        expiresIn: json["expiresIn"],
        reportId: json["reportId"],
        // channelId: json["channelName"],
      );
}
