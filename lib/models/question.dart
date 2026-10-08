class Question {
  final String category;
  final String text;
  final List<String> options;
  final int correctIndex;
  final String explanation;

  const Question({
    required this.category,
    required this.text,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });
}