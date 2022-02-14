import 'package:delight/introduction/Signup.dart';
import 'package:flutter/material.dart';
import './src/pages/index.dart';
import 'package:delight/introduction/pageOne.dart';
import 'HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bhoot ni ke',
      theme:
          ThemeData(primarySwatch: Colors.pink, accentColor: Colors.pinkAccent),
      home: loggedInUser != null ? MyBottomTabBar() : PageSelectorExample(),
    );
  }
}

//home: PageSelectorExample()

//home: MyBottomTabBar(),
