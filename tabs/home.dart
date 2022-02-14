import 'package:delight/search.dart';
import 'package:delight/setting.dart';
import 'package:delight/src/pages/index.dart';
import 'package:delight/src/pages/call.dart';
import 'package:delight/tabs/Library.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'chat/ChatScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:permission_handler/permission_handler.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage();
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEF4F6),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Home'),
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
      body: StreamBuilder(
                  stream: firestore.collection('channelNames').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return CircularProgressIndicator();
                    }
                    return snapshot.data.documents;
                  }) ==
              null
          ? ListView(
              children: <Widget>[
                Center(child: Lottie.asset('images/rocket.json')),
                SizedBox(
                  height: 50,
                ),
                Center(
                    child: Container(
                        child: Text(
                  'No data Found.                             (☞ﾟヮﾟ)☞',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30,
                      wordSpacing: 4,
                      fontWeight: FontWeight.bold,
                      color: Colors.black38),
                )))
              ],
            )
          : StreamBuilder(
              stream: firestore.collection('channelNames').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Center(child: CircularProgressIndicator());
                }

                final currentChannelName = snapshot.data.documents;
                List<MyChannelCard> myChannelCard = [];
                for (var livechannel in currentChannelName) {
                  final myChannel = livechannel.data['channel'];
                  final myCreator = livechannel.data['creator'];

                  final channelCard =
                      MyChannelCard(myChannel: myChannel, myCreator: myCreator);
                  myChannelCard.add(channelCard);
                }

                return ListView(
                  children: myChannelCard,
                );
              },
            ),
    );
  }
}

class MyChannelCard extends StatelessWidget {
  final String myChannel;
  final String myCreator;
  MyChannelCard({this.myChannel, this.myCreator});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await _handleCameraAndMic();
        watchHistory.add(myChannel);
        IndexState().onJoin();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CallPage(
              channelName: myChannel,
            ),
          ),
        );
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.asset('images/pinkbg.jpg'),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                myChannel,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18,
                  letterSpacing: 0.5,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _handleCameraAndMic() async {
    await PermissionHandler().requestPermissions(
      [PermissionGroup.camera, PermissionGroup.microphone],
    );
  }
}
