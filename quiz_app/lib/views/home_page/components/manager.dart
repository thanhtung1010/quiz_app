import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/views/Constants.dart';
import 'package:quiz_app/views/components/custom_title.dart';
import 'package:quiz_app/views/home_page/components/MCourses.dart';
import 'package:quiz_app/views/home_page/components/MQuestion.dart';
import 'package:quiz_app/views/home_page/components/MUsers.dart';
import 'package:quiz_app/views/home_page/components/Mtification.dart';

class ManagerBody extends StatefulWidget {
  const ManagerBody({Key key}) : super(key: key);
  @override
  _ManagerBodyState createState() => _ManagerBodyState();
}

class _ManagerBodyState extends State<ManagerBody> {
  int _selectedIndex = 0;
  List<Widget> list = [
    MUser(),
    MCourses(),
    MQuestion(),
    MNotification(),
  ];

  onTap(context, i) {
    setState(() {
      _selectedIndex = i;
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Manager',
          style: TextStyle(
            fontFamily: 'Avenir',
            fontSize: 25,
          ),
        ),
        backgroundColor: Colors.blue[700],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [kPrimaryLightColor, navigationColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.3, 1],
          ),
        ),
        child: list[_selectedIndex],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blueAccent, kPrimaryLightColor],
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  stops: [0, 0.5],
                ),
              ),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Material(
                      child: Image.asset(
                        'assets/images/AGU.png',
                        width: 100,
                        height: 100,
                      ),
                      borderRadius: BorderRadius.circular(50),
                      elevation: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                      child: Text(
                        'CICT',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            CustomTitle(
              icon1: Icon(
                Icons.person,
              ),
              text: Text(
                'User',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              icon2: Icon(Icons.arrow_right),
              press: () => onTap(context, 0),
            ),
            CustomTitle(
              icon1: Icon(
                Icons.margin,
              ),
              text: Text(
                'Courses',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              icon2: Icon(Icons.arrow_right),
              press: () => onTap(context, 1),
            ),
            CustomTitle(
              icon1: Icon(
                Icons.question_answer_outlined,
              ),
              text: Text(
                'Question',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              icon2: Icon(Icons.arrow_right),
              press: () => onTap(context, 2),
            ),
            CustomTitle(
              icon1: Icon(Icons.add_alert_outlined),
              text: Text(
                'Notification',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              icon2: Icon(Icons.arrow_right),
              press: () => onTap(context, 3),
            ),
          ],
        ),
      ),
    );
  }
}
