import 'package:flutter/foundation.dart';
import '../data/dummy_questions.dart';
import '../models/question.dart';

class QuizProvider extends ChangeNotifier {
  final List<Question> _questions = dummyQuestions;

  String _userName = '';
  int _currentIndex = 0;
  late List<int?> _answers = List.filled(_questions.length, null);

  String get userName => _userName;
  List<Question> get questions => _questions;
  int get totalQuestions => _questions.length;
  int get currentIndex => _currentIndex;
  Question get currentQuestion => _questions[_currentIndex];
  List<bool?> get results => List.generate(
    _questions.length,
        (i) => _answers[i] == null ? null : isCorrectAt(i),
  );
  int? get selectedAnswer => _answers[_currentIndex];
  bool get isAnswered => selectedAnswer != null;

  bool get isFirst => _currentIndex == 0;
  bool get isLast => _currentIndex == _questions.length - 1;

  int get answeredCount => _answers.where((a) => a != null).length;
  double get progress => (_currentIndex + 1) / _questions.length;

  int get score {
    int total = 0;
    for (int i = 0; i < _questions.length; i++) {
      if (_answers[i] == _questions[i].correctIndex) total++;
    }
    return total;
  }

  int get percentage => ((score / _questions.length) * 100).round();

  String get rank {
    if (percentage >= 90) return 'Master Dev';
    if (percentage >= 70) return 'Senior Dev';
    if (percentage >= 40) return 'Junior Dev';
    return 'Script Kiddie';
  }

  bool isCorrectAt(int index) => _answers[index] == _questions[index].correctIndex;
  int? answerAt(int index) => _answers[index];

  void setUserName(String name) {
    _userName = name.trim();
    notifyListeners();
  }

  void selectAnswer(int optionIndex) {
    if (isAnswered) return;
    _answers[_currentIndex] = optionIndex;
    notifyListeners();
  }

  void next() {
    if (!isLast) {
      _currentIndex++;
      notifyListeners();
    }
  }

  void previous() {
    if (!isFirst) {
      _currentIndex--;
      notifyListeners();
    }
  }

  void restart() {
    _currentIndex = 0;
    _answers = List.filled(_questions.length, null);
    notifyListeners();
  }
}