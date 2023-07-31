class Country {
  final String name;
  final String code;
  final String flag;
  
  const Country({
    required this.name,
    required this.code,
    required this.flag,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json["name"],
      code: json["iso2"],
      flag: json["unicodeFlag"],
    );
  }
}