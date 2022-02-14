import 'package:delight/tabs/chat/screens/Chat.dart';
import 'package:delight/tabs/Library.dart';
import 'package:delight/tabs/home.dart';
import 'package:flutter/material.dart';
import './src/pages/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'tabs/Profile.dart';
//import 'package:keyboard_visibility/keyboard_visibility.dart';

class MyBottomTabBar extends StatefulWidget {
  final myUser = FirebaseUser;
  @override
  State<StatefulWidget> createState() => _MyBottomTabBarState();
}

class _MyBottomTabBarState extends State<MyBottomTabBar> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;

  int _currentTabIndex = 0;

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  final _kTabPages = <Widget>[
    MyHomePage(),
    MyChatPage(),
    MyLibraryPage(),
    MyProfilePage()
  ];
  final _KBottomNavBarItems = [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
          color: Colors.black,
        ),
        title: Text('Home')),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.chat,
          color: Colors.black,
        ),
        title: Text('Chat')),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.video_library,
          color: Colors.black,
        ),
        title: Text('Library')),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.account_circle,
          color: Colors.black,
        ),
        title: Text('Profile')),
  ];

  @override
  void initState() {
    super.initState();

    getCurrentUser();
//    KeyboardVisibilityNotification().addNewListener(
//      onChange: (bool visible) {
//        print(visible);
//      },
//    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomNavBar = BottomNavigationBar(
      items: _KBottomNavBarItems,
      currentIndex: _currentTabIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          _currentTabIndex = index;
          print(_currentTabIndex);
        });
      },
    );
    return Scaffold(
      backgroundColor: Color(0xffEEF4F6),
      appBar: null,
      body: _kTabPages[_currentTabIndex],
      bottomNavigationBar: bottomNavBar,
    );
  }
}

class MyTab extends StatelessWidget {
  final Icon myIcon;
  final String myColor;
  MyTab(this.myIcon, this.myColor);
  @override
  Widget build(BuildContext context) {
    return Tab(
      icon: myIcon,
      child: Text(
        myColor,
        style: TextStyle(color: Colors.pinkAccent),
      ),
    );
  }
}
