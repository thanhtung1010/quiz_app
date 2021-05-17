import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/views/play_quiz/components/question_model.dart';
import 'package:quiz_app/views/play_quiz/components/quiz_play_widget.dart';
import 'package:quiz_app/views/play_quiz/components/result.dart';
import 'package:quiz_app/views/play_quiz/components/use_answer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayQuiz extends StatefulWidget {
  final String courseId, courseName;
  PlayQuiz(this.courseId, this.courseName);
  @override
  _PlayQuizState createState() => _PlayQuizState();
}

int total = 0;
int _correct = 0;
int _incorrect = 0;
int _notAttempted = 0;

class _PlayQuizState extends State<PlayQuiz> {
  List QuestionList = [];
  List NewQuestionList = [];
  Random random = new Random();
  int randomNumber;
  String value;
  int indexPage = 0;
  CarouselController buttonCarouselController = CarouselController();
  SharedPreferences pref;
  List<UserAnswer> userAnswers = new List<UserAnswer>();

  DataQuestions dataQuestions;

  getQuestionModelFromNewList(List NewQuestionList, int index) {
    QuestionModel questionModel = new QuestionModel();
    questionModel.questionID = NewQuestionList[index]['questionID'];
    questionModel.questionText = NewQuestionList[index]['questionText'];
    questionModel.questionImgURL = NewQuestionList[index]['questionImgURL'];

    List<String> answers = [
      NewQuestionList[index]['answer01'],
      NewQuestionList[index]['answer02'],
      NewQuestionList[index]['answer03'],
      NewQuestionList[index]['answer04'],
    ];

    questionModel.correctAnswer = answers[0];

    answers.shuffle();

    questionModel.answer01 = answers[0];
    questionModel.answer02 = answers[1];
    questionModel.answer03 = answers[2];
    questionModel.answer04 = answers[3];
    questionModel.aswered = false;

    return questionModel;
  }

  @override
  void initState() {
    super.initState();
    fecth20QuestionList('${widget.courseId}');
    _correct = 0;
    _incorrect = 0;
  }

  fecth20QuestionList(String id) async {
    dynamic resultant = await DataQuestions().getQuestionData(id);

    if (resultant == null) {
      print('Unable to get question');
    } else {
      setState(() {
        QuestionList = resultant;
      });
    }
    while (NewQuestionList.length < 20) {
      randomNumber = random.nextInt(QuestionList.length);

      while (NewQuestionList.contains(QuestionList[randomNumber] == true)) {
        randomNumber = random.nextInt(QuestionList.length);
      }
      setState(() {
        NewQuestionList.add(QuestionList[randomNumber]);
      });
    }
    total = NewQuestionList.length;
    _notAttempted = NewQuestionList.length;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            '${widget.courseName} total',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
              fontFamily: 'Avenir',
            ),
            textAlign: TextAlign.center,
          ),
          leading: GestureDetector(
            onTap: () => {
              showCloseDialog(),
            },
            child: Icon(
              Icons.arrow_back,
              size: 30.0,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: CarouselSlider.builder(
                itemCount: NewQuestionList.length,
                itemBuilder: (context, index, indexPage) => QuizPlay(
                      questionModel:
                          getQuestionModelFromNewList(NewQuestionList, index),
                      index: index,
                    ),
                options: CarouselOptions(
                  height: size.height * 0.868,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1.0,
                  initialPage: 0,
                  reverse: false,
                  autoPlay: false,
                  enlargeCenterPage: false,
                  enableInfiniteScroll: false,
                )),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.check),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Result(
                    correct: _correct, incorrect: _incorrect, total: total),
              ),
            );
          },
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }

  showCloseDialog() {
    showDialog(
      context: context,
      builder: (_) => new AlertDialog(
        title: Text(
          'Close',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
          ),
        ),
        content: Text(
          'Are you sure to cancel this total',
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.grey,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: Text(
              'No',
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pop(context);
            },
            child: Text(
              'Yes',
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class QuizPlay extends StatefulWidget {
  final QuestionModel questionModel;
  final int index;
  QuizPlay({this.questionModel, this.index});
  @override
  _QuizPlayState createState() => _QuizPlayState();
}

class _QuizPlayState extends State<QuizPlay> {
  String optionSelected = '';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * 0.02,
          ),
          Text(
            'Q${widget.index + 1}: ${widget.questionModel.questionText}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.aswered) {
                if (widget.questionModel.answer01 ==
                    widget.questionModel.correctAnswer) {
                  optionSelected = widget.questionModel.answer01;
                  widget.questionModel.aswered = true;
                  setState(() {
                    _correct += 1;
                    _notAttempted -= 1;
                  });
                } else {
                  optionSelected = widget.questionModel.answer01;
                  widget.questionModel.aswered = true;
                  setState(() {
                    _incorrect += 1;
                    _notAttempted -= 1;
                  });
                }
              }
            },
            child: OptionTitle(
              option: 'A',
              optionSelected: optionSelected,
              correctAnswer: widget.questionModel.correctAnswer,
              description: widget.questionModel.answer01,
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.aswered) {
                if (widget.questionModel.answer02 ==
                    widget.questionModel.correctAnswer) {
                  optionSelected = widget.questionModel.answer02;
                  widget.questionModel.aswered = true;

                  setState(() {
                    _correct += 1;
                    _notAttempted -= 1;
                  });
                } else {
                  optionSelected = widget.questionModel.answer02;
                  widget.questionModel.aswered = true;

                  setState(() {
                    _incorrect += 1;
                    _notAttempted -= 1;
                  });
                }
              }
            },
            child: OptionTitle(
              option: 'B',
              optionSelected: optionSelected,
              correctAnswer: widget.questionModel.correctAnswer,
              description: widget.questionModel.answer02,
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.aswered) {
                if (widget.questionModel.answer03 ==
                    widget.questionModel.correctAnswer) {
                  optionSelected = widget.questionModel.answer03;
                  widget.questionModel.aswered = true;

                  setState(() {
                    _correct += 1;
                    _notAttempted -= 1;
                  });
                } else {
                  optionSelected = widget.questionModel.answer03;
                  widget.questionModel.aswered = true;

                  setState(() {
                    _incorrect += 1;
                    _notAttempted -= 1;
                  });
                }
              }
            },
            child: OptionTitle(
              option: 'C',
              optionSelected: optionSelected,
              correctAnswer: widget.questionModel.correctAnswer,
              description: widget.questionModel.answer03,
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.aswered) {
                if (widget.questionModel.answer04 ==
                    widget.questionModel.correctAnswer) {
                  optionSelected = widget.questionModel.answer04;
                  widget.questionModel.aswered = true;

                  setState(() {
                    _correct += 1;
                    _notAttempted -= 1;
                  });
                } else {
                  optionSelected = widget.questionModel.answer04;
                  widget.questionModel.aswered = true;

                  setState(() {
                    _incorrect += 1;
                    _notAttempted -= 1;
                  });
                }
              }
            },
            child: OptionTitle(
              option: 'D',
              optionSelected: optionSelected,
              correctAnswer: widget.questionModel.correctAnswer,
              description: widget.questionModel.answer04,
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
        ],
      ),
    );
  }
}
