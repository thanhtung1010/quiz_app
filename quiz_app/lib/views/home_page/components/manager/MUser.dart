import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/routes/authentication_service.dart';

class ManageUSer extends StatefulWidget {
  @override
  _ManageUSerState createState() => _ManageUSerState();
}

class _ManageUSerState extends State<ManageUSer> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool check = true;
  List categoryIdList = [];
  String email, nameAccount;
  final AuthenticationService _auth =
      new AuthenticationService(FirebaseAuth.instance);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return _isLoading
        ? Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 15.0,
                horizontal: 5.0,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        return value.isEmpty
                            ? "Password cannot be empty"
                            : null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.025,
                    ),
                    TextFormField(
                      onChanged: (val) {
                        email = val;
                      },
                      controller: emailController,
                      validator: (value) {
                        return value.isEmpty ? "Email cannot be empty" : null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.025,
                    ),
                    TextFormField(
                      onChanged: (val) {
                        nameAccount = val;
                      },
                      validator: (value) {
                        return value.isEmpty ? "Name cannot be empty" : null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.025,
                    ),
                    FloatingActionButton(
                      onPressed: () => {
                        createUser(),
                      },
                      child: Icon(Icons.done),
                    ),
                  ],
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
