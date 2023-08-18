class Agora {
  String token;
  int expiresIn;
  int reportId;

  Agora({
    required this.token,
    required this.expiresIn,
    required this.reportId,
  });

  factory Agora.fromJson(Map<String, dynamic> json) => Agora(
        token: json["token"],
        expiresIn: json["expiresIn"],
        reportId: json["reportId"],
      );
}
