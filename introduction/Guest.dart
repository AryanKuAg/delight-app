import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../HomePage.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Guest extends StatefulWidget {
  @override
  _GuestState createState() => _GuestState();
}

class _GuestState extends State<Guest> {
  final _auth = FirebaseAuth.instance;

  final bool _numberInputIsValid = true;

  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        icon: Icon(Icons.account_circle),
                        labelText: 'Enter UserName',
                        errorText: _numberInputIsValid
                            ? null
                            : 'Please Enter UserName!',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                  ),
                  SizedBox(height: 15),
                  RaisedButton(
                      child: Text('Quick Join'),
                      onPressed: () async {
                        setState(() {
                          showSpinner = true;
                        });
                        try {
                          final user = await _auth.signInAnonymously();
                          if (user != null) {
                            print(user);
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
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
