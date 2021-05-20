import 'package:flutter/material.dart';

class OptionTitle extends StatefulWidget {
  final String option, description, correctAnswer, optionSelected;
  final bool answered;
  OptionTitle({
    @required this.option,
    @required this.optionSelected,
    @required this.correctAnswer,
    @required this.description,
    @required this.answered,
  });
  @override
  _OptionTitleState createState() => _OptionTitleState();
}

class _OptionTitleState extends State<OptionTitle> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        Container(
          height: 25,
          width: 25,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              color: widget.description == widget.optionSelected
                  ? widget.optionSelected == widget.correctAnswer
                      ? Colors.green.withOpacity(0.7)
                      : Colors.red.withOpacity(0.7)
                  : Colors.black,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            '${widget.option}',
            style: TextStyle(
              color: widget.optionSelected == widget.description
                  ? widget.correctAnswer == widget.optionSelected
                      ? Colors.green
                      : Colors.red
                  : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          width: size.width * 0.02,
        ),
        Flexible(
          child: Text(
            widget.description,
            style: TextStyle(
              fontSize: 17,
              color: widget.optionSelected == widget.description
                  ? widget.correctAnswer == widget.optionSelected
                      ? Colors.green
                      : Colors.red
                  : Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
