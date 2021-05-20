import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/state/answer_state.dart';
import 'package:quiz_app/state/answered.dart';
import 'package:quiz_app/state/correct_answer.dart';
import 'package:quiz_app/state/imgURL.dart';
import 'package:quiz_app/state/question_state.dart';
import 'package:quiz_app/views/welcome_page/welcome_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Answered>(
          create: (context) => Answered(),
        ),
        ChangeNotifierProvider<Question>(
          create: (context) => Question(),
        ),
        ChangeNotifierProvider<CorrectAns>(
          create: (context) => CorrectAns(),
        ),
        ChangeNotifierProvider<URL>(
          create: (context) => URL(),
        ),
        ChangeNotifierProvider<Answer>(
          create: (context) => Answer(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: WelcomePage(),
      ),
    );
  }
}
