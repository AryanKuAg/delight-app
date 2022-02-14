import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../HomePage.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class EmailSignUp extends StatefulWidget {
  @override
  _EmailSignUpState createState() => _EmailSignUpState();
}

class _EmailSignUpState extends State<EmailSignUp> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String myEmail;

  String myPassword;

  final bool _numberInputIsValid = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
//                TextField(
//                  keyboardType: TextInputType.text,
//                  decoration: InputDecoration(
//                      icon: Icon(Icons.account_circle),
//                      labelText: 'Enter UserName',
//                      errorText:
//                          _numberInputIsValid ? null : 'Please Enter UserName!',
//                      border: OutlineInputBorder(
//                          borderRadius: BorderRadius.all(Radius.circular(10)))),
//                ),
                  SizedBox(height: 15),
                  TextField(
                    onChanged: (value) {
                      myEmail = value;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        icon: Icon(Icons.email),
                        labelText: 'Enter Your Email',
                        errorText: _numberInputIsValid
                            ? null
                            : 'Please Enter UserName!',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                  ),
                  SizedBox(height: 30),
                  TextField(
                    obscureText: true,
                    onChanged: (value) {
                      myPassword = value;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        icon: Icon(Icons.security),
                        labelText: 'Enter Your Password',
                        errorText: _numberInputIsValid
                            ? null
                            : 'Please Enter UserName!',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                  ),
                  SizedBox(height: 30),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: myEmail, password: myPassword);
                        if (newUser != null) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return MyBottomTabBar();
                          }));
                        }
                      } catch (e) {
                        print(e);
                      }
                      setState(() {
                        showSpinner = false;
                      });
                      print('Email: $myEmail');
                      print('Password: $myPassword');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      child: Text(
                        'Sign up',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    color: Colors.pinkAccent,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
