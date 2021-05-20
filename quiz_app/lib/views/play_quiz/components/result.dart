import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/state/answer_state.dart';
import 'package:quiz_app/state/correct_answer.dart';
import 'package:quiz_app/state/imgURL.dart';
import 'package:quiz_app/state/question_state.dart';

class Result extends StatefulWidget {
  final int correct, incorrect, total, score;
  Result({
    @required this.correct,
    @required this.incorrect,
    @required this.total,
    @required this.score,
  });
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    final answeredModel = Provider.of<Answered>(context);
    final questionModel = Provider.of<Question>(context);
    final correctAnsModel = Provider.of<CorrectAns>(context);
    final urlModel = Provider.of<URL>(context);
    List answeredList = answeredModel.get();
    List questionList = questionModel.get();
    List corransweredList = correctAnsModel.get();
    List urlList = questionModel.get();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.purple[50],
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
          'Your score: ${widget.score}',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: GestureDetector(
          onTap: () => {
            answeredModel.restartAnswer(),
            questionModel.restartQuestion(),
            correctAnsModel.restartAnswer(),
            urlModel.restartURL(),
            Navigator.pop(context),
          },
          child: Icon(
            Icons.check,
            size: 30.0,
          ),
        ),
      ),
      body: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: answeredList.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.all(10),
              height: 60,
              width: size.width,
              decoration: BoxDecoration(
                color: answeredList[index] == corransweredList[index]
                    ? Colors.green.withOpacity(0.7)
                    : Colors.red.withOpacity(0.7),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShowAnswer(
                        questionText: questionList[index],
                        corectAnswer: corransweredList[index],
                        selectedAnswer: answeredList[index],
                      ),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: answeredList[index] == corransweredList[index]
                            ? Colors.green.withOpacity(0.7)
                            : Colors.red.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          width: 1,
                        ),
                      ),
                      child: AutoSizeText(
                        answeredList[index] == corransweredList[index]
                            ? 'Correct'
                            : 'Incorrect',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                      height: 60,
                      width: size.width * 0.76,
                      child: AutoSizeText(
                        questionList[index],
                        maxLines: 3,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class ShowAnswer extends StatefulWidget {
  final String questionText, corectAnswer, selectedAnswer;

  const ShowAnswer({
    Key key,
    @required this.questionText,
    @required this.corectAnswer,
    @required this.selectedAnswer,
  });
  @override
  _ShowAnswerState createState() => _ShowAnswerState();
}

class _ShowAnswerState extends State<ShowAnswer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
          'Answer',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      backgroundColor: Colors.purple[50],
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: SafeArea(
                child: Text(
                  'Question: ${widget.questionText}',
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: widget.selectedAnswer != widget.corectAnswer
                    ? Colors.red.withOpacity(0.7)
                    : Colors.green.withOpacity(0.7),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: SafeArea(
                child: Text(
                  'Your answer: ${widget.selectedAnswer}',
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            widget.selectedAnswer != widget.corectAnswer
                ? Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: widget.selectedAnswer != widget.corectAnswer
                          ? Colors.green.withOpacity(0.7)
                          : Colors.red.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: SafeArea(
                      child: Text(
                        'Correct answer: ${widget.corectAnswer}',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
