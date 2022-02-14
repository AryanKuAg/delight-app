import 'package:delight/introduction/pageOne.dart';
import 'package:delight/tabs/chat/ChatScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../src/pages/index.dart';
import 'package:delight/tabs/chat/screens/Chat.dart';
import '../setting.dart';
import 'package:delight/search.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage();
  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEF4F6),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Profile'),
        backgroundColor: Colors.pinkAccent,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(0),
            child: IconButton(
              icon: Icon(Icons.video_call),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return IndexPage();
                }));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(0),
            child: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: ChannelSearch());
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(0),
            child: IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SettingItems();
                }));
              },
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CircleAvatar(
              radius: 35.0,
              backgroundImage: AssetImage('images/aryan.jpg'),
            ),
            Text('Aryan Agrawal'),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              child: Text('Log Out'),
              onPressed: () async {
                _auth.signOut();
                await Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return PageSelectorExample();
                }));
              },
            ),
          ],
        ),
      ),
    );
  }
}
