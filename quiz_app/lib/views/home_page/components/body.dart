import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/views/home_page/components/category.dart';
import 'package:quiz_app/views/home_page/components/manager.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

final _pageOption = [
  CategoryPage(),
  ManagerPage(),
];

class _BodyState extends State<Body> {
  GlobalKey _bottomNavigationKey = GlobalKey();
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: _pageOption[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        height: 50,
        backgroundColor: Colors.purple[50],
        animationDuration: Duration(milliseconds: 200),
        animationCurve: Curves.bounceInOut,
        items: <Widget>[
          Icon(
            Icons.apps,
            size: 30,
          ),
          Icon(
            Icons.settings,
            size: 30,
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
