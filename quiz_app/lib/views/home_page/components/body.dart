import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/routes/authentication_service.dart';
import 'package:quiz_app/views/home_page/components/category.dart';
import 'package:quiz_app/views/home_page/components/infomation_page.dart';
import 'package:quiz_app/views/home_page/components/manager.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  GlobalKey _bottomNavigationKey = GlobalKey();
  int _selectedIndex = 0;
  bool isAdmin;
  FirebaseAuth auth = FirebaseAuth.instance;
  AuthenticationService _auth =
      new AuthenticationService(FirebaseAuth.instance);
  final _pageAdminOption = [
    CategoryPage(),
    ManagerPage(),
  ];
  final _pageUserOption = [
    CategoryPage(),
    InformationPage(),
  ];

  @override
  void initState() {
    super.initState();
    getUserRule();
  }

  getUserRule() async {
    dynamic resultant = await _auth.GetRuleUserById(auth.currentUser.uid);

    if (resultant == null) {
      print('Unable to get rule');
    } else {
      setState(() {
        isAdmin = resultant;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: isAdmin == true
          ? _pageAdminOption[_selectedIndex]
          : _pageUserOption[_selectedIndex],
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
          isAdmin == true
              ? Icon(
                  Icons.settings,
                  size: 30,
                )
              : Icon(
                  Icons.person_outline,
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
