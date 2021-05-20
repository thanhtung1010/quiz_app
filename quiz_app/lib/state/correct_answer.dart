import 'package:flutter/material.dart';

class CorrectAns with ChangeNotifier {
  List<String> correctAnswerList = [];

  get() => correctAnswerList;
  set(List<String> _correctAnswerList) =>
      correctAnswerList = _correctAnswerList;

  void addAnswer({String correctAnswer}) {
    String asnwer = correctAnswer;
    correctAnswerList.add(asnwer);
    notifyListeners();
  }

  void restartAnswer() {
    correctAnswerList = [];
    notifyListeners();
  }
}
