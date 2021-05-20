import 'package:flutter/material.dart';

class Answered with ChangeNotifier {
  List<String> selectedAnswerList = [];

  get() => selectedAnswerList;
  set(List<String> _selectedAnswerList) =>
      selectedAnswerList = _selectedAnswerList;

  void addAnswer({String selectedAnswer}) {
    String asnwer = selectedAnswer;
    selectedAnswerList.add(asnwer);
    notifyListeners();
  }

  void restartAnswer() {
    selectedAnswerList = [];
    notifyListeners();
  }
}
