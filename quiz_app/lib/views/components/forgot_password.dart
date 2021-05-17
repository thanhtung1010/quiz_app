import 'package:flutter/material.dart';
import 'package:quiz_app/views/Constants.dart';

class ForgotPassword extends StatelessWidget {
  final Function press;
  final String text;
  const ForgotPassword({
    Key key,
    this.press,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: press,
          child: Text(
            text,
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        )
      ],
    );
  }
}
