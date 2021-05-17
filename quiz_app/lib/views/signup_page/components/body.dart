import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quiz_app/views/Constants.dart';
import 'package:quiz_app/views/components/already_have_an_account_acheck.dart';
import 'package:quiz_app/views/components/rounded_button.dart';
import 'package:quiz_app/views/components/rounded_input_field.dart';
import 'package:quiz_app/views/components/rounded_password_field.dart';
import 'package:quiz_app/views/components/text_field_container.dart';
import 'package:quiz_app/views/signin_page/signin_page.dart';
import 'package:quiz_app/views/signup_page/components/background.dart';
import 'package:quiz_app/views/signup_page/components/or_divider.dart';
import 'package:quiz_app/views/signup_page/components/social_icon.dart';
import 'package:quiz_app/views/signup_page/signup_page.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            TextFieldContainer(
              child: TextFormField(
                validator: (value) {
                  return value.isEmpty ? "Enter your email" : null;
                },
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  border: InputBorder.none,
                  icon: Icon(
                    Icons.email_outlined,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ),
            TextFieldContainer(
              child: TextFormField(
                validator: (value) {
                  return value.isEmpty ? "Enter your name account" : null;
                },
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  hintText: 'Enter your name account',
                  border: InputBorder.none,
                  icon: Icon(
                    Icons.person_outline,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ),
            TextFieldContainer(
              child: TextFormField(
                validator: (value) {
                  return value.isEmpty ? "Enter your password" : null;
                },
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  border: InputBorder.none,
                  icon: Icon(
                    Icons.lock_outlined,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "SIGNUP",
              press: () {},
            ),
            SizedBox(height: size.height * 0.05),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignInPage();
                    },
                  ),
                );
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocalIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
