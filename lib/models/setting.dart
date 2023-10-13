class Setting {
  bool pushNotification;

  Setting({
    required this.pushNotification,
  });

  factory Setting.fromJson(Map<String, dynamic> json) => Setting(
        pushNotification: json["pushNotification"],
      );
}
