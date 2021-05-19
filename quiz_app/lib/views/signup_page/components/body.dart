import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quiz_app/routes/authentication_service.dart';
import 'package:quiz_app/views/Constants.dart';
import 'package:quiz_app/views/components/already_have_an_account_acheck.dart';
import 'package:quiz_app/views/components/rounded_button.dart';
import 'package:quiz_app/views/components/text_field_container.dart';
import 'package:quiz_app/views/signup_page/components/background.dart';
import 'package:quiz_app/views/signup_page/components/or_divider.dart';
import 'package:quiz_app/views/signup_page/components/social_icon.dart';

class BodySignUp extends StatefulWidget {
  final Function toggleView;

  const BodySignUp({Key key, this.toggleView});
  @override
  _BodySignUpState createState() => _BodySignUpState();
}

bool _passwordVisible = false;

class _BodySignUpState extends State<BodySignUp> {
  bool check = false;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  String email, nameAccount;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthenticationService _auth =
      new AuthenticationService(FirebaseAuth.instance);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: size.height * 0.1),
                Text(
                  "SIGNUP",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: size.height * 0.03),
                SvgPicture.asset(
                  "assets/icons/signup.svg",
                  height: size.height * 0.35,
                ),
                SizedBox(height: size.height * 0.05),
                TextFieldContainer(
                  child: TextFormField(
                    onChanged: (val) {
                      email = val;
                    },
                    controller: emailController,
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
                    onChanged: (val) {
                      nameAccount = val;
                    },
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
                    controller: passwordController,
                    validator: (value) {
                      return value.isEmpty ? "Enter your password" : null;
                    },
                    obscureText: !_passwordVisible,
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
                      border: InputBorder.none,
                      icon: Icon(
                        Icons.lock_outlined,
                        color: kPrimaryColor,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: kPrimaryColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                RoundedButton(
                  text: "SIGNUP",
                  press: () {
                    createUser();
                  },
                ),
                SizedBox(height: size.height * 0.05),
                AlreadyHaveAnAccountCheck(
                  login: false,
                  press: () {
                    widget.toggleView();
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
        ),
      ),
    );
  }

  createUser() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      Map<String, dynamic> usersMap = {
        "email": email,
        "name": nameAccount,
        "isAdmin": check,
      };
      dynamic result = _auth
          .signUp(
              email: emailController.text,
              password: passwordController.text,
              userData: usersMap)
          .then((value) => {
                setState(() {
                  _isLoading = false;
                })
              });
    }
  }
}
