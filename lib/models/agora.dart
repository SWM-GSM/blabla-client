class Agora {
  String token;
  int expiresIn;
  int reportId;
  String channelId;

  Agora({
    required this.token,
    required this.expiresIn,
    required this.reportId,
    required this.channelId,
  });

  factory Agora.fromJson(Map<String, dynamic> json) => Agora(
        token: json["token"],
        expiresIn: json["expiresIn"],
        reportId: json["reportId"],
        channelId: json["channelName"],
      );
}
