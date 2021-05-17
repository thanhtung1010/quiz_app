import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:quiz_app/views/Constants.dart';
import 'package:quiz_app/views/components/circular_button.dart';
import 'package:quiz_app/views/home_page/components/MCategory.dart';
import 'package:quiz_app/views/home_page/components/MQuestion.dart';
import 'package:quiz_app/views/home_page/components/MUser.dart';
import 'package:quiz_app/views/home_page/components/background.dart';

class ManagerPage extends StatefulWidget {
  @override
  _ManagerPageState createState() => _ManagerPageState();
}

class _ManagerPageState extends State<ManagerPage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation degOneTranslationAnimation;
  Animation rotationAnimation;
  int _selectedIndex = 0;
  List<Widget> list = [
    ManageCategory(),
    ManageQuestion(),
    ManageUSer(),
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
                  degOneTranslationAnimation.value * 100),
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationZ(
                  getRadiansFormDegree(rotationAnimation.value),
                )..scale(degOneTranslationAnimation.value),
                child: CircularButton(
                  color: Colors.white,
                  width: 50,
                  height: 50,
                  icon: Icon(
                    Icons.margin,
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
              offset: Offset.fromDirection(getRadiansFormDegree(45),
                  degOneTranslationAnimation.value * 100),
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationZ(
                  getRadiansFormDegree(rotationAnimation.value),
                )..scale(degOneTranslationAnimation.value),
                child: CircularButton(
                  color: Colors.white,
                  width: 50,
                  height: 50,
                  icon: Icon(
                    Icons.question_answer_outlined,
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
              offset: Offset.fromDirection(getRadiansFormDegree(90),
                  degOneTranslationAnimation.value * 100),
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationZ(
                  getRadiansFormDegree(rotationAnimation.value),
                )..scale(degOneTranslationAnimation.value),
                child: CircularButton(
                  color: Colors.white,
                  width: 50,
                  height: 50,
                  icon: Icon(
                    Icons.person_outline,
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
            child: CircularButton(
              color: Colors.white,
              width: 60,
              height: 60,
              icon: Icon(
                Icons.menu,
                color: Colors.black,
              ),
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
