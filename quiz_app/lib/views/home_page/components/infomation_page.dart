import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:quiz_app/views/components/circular_button.dart';
import 'package:quiz_app/views/home_page/components/background.dart';
import 'package:quiz_app/views/home_page/components/information/information.dart';
import 'package:quiz_app/views/home_page/components/information/rule.dart';
import 'package:quiz_app/views/home_page/components/information/score.dart';

class InformationPage extends StatefulWidget {
  @override
  _InformationPageState createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation degOneTranslationAnimation;
  Animation rotationAnimation;
  int _selectedIndex = 0;
  List<Widget> list = [
    Infor(),
    Score(),
    Rule(),
  ];

  double getRadiansFormDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
    degOneTranslationAnimation =
        Tween(begin: 0.0, end: 1.0).animate(animationController);
    animationController.addListener(() {
      setState(() {});
    });
    rotationAnimation = Tween(begin: 180.0, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      body: Background(
        child: list[_selectedIndex],
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          Positioned(
            left: 20,
            top: 40,
            child: Transform.translate(
              offset: Offset.fromDirection(getRadiansFormDegree(0),
                  degOneTranslationAnimation.value * 70),
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationZ(
                  getRadiansFormDegree(rotationAnimation.value),
                )..scale(degOneTranslationAnimation.value),
                child: CircularButton(
                  color: Colors.white,
                  width: 50,
                  height: 50,
                  hinttext: 'Your infor',
                  icon: Icon(
                    Icons.person_outline,
                    color: Colors.black,
                  ),
                  onclick: () {
                    if (animationController.isCompleted) {
                      animationController.reverse();
                      setState(() {
                        _selectedIndex = 0;
                      });
                    } else {
                      animationController.forward();
                    }
                  },
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            top: 40,
            child: Transform.translate(
              offset: Offset.fromDirection(getRadiansFormDegree(0),
                  degOneTranslationAnimation.value * 130),
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationZ(
                  getRadiansFormDegree(rotationAnimation.value),
                )..scale(degOneTranslationAnimation.value),
                child: CircularButton(
                  color: Colors.white,
                  width: 50,
                  height: 50,
                  hinttext: 'Your score',
                  icon: Icon(
                    Icons.score_outlined,
                    color: Colors.black,
                  ),
                  onclick: () {
                    if (animationController.isCompleted) {
                      animationController.reverse();
                      setState(() {
                        _selectedIndex = 1;
                      });
                    } else {
                      animationController.forward();
                    }
                  },
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            top: 40,
            child: Transform.translate(
              offset: Offset.fromDirection(getRadiansFormDegree(0),
                  degOneTranslationAnimation.value * 190),
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationZ(
                  getRadiansFormDegree(rotationAnimation.value),
                )..scale(degOneTranslationAnimation.value),
                child: CircularButton(
                  color: Colors.white,
                  width: 50,
                  height: 50,
                  hinttext: 'Learn rule',
                  icon: Icon(
                    Icons.rule_folder_outlined,
                    color: Colors.black,
                  ),
                  onclick: () {
                    if (animationController.isCompleted) {
                      animationController.reverse();
                      setState(() {
                        _selectedIndex = 2;
                      });
                    } else {
                      animationController.forward();
                    }
                  },
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            top: 40,
            child: Transform.translate(
              offset: Offset.fromDirection(getRadiansFormDegree(0),
                  degOneTranslationAnimation.value * 250),
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationZ(
                  getRadiansFormDegree(rotationAnimation.value),
                )..scale(degOneTranslationAnimation.value),
                child: CircularButton(
                  color: Colors.white,
                  width: 50,
                  height: 50,
                  hinttext: 'Logout',
                  icon: Icon(
                    Icons.logout,
                    color: Colors.black,
                  ),
                  onclick: () async {
                    await FirebaseAuth.instance.signOut();
                  },
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            top: 40,
            child: CircularButton(
              color: Colors.white,
              width: 60,
              height: 60,
              icon: Icon(
                Icons.menu,
                color: Colors.black,
              ),
              hinttext: 'Menu',
              onclick: () {
                if (animationController.isCompleted) {
                  animationController.reverse();
                } else {
                  animationController.forward();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
