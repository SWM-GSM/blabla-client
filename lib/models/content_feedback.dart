class ContentFeedback {
  String longFeedback;
  int starRating;
  int contextRating;
  String userAnswer;
  String answer;

  ContentFeedback({
    required this.longFeedback,
    required this.starRating,
    required this.contextRating,
    required this.userAnswer,
    required this.answer,
  });

  factory ContentFeedback.fromJson(Map<String, dynamic> json) => ContentFeedback(
        longFeedback: json["longFeedback"],
        starRating: json["starRating"],
        contextRating: json["contextRating"],
        userAnswer: json["userAnswer"],
        answer: json["answer"],
      );
}
