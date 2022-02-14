import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../HomePage.dart';

class EmailSignIn extends StatefulWidget {
  @override
  _EmailSignInState createState() => _EmailSignInState();
}

class _EmailSignInState extends State<EmailSignIn> {
  final _auth = FirebaseAuth.instance;
  String wrongPasswordMessage = '';
  String myEmail;
  bool showSpinner = false;
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
                  Text(
                    wrongPasswordMessage,
                    style: TextStyle(color: Colors.redAccent),
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
                        final oldUser = await _auth.signInWithEmailAndPassword(
                            email: myEmail, password: myPassword);
                        if (oldUser != null) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return MyBottomTabBar();
                          }));
                        }
                      } catch (e) {
                        print(e);
                        setState(() {
                          wrongPasswordMessage =
                              "Password Galat Hai Uncle ( ͡❛ ͜ʖ ͡❛)✌";
                        });
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      child: Text(
                        'Sign In',
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
