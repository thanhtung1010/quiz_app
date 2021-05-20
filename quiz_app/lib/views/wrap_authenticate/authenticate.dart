import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/routes/authentication_service.dart';
import 'package:quiz_app/views/home_page/home_page.dart';
import 'package:quiz_app/views/signin_page/components/body.dart';
import 'package:quiz_app/views/signup_page/components/body.dart';

class Authenticate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
        ),
      ],
      child: AuthenticationWrapper(),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    if (firebaseUser != null) {
      return HomePage();
    }

    return WrapAuthenticate();
  }
}

class WrapAuthenticate extends StatefulWidget {
  @override
  _WrapAuthenticateState createState() => _WrapAuthenticateState();
}

class _WrapAuthenticateState extends State<WrapAuthenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return BodySignIn(toggleView: toggleView);
    } else {
      return BodySignUp(toggleView: toggleView);
    }
  }
}
