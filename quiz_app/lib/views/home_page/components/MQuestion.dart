import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/models/courses.dart';
import 'package:random_string/random_string.dart';

class MQuestion extends StatefulWidget {
  const MQuestion({Key key}) : super(key: key);
  @override
  _MQuestionState createState() => _MQuestionState();
}

class _MQuestionState extends State<MQuestion> {
  int _selectedIndex = 0;

  List<Widget> list = [
    AddQuestion(),
    UpdateQuestion(),
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            NavigationRail(
              onDestinationSelected: (int index) => {
                setState(() => {_selectedIndex = index})
              },
              destinations: const <NavigationRailDestination>[
                NavigationRailDestination(
                  icon: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.add_circle_outline),
                  ),
                  selectedIcon: Icon(Icons.add_circle_outline),
                  label: Text(
                    'Add Question',
                    style: TextStyle(fontSize: 8),
                  ),
                ),
                NavigationRailDestination(
                  icon: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.system_update_alt_outlined),
                  ),
                  selectedIcon: Icon(Icons.system_update_alt_outlined),
                  label: Text(
                    'Update Question',
                    style: TextStyle(fontSize: 8),
                  ),
                ),
              ],
              selectedIndex: _selectedIndex,
              labelType: NavigationRailLabelType.selected,
            ),
            const VerticalDivider(
              thickness: 1,
              width: 1,
            ),
            Expanded(
              child: list[_selectedIndex],
            )
          ],
        ),
      ),
    );
  }
}

class AddQuestion extends StatefulWidget {
  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  DataQuestions dataQuestions = new DataQuestions();
  final _formKey = GlobalKey<FormState>();
  String questionId,
      questionText,
      answer01,
      answer02,
      answer03,
      answer04,
      courseName;
  String imgURL = '';
  String _courseid;
  bool _isLoading = false;

  List CourseIdList = [];
  @override
  void initState() {
    super.initState();
    fecthIdCourseList();
    // fecthNameCourseById();
  }

  fecthIdCourseList() async {
    dynamic resultant = await DataCourses().GetIdCourses();

    if (resultant == null) {
      print('Unable to get course');
    } else {
      setState(() {
        CourseIdList = resultant;
      });
    }
  }

  // fecthNameCourseById() async {
  //   String resultant = await DataCourses().GetNameCourseById(_courseid);

  //   if (resultant == null) {
  //     print('Unable to get name');
  //   } else {
  //     setState(() {
  //       courseName = resultant;
  //     });
  //   }
  // }

  addQuestion() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      questionId = randomAlphaNumeric(20);
      Map<String, String> questionMap = {
        'questionID': questionId,
        'questionText': questionText,
        'questionImgURL': imgURL,
        'answer01': answer01,
        'answer02': answer02,
        'answer03': answer03,
        'answer04': answer04,
      };

