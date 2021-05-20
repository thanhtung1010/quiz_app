import 'package:flutter/material.dart';

class Answer with ChangeNotifier {
  bool _counter = true;

  get() => _counter;

  set(bool counter) => _counter = counter;

  void changeAnswered() {
    _counter = true;
    notifyListeners();
  }

  void restartAnswered() {
    _counter = false;
    notifyListeners();
  }
}
