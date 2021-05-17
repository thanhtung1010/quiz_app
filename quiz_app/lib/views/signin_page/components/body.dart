import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quiz_app/routes/authentication_service.dart';
import 'package:quiz_app/views/Constants.dart';
import 'package:quiz_app/views/components/rounded_button.dart';
import 'package:quiz_app/views/components/text_field_container.dart';
import 'package:quiz_app/views/signin_page/components/background.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

bool _passwordVisible = false;

void initState() {
  _passwordVisible = false;
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGN IN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.05),
            TextFieldContainer(
              child: TextFormField(
                controller: emailController,
                validator: (value) {
                  return value.isEmpty ? "Enter your email" : null;
                },
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  hintText: 'Email',
                  border: InputBorder.none,
                  icon: Icon(
                    Icons.person,
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
                  hintText: "Password",
                  icon: Icon(
                    Icons.lock,
                    color: kPrimaryColor,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: kPrimaryColor,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "SIGN IN",
              press: () {
                context.read<AuthenticationService>().signIn(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim());
              },
            ),
          ],
        ),
      ),
    );
  }
}
