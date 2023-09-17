class ContentFeedback {
  String longFeedback;
  int starRating;
  int contextRating;
  String userAnswer;
  String targetSentence;

  ContentFeedback({
    required this.longFeedback,
    required this.starRating,
    required this.contextRating,
    required this.userAnswer,
    required this.targetSentence,
  });

  factory ContentFeedback.fromJson(Map<String, dynamic> json) =>
      ContentFeedback(
        longFeedback: json["longFeedback"],
        starRating: json["starRating"],
        contextRating: json["contextRating"],
        userAnswer: json["userAnswer"],
        targetSentence: json["targetSentence"],
      );
}
