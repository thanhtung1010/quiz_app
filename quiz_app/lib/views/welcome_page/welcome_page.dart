import 'package:flutter/material.dart';
import 'package:quiz_app/views/Constants.dart';
import 'package:quiz_app/views/welcome_page/components/body.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryLightColor,
      body: Body(),
    );
  }
}
