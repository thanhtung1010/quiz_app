import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/models/courses.dart';
import 'package:quiz_app/routes/authentication_service.dart';
import 'package:quiz_app/views/Constants.dart';

class InformationBody extends StatefulWidget {
  @override
  _InformationBodyState createState() => _InformationBodyState();
}

class _InformationBodyState extends State<InformationBody> {
  bool _enable = false;
  String courseName, userRule, usercid;
  FirebaseAuth auth = FirebaseAuth.instance;
  AuthenticationService _auth =
      new AuthenticationService(FirebaseAuth.instance);
  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  @override
  void initState() {
    super.initState();
    getUserRule();
    getUserCid();
    // fecthNameCourseById();
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

  getUserCid() async {
    dynamic resultant = await _auth.GetCidByUserId(auth.currentUser.uid);

    if (resultant == null) {
      print('Unable to get cid');
    } else {
      setState(() {
        usercid = resultant;
      });
    }
    dynamic resultant02 = await DataCourses().GetNameCourseById(usercid);
    if (resultant02 == null) {
      print('Unable to get name');
      print(resultant);
    } else {
      setState(() {
        courseName = resultant02;
      });
    }
  }

  // fecthNameCourseById() async {
  //   dynamic resultant = await DataCourses().GetNameCourseById(usercid);

  //   if (resultant == null) {
  //     print('Unable to get name');
  //     print(resultant);
  //   } else {
  //     setState(() {
  //       courseName = resultant;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(auth.currentUser.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          return Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, navigationColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.3, 1],
              ),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  height: size.height * 0.2,
                  padding: const EdgeInsets.all(25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Hi ${data['name']}',
                        style: TextStyle(
                          fontFamily: 'Avenir',
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2.0,
                            color: Colors.grey[600],
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: userRule == 'Admin'
                            ? PopupMenuButton(
                                onSelected: (result) {
                                  if (result == 1) {
                                    context
                                        .read<AuthenticationService>()
                                        .signOut();
                                  }
                                },
                                child: Icon(Icons.menu),
                                itemBuilder: (BuildContext context) {
                                  return <PopupMenuItem>[
                                    PopupMenuItem(
                                      value: 0,
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: Row(
                                          children: [
                                            Text('Setup'),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Icon(
                                              Icons.settings,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: 1,
                                      child: Row(
                                        children: [
                                          Text('Logout'),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Icon(
                                            Icons.logout,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ];
                                },
                              )
                            : PopupMenuButton(
                                child: Icon(Icons.border_color),
                                itemBuilder: (BuildContext context) {
                                  return <PopupMenuItem>[
                                    PopupMenuItem(
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text('Email'),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Icon(
                                              Icons.email_outlined,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text('Password'),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Icon(
                                              Icons.lock_outlined,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ];
                                },
                              ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.1,
                ),
                Container(
                  height: size.height * 0.1,
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Align(
                    child: Text(
                      'This is your profile:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    alignment: Alignment.bottomCenter,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  height: size.height * 0.5288,
                  decoration: BoxDecoration(
                    color: navigationColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Your name: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Container(
                            width: size.width * 0.6,
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              enabled: false,
                              decoration: InputDecoration(
                                labelText: '${data['name']}',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(26),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Your email: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Container(
                            width: size.width * 0.6,
                            child: TextFormField(
                              enabled: _enable,
                              decoration: InputDecoration(
                                labelText: '${data['email']}',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(26),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Your rule: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Container(
                            width: size.width * 0.6,
                            child: TextFormField(
                              enabled: false,
                              decoration: InputDecoration(
                                labelText: '${data['rule']}',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(26),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Your course: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Container(
                            width: size.width * 0.6,
                            child: TextFormField(
                              enabled: false,
                              decoration: InputDecoration(
                                labelText: userRule == 'Admin'
                                    ? 'All course'
                                    : courseName,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(26),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return Text("loading");
      },
    );
  }
}
