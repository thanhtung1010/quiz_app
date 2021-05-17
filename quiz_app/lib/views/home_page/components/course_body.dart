import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:quiz_app/models/courses.dart';
import 'package:quiz_app/routes/authentication_service.dart';
import 'package:quiz_app/views/Constants.dart';
import 'package:quiz_app/views/play_quiz/play_quiz.dart';

class CourseBody extends StatefulWidget {
  @override
  _CourseBodyState createState() => _CourseBodyState();
}

class _CourseBodyState extends State<CourseBody> {
  FirebaseAuth auth = FirebaseAuth.instance;
  AuthenticationService _auth =
      new AuthenticationService(FirebaseAuth.instance);
  String userRule;
  bool _isLoading = false;
  List CourseInfos = [];
  @override
  void initState() {
    super.initState();
    fecthCourseList();
  }

  fecthCourseList() async {
    setState(() {
      _isLoading = true;
    });
    dynamic resultant = await DataCourses().GetCourseList();

    if (resultant == null) {
      print('Unable to get course');
    } else {
      setState(() {
        CourseInfos = resultant;
        _isLoading = false;
      });
    }
  }

  getUserRule() async {
    String resultant = await _auth.GetRuleUserById(auth.currentUser.uid);

    if (resultant == null) {
      print('Unable to get rule');
    } else {
      setState(() {
        userRule = resultant;
        print(userRule);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: gradientEndColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [gradientStartColor, navigationColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.3, 0.7],
          ),
        ),
        child: _isLoading
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Courses',
                            style: TextStyle(
                              fontFamily: 'Avenir',
                              fontSize: 44,
                              color: const Color(0xffffffff),
                              fontWeight: FontWeight.w900,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.15,
                    ),
                    Container(
                      height: 500,
                      padding: const EdgeInsets.only(
                        left: 32,
                      ),
                      child: Swiper(
                        itemCount: CourseInfos.length,
                        itemWidth: MediaQuery.of(context).size.width - 2 * 64,
                        layout: SwiperLayout.STACK,
                        pagination: SwiperPagination(
                          alignment: FractionalOffset(0.4, 0.9),
                          builder: DotSwiperPaginationBuilder(
                            size: 7,
                            activeSize: 15,
                            space: 4,
                            color: Colors.grey,
                            activeColor: Colors.lightBlue,
                          ),
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            child: Stack(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 100,
                                    ),
                                    Card(
                                      elevation: 8,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(32),
                                      ),
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(32.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(
                                              height: 100,
                                            ),
                                            AutoSizeText(
                                              '${CourseInfos[index]['courseName']}',
                                              maxLines: 1,
                                              style: TextStyle(
                                                fontFamily: 'Avenir',
                                                fontSize: 36,
                                                color: const Color(0xff47455f),
                                                fontWeight: FontWeight.w900,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                            Text(
                                              '${CourseInfos[index]['courseDes']}',
                                              style: TextStyle(
                                                fontFamily: 'Avenir',
                                                fontSize: 17,
                                                color: primaryTextColor,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                            SizedBox(height: 32),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => PlayQuiz(
                                                            '${CourseInfos[index]['courseId']}',
                                                            '${CourseInfos[index]['courseName']}')));
                                              },
                                              child: Row(
                                                children: <Widget>[
                                                  Text(
                                                    'Get start',
                                                    style: TextStyle(
                                                      fontFamily: 'Avenir',
                                                      fontSize: 15,
                                                      color: secondaryTextColor,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  Icon(
                                                    Icons.arrow_forward,
                                                    color: secondaryTextColor,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Image.network(
                                  '${CourseInfos[index]['imgURL']}',
                                  height: 230,
                                  width: 230,
                                  alignment: Alignment.centerRight,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
