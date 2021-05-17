import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/models/category.dart';
import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/views/components/squared_button.dart';
import 'package:random_string/random_string.dart';

class ManageQuestion extends StatefulWidget {
  @override
  _ManageQuestionState createState() => _ManageQuestionState();
}

class _ManageQuestionState extends State<ManageQuestion> {
  int _selectedIndex = 0;
  List<Widget> list = [
    Add(),
    Update(),
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Center(
          child: list[_selectedIndex],
        ),
        Positioned(
          left: 0,
          bottom: 0,
          child: Column(
            children: [
              SquaredButton(
                height: 70,
                width: 70,
                color: _selectedIndex == 0 ? Colors.purple[50] : Colors.white,
                icon: Icon(
                  Icons.add_circle_outline,
                  size: 30,
                  color: _selectedIndex == 0 ? Colors.black : Colors.grey,
                ),
                onclick: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                },
              ),
              SquaredButton(
                height: 70,
                width: 70,
                color: _selectedIndex == 1 ? Colors.purple[50] : Colors.white,
                icon: Icon(
                  Icons.system_update_alt_outlined,
                  size: 30,
                  color: _selectedIndex == 1 ? Colors.black : Colors.grey,
                ),
                onclick: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
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
  String _categoryId;
  bool _isLoading = false;
  List categoryIdList = [];

  @override
  void initState() {
    super.initState();
    fecthIdCourseList();
  }

  fecthIdCourseList() async {
    dynamic resultant = await DataCategorys().GetIdCategory();

    if (resultant == null) {
      print('Unable to get category');
    } else {
      setState(() {
        categoryIdList = resultant;
      });
    }
  }

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

      dataQuestions.AddQuestion(questionMap, questionId, _categoryId)
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
    return _isLoading
        ? Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 20,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    DropDownField(
                      value: _categoryId,
                      required: true,
                      strict: true,
                      labelText: 'Choose your course',
                      hintText: 'Course',
                      items: categoryIdList,
                      onValueChanged: (dynamic newId) {
                        _categoryId = newId;
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.025,
                    ),
                    TextFormField(
                      validator: (value) {
                        return value.isEmpty
                            ? "Question text cannot be empty"
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

class Update extends StatefulWidget {
  @override
  _UpdateState createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  List categoryIdList = [];
  List QuestionIdList = [];
  String categoryID, questionID, categoryDes;

  @override
  void initState() {
    super.initState();
    fecthIdCategoryList();
  }

  fecthIdCategoryList() async {
    dynamic resultant = await DataCategorys().GetIdCategory();

    if (resultant == null) {
      print('Unable to get category');
    } else {
      setState(() {
        categoryIdList = resultant;
      });
    }
  }

  fecthIdQuestionListByCategoryID(String cid) async {
    dynamic resultant =
        await DataQuestions().GetIdQuestionListByCategoryId(cid);
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
    Size size = MediaQuery.of(context).size;
    CollectionReference questionList = FirebaseFirestore.instance
        .collection('Categorys')
        .doc(categoryID)
        .collection('Questions');
    return _isLoading
        ? Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : SingleChildScrollView(
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
                          categoryID = value;
                          fecthIdQuestionListByCategoryID(categoryID);
                        });
                      },
                      value: categoryID,
                      required: true,
                      hintText: 'Choose Course',
                      labelText: categoryID,
                      items: categoryIdList,
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
                      labelText: categoryID == null
                          ? 'No course selected'
                          : 'Choose Question',
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
                                          .then((value) => {
                                                setState(() {
                                                  _isLoading = false;
                                                }),
                                                print('Question Update !!'),
                                              })
                                          .catchError((error) => {
                                                setState(() {
                                                  _isLoading = false;
                                                }),
                                                print(
                                                    "Failed to update question: $error")
                                              })
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