      dataQuestions.AddQuestion(questionMap, questionId, _courseid)
          .then((value) => {
                setState(() {
                  _isLoading = false;
                })
              });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: _isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              padding: EdgeInsets.symmetric(
                vertical: 15.0,
                horizontal: 5.0,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    DropDownField(
                      value: _courseid,
                      required: true,
                      strict: true,
                      labelText: 'Choose your course',
                      hintText: 'Course',
                      items: CourseIdList,
                      onValueChanged: (dynamic newId) {
                        _courseid = newId;
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.025,
                    ),
                    TextFormField(
                      validator: (value) {
                        return value.isEmpty
                            ? "Question Text cannot be empty"
                            : null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Question Text',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                      onChanged: (val) {
                        questionText = val;
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.025,
                    ),
                    TextFormField(
                      validator: (value) {
                        return value.isEmpty
                            ? "Answer01 cannot be empty"
                            : null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Answer01 (Correct answer)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                      onChanged: (val) {
                        answer01 = val;
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.025,
                    ),
                    TextFormField(
                      validator: (value) {
                        return value.isEmpty
                            ? "Answer02 cannot be empty"
                            : null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Answer02',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                      onChanged: (val) {
                        answer02 = val;
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.025,
                    ),
                    TextFormField(
                      validator: (value) {
                        return value.isEmpty
                            ? "Answer03 cannot be empty"
                            : null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Answer03',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                      onChanged: (val) {
                        answer03 = val;
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.025,
                    ),
                    TextFormField(
                      validator: (value) {
                        return value.isEmpty
                            ? "Answer04 cannot be empty"
                            : null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Answer04',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                      onChanged: (val) {
                        answer04 = val;
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.025,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Image URL',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                      onChanged: (val) {
                        imgURL = val;
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.025,
                    ),
                    FloatingActionButton(
                      onPressed: () => {
                        addQuestion(),
                      },
                      child: Icon(Icons.done),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class UpdateQuestion extends StatefulWidget {
  @override
  _UpdateQuestionState createState() => _UpdateQuestionState();
}

class _UpdateQuestionState extends State<UpdateQuestion> {
  final _formKey = GlobalKey<FormState>();
  String courseID, questionID;
  List QuestionIdList = [];
  List CourseIdList = [];
  @override
  void initState() {
    super.initState();
    fecthIdCourseList();
  }

  fecthIdCourseList() async {
    dynamic resultant = await DataCourses().GetIdCourses();

    if (resultant == null) {
      print('Unable to get course');
    } else {
      setState(() {
        CourseIdList = resultant;
      });
    }
  }

  fecthIdQuestionListByCourseID(String cid) async {
    dynamic resultant = await DataQuestions().GetIdQuestionListByCourseId(cid);
    if (resultant == null) {
      print('Unable to get question');
    } else {
      setState(() {
        QuestionIdList = resultant;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference questionList = FirebaseFirestore.instance
        .collection('Couses')
        .doc(courseID)
        .collection('Questions');
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 5.0,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              DropDownField(
                onValueChanged: (dynamic value) {
                  setState(() {
                    courseID = value;
                    fecthIdQuestionListByCourseID(courseID);
                  });
                },
                value: courseID,
                required: true,
                hintText: 'Choose Course',
                labelText: courseID,
                items: CourseIdList,
              ),
              SizedBox(
                height: size.height * 0.025,
              ),
              DropDownField(
                onValueChanged: (dynamic value) {
                  setState(() {
                    questionID = value;
                  });
                },
                required: true,
                value: questionID,
                hintText: 'Find question with question text',
                labelText:
                    courseID == null ? 'No course selected' : 'Choose Question',
                items: QuestionIdList,
              ),
              SizedBox(
                height: size.height * 0.025,
              ),
              FutureBuilder<DocumentSnapshot>(
                future: questionList.doc(questionID).get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text("Something went wrong");
                  }

                  if (snapshot.hasData && !snapshot.data.exists) {
                    return Text("Document does not exist");
                  }

                  if (snapshot.connectionState == ConnectionState.done) {
                    Map<String, dynamic> data = snapshot.data.data();

                    String questionText = "${data['questionText']}",
                        imgURL = "${data['questionImgURL']}",
                        answer01 = "${data['answer01']}",
                        answer02 = "${data['answer02']}",
                        answer03 = "${data['answer03']}",
                        answer04 = "${data['answer04']}";
                    return Column(
                      children: [
                        TextFormField(
                          initialValue: "${data['questionText']}",
                          onChanged: (val) {
                            questionText = val;
                          },
                          validator: (value) {
                            return value.isEmpty
                                ? "Correct Answer cannot be empty"
                                : null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Question Text',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(26),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.025,
                        ),
                        TextFormField(
                          initialValue: "${data['questionImgURL']}",
                          onChanged: (val) {
                            imgURL = val;
                          },
                          decoration: InputDecoration(
                            labelText: 'Question imgURL',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(26),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.025,
                        ),
                        TextFormField(
                          initialValue: "${data['answer01']}",
                          onChanged: (val) {
                            answer01 = val;
                          },
                          validator: (value) {
                            return value.isEmpty
                                ? "Answer01 cannot be empty"
                                : null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Answer 01',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(26),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.025,
                        ),
                        TextFormField(
                          initialValue: "${data['answer02']}",
                          onChanged: (val) {
                            answer02 = val;
                          },
                          validator: (value) {
                            return value.isEmpty
                                ? "Answer02 cannot be empty"
                                : null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Answer 02',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(26),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.025,
                        ),
                        TextFormField(
                          initialValue: "${data['answer03']}",
                          onChanged: (val) {
                            answer03 = val;
                          },
                          validator: (value) {
                            return value.isEmpty
                                ? "Answer03 cannot be empty"
                                : null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Answer 03',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(26),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.025,
                        ),
                        TextFormField(
                          initialValue: "${data['answer04']}",
                          onChanged: (val) {
                            answer04 = val;
                          },
                          validator: (value) {
                            return value.isEmpty
                                ? "Answer04 cannot be empty"
                                : null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Answer 04',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(26),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.025,
                        ),
                        FloatingActionButton(
                          onPressed: () => {
                            if (_formKey.currentState.validate())
                              {
                                questionList
                                    .doc(questionID)
                                    .update({
                                      'questionText': questionText,
                                      'questionImgURL': imgURL,
                                      'answer01': answer01,
                                      'answer02': answer02,
                                      'answer03': answer03,
                                      'answer04': answer04,
                                    })
                                    .then((value) => print("User Updated"))
                                    .catchError((error) =>
                                        print("Failed to update user: $error"))
                              }
                          },
                          child: Icon(Icons.done),
                        ),
                      ],
                    );
                  }
                  return Text("loading");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
