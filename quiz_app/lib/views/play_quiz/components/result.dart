import 'package:flutter/material.dart';
import 'package:quiz_app/views/Constants.dart';
import 'package:quiz_app/views/components/rounded_button.dart';

class Result extends StatefulWidget {
  final int correct, incorrect, total;
  Result(
      {@required this.correct, @required this.incorrect, @required this.total});
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${widget.correct + widget.incorrect}/${widget.total}',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Flexible(
                child: Text(
                  'You answered ${widget.correct} answers correctly and ${widget.incorrect} in correctly',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 8),
              RoundedButton(
                text: 'Go to home',
                color: navigationColor,
                textColor: Colors.grey,
                press: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
