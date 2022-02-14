import 'package:delight/introduction/Signup.dart';
import 'package:flutter/material.dart';
import 'Guest.dart';
import 'Signin.dart';
import '../src/pages/index.dart';

class PageSelectorExample extends StatelessWidget {
  const PageSelectorExample({Key key}) : super(key: key);

  static var kIcons = [
    MyFirstPage(),
    MySecondPage(),
    MyThirdPage(),
    MyFourthPage(),
    MyFifthPage(),
    MySignPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: DefaultTabController(
            length: kIcons.length,
            // Use a Builder here, otherwise `DefaultTabController.of(context)` below
            // returns null.
            child: Builder(
              builder: (BuildContext context) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    TabPageSelector(),
                    Expanded(
                      child: IconTheme(
                        data: IconThemeData(
                          size: 128.0,
                          color: Theme.of(context).accentColor,
                        ),
                        child: TabBarView(children: kIcons),
                      ),
                    ),
//                  RaisedButton(
//                    child: Text('SKIP'),
//                    onPressed: () {
//                      final TabController controller =
//                          DefaultTabController.of(context);
//                      if (!controller.indexIsChanging) {
//                        controller.animateTo(kIcons.length - 1);
//                      }
//                    },
//                  )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyFirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: Image.asset(
                  'images/Doughnuts.png',
                  height: 150,
                  width: 150,
                ),
              ),
              Text(
                'Delight',
                style: TextStyle(
                    color: Colors.black, fontSize: 50, fontFamily: 'Pacifico'),
              ),
              Text('The Broadcasting Application',
                  style: TextStyle(fontSize: 20)),
              SizedBox(
                height: 50,
              ),
              QuickJoinMeeting()
            ],
          ),
        ),
      ),
    );
  }
}

class QuickJoinMeeting extends StatelessWidget {
  const QuickJoinMeeting({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return IndexPage();
        }));
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Text('Quick Join Meeting'),
      ),
    );
  }
}

class MySecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                'images/tower.png',
                height: 300,
                width: 300,
              ),
              Text(
                'Join public Meetings',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 35,
                  fontFamily: 'Pacifico',
                ),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text('Discover all public meetings across the world.',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center),
              ),
              SizedBox(
                height: 50,
              ),
              QuickJoinMeeting()
            ],
          ),
        ),
      ),
    );
  }
}

class MyThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                'images/laptops.png',
                height: 300,
                width: 300,
              ),
              Text('Create a Meeting',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 35,
                      fontFamily: 'Pacifico'),
                  textAlign: TextAlign.center),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text('Create or Join a meeting with all your devices.',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center),
              ),
              SizedBox(
                height: 50,
              ),
              QuickJoinMeeting()
            ],
          ),
        ),
      ),
    );
  }
}

class MyFourthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                'images/mobile.png',
                height: 300,
                width: 300,
              ),
              Text('Chat with Friends',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 35,
                      fontFamily: 'Pacifico'),
                  textAlign: TextAlign.center),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text('Encrypted chat with Team Members or Friends.',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center),
              ),
              SizedBox(
                height: 50,
              ),
              QuickJoinMeeting()
            ],
          ),
        ),
      ),
    );
  }
}

class MyFifthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                'images/Lappy.png',
                height: 300,
                width: 300,
              ),
              Text('Share your Library',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 35,
                      fontFamily: 'Pacifico'),
                  textAlign: TextAlign.center),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text('Share Your content anywhere you want.',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center),
              ),
              SizedBox(
                height: 50,
              ),
              QuickJoinMeeting()
            ],
          ),
        ),
      ),
    );
  }
}

class MySignPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return EmailSignUp();
                  }));
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: ListTile(
                    leading: Icon(
                      Icons.email,
                      size: 40,
                    ),
                    title: Text(
                      'Sign up with Email',
                      style: TextStyle(
                          color: Colors.white, fontSize: 18, letterSpacing: 2),
                    ),
                  ),
                ),
                color: Colors.pinkAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
              SizedBox(
                height: 30,
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return EmailSignIn();
                  }));
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: ListTile(
                    leading: Icon(
                      Icons.alternate_email,
                      size: 40,
                    ),
                    title: Text(
                      'Sign in with Email',
                      style: TextStyle(
                          color: Colors.white, fontSize: 18, letterSpacing: 2),
                    ),
                  ),
                ),
                color: Colors.pinkAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
              SizedBox(
                height: 30,
              ),
//              RaisedButton(
//                elevation: 2,
//                onPressed: () {
//                  Navigator.push(context, MaterialPageRoute(builder: (context) {
//                    return Guest();
//                  }));
//                },
//                child: Padding(
//                  padding:
//                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
//                  child: ListTile(
//                    leading: Icon(
//                      Icons.gesture,
//                      size: 40,
//                    ),
//                    title: Text(
//                      'Guest Login',
//                      style: TextStyle(
//                          color: Colors.white, fontSize: 18, letterSpacing: 2),
//                    ),
//                  ),
//                ),
//                color: Colors.pinkAccent,
//                shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.circular(15)),
//              )
            ],
          ),
        ),
      ),
    );
  }
}
