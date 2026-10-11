import 'package:flutter/foundation.dart';
import '../data/dummy_questions.dart';
import '../models/question.dart';

class QuizProvider extends ChangeNotifier {
  final List<Question> questions = dummyQuestions;

  String userName = '';
  int currentIndex = 0;
  late List<int?> _answers;

  QuizProvider() {
    _answers = List.filled(questions.length, null);
  }

  int get totalQuestions => questions.length;
  Question get currentQuestion => questions[currentIndex];

  int? get selectedAnswer => _answers[currentIndex];
  bool get isAnswered => selectedAnswer != null;
  bool get isFirst => currentIndex == 0;
  bool get isLast => currentIndex == questions.length - 1;

  bool isCorrectAt(int i) => _answers[i] == questions[i].correctIndex;

  List<bool?> get results => [
    for (int i = 0; i < questions.length; i++)
      _answers[i] == null ? null : isCorrectAt(i),
  ];

  int get score => List.generate(questions.length, isCorrectAt)
      .where((benar) => benar)
      .length;

  int get percentage => (score / totalQuestions * 100).round();

  String get rank {
    if (percentage >= 90) return 'Master Developer';
    if (percentage >= 70) return 'Senior Developer';
    if (percentage >= 40) return 'Junior Developer';
    return 'pemula';
  }

  void setUserName(String name) {
    userName = name.trim();
    notifyListeners();
  }

  void selectAnswer(int optionIndex) {
    if (isAnswered) return;
    _answers[currentIndex] = optionIndex;
    notifyListeners();
  }

  void next() {
    if (!isLast) {
      currentIndex++;
      notifyListeners();
    }
  }

  void previous() {
    if (!isFirst) {
      currentIndex--;
      notifyListeners();
    }
  }

  void restart() {
    currentIndex = 0;
    _answers = List.filled(questions.length, null);
    notifyListeners();
  }
}