import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/routes/authentication_service.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/views/Constants.dart';
import 'package:quiz_app/views/home_page/components/course_body.dart';
import 'package:quiz_app/views/home_page/components/info_body.dart';
import 'package:quiz_app/views/home_page/components/manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  AuthenticationService _auth =
      new AuthenticationService(FirebaseAuth.instance);
  String userRule;
  int _selectedIndex = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
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
        userRule = resultant;
      });
    }
  }

  final _pageOptionUser = [
    CourseBody(),
    InformationBody(),
  ];
  final _pageOptionAdmin = [
    CourseBody(),
    InformationBody(),
    ManagerBody(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: navigationColor,
      body: userRule == "Admin"
          ? _pageOptionAdmin[_selectedIndex]
          : _pageOptionUser[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        height: 50,
        backgroundColor: navigationColor,
        animationDuration: Duration(milliseconds: 200),
        animationCurve: Curves.bounceInOut,
        items: userRule == "Admin"
            ? <Widget>[
                Icon(
                  Icons.apps,
                  size: 30,
                  color: Colors.grey[600],
                ),
                Icon(
                  Icons.account_circle_outlined,
                  size: 30,
                  color: Colors.grey[600],
                ),
                Icon(
                  Icons.settings,
                  size: 30,
                  color: Colors.grey[600],
                ),
              ]
            : <Widget>[
                Icon(
                  Icons.apps,
                  size: 30,
                  color: Colors.grey[600],
                ),
                Icon(
                  Icons.account_circle_outlined,
                  size: 30,
                  color: Colors.grey[600],
                ),
                GestureDetector(
                  onTap: () {
                    context.read<AuthenticationService>().signOut();
                  },
                  child: Icon(
                    Icons.logout,
                    size: 30,
                    color: Colors.grey[600],
                  ),
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
