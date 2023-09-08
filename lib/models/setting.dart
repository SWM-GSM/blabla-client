class Setting {
  bool genderDisclosure;
  bool birthDateDisclosure;
  bool pushNotification;

  Setting({
    required this.genderDisclosure,
    required this.birthDateDisclosure,
    required this.pushNotification,
  });

  factory Setting.fromJson(Map<String, dynamic> json) => Setting(
        genderDisclosure: json["genderDisclosure"],
        birthDateDisclosure: json["birthDateDisclosure"],
        pushNotification: json["pushNotification"],
      );
}
