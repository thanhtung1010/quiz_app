import 'package:flutter/material.dart';

class Question with ChangeNotifier {
  List<String> questionList = [];

  get() => questionList;
  set(List<String> _questionList) => questionList = _questionList;

  void addQuestion({String questionText}) {
    String text = questionText;
    questionList.add(text);
    notifyListeners();
  }

  void restartQuestion() {
    questionList = [];
    notifyListeners();
  }
}
