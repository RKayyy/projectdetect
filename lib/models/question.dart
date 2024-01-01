class Question {
  final String questionText; // Path to the image
  final List<String> options;
  final int correctAnswerIndex;
  final double weight;

  Question({
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
    required this.weight,
  });
}
