import 'dart:ui';

import 'package:finalauth_news/reusable_widgets/reusable_widget.dart';
import 'package:finalauth_news/screens/home_screen.dart';
import 'package:finalauth_news/screens/signup_screen.dart';
import 'package:finalauth_news/utils/color_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../views/homepage.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              hexStringTocolor('CB2B93'),
              hexStringTocolor('9546C4'),
              hexStringTocolor('5E61F4'),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20,
                MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                logoWidget('assets/images/logo.png'),
                SizedBox(
                  height: 30,
                ),
                reusableTextField(
                    'Enter UserName', Icons.person_outline, false, _emailTextController),
                SizedBox(
                  height: 20,
                ),
                reusableTextField('Enter Password', Icons.lock_outline, true,
                    _passwordTextController),
                SizedBox(
                  height: 20,
                ),
                signInSignUpButton(context, true, () async {
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                      email: _emailTextController.text,
                      password: _passwordTextController.text)
                      .then((value) async {
                    final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                    prefs.setString('name', value.user!.displayName.toString());
                    prefs.setBool('islogin', true);
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => HomePage()));
                  }).catchError((error, stackTrace) {
                    print('Error${error.toString()}');
                  });
                }),
                signUpOption()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Dont Have Account?',
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(" Sign Up ",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}