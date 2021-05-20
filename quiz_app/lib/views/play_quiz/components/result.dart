import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/views/Constants.dart';
import 'package:quiz_app/views/components/rounded_button.dart';
import 'package:quiz_app/views/play_quiz/components/result_model.dart';
import 'package:quiz_app/views/play_quiz/play_quiz.dart';

class Result extends StatefulWidget {
  final int correct, incorrect, total, score;
  final ResultModel resultModel;
  Result({
    @required this.correct,
    @required this.incorrect,
    @required this.total,
    @required this.score,
    @required this.resultModel,
  });
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.purple[50],
      appBar: AppBar(
        backgroundColor: Colors.purple.withOpacity(0.3),
        title: Text(
          'Your score: ${widget.score}',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: GestureDetector(
          onTap: () => {Navigator.pop(context)},
          child: Icon(
            Icons.check,
            size: 30.0,
          ),
        ),
      ),
      body: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: total,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.all(10),
              height: 60,
              width: size.width,
              decoration: BoxDecoration(
                color: widget.resultModel.correctAnswer ==
                        widget.resultModel.selectedAnswer
                    ? Colors.green.withOpacity(0.3)
                    : Colors.red.withOpacity(0.3),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: widget.resultModel.correctAnswer ==
                              widget.resultModel.selectedAnswer
                          ? Colors.green.withOpacity(0.3)
                          : Colors.red.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        width: 1,
                      ),
                    ),
                    child: Text(
                      'Q.${index + 1}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                    height: 60,
                    width: size.width * 0.76,
                    child: AutoSizeText(
                      '${widget.resultModel.correctAnswer}',
                      maxLines: 3,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
