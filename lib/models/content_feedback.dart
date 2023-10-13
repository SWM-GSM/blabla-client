class ContentFeedback {
  String longFeedback;
  int contextRating;
  String userSentence;
  String targetSentence;

  ContentFeedback({
    required this.longFeedback,
    required this.contextRating,
    required this.userSentence,
    required this.targetSentence,
  });

  factory ContentFeedback.fromJson(Map<String, dynamic> json) =>
      ContentFeedback(
        longFeedback: json["longFeedback"],
        contextRating: json["contextRating"],
        userSentence: json["userSentence"],
        targetSentence: json["targetSentence"],
      );
}
