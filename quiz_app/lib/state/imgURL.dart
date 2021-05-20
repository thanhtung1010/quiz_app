import 'package:flutter/material.dart';

class URL with ChangeNotifier {
  List<String> urlList = [];

  get() => urlList;
  set(List<String> _urlList) => urlList = _urlList;

  void addURL({String imgURL}) {
    String url = imgURL;
    urlList.add(url);
    notifyListeners();
  }

  void restartURL() {
    urlList = [];
    notifyListeners();
  }
}
