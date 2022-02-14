//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import '../../src/pages/index.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import '../../HomePage.dart';
//
//class MyChatScreenPage extends StatefulWidget {
//  @override
//  _MyChatScreenPageState createState() => _MyChatScreenPageState();
//}
//
//class _MyChatScreenPageState extends State<MyChatScreenPage> {
//  final messageTextController = TextEditingController();
//  final _auth = FirebaseAuth.instance;
//  final _firestore = Firestore.instance;
//  FirebaseUser loggedInUser;
//  String messageText;
//
//  @override
//  void initState() {
//    super.initState();
//
//    getCurrentUser();
//  }
//
//  void getCurrentUser() async {
//    try {
//      final user = await _auth.currentUser();
//      if (user != null) {
//        loggedInUser = user;
//      }
//    } catch (e) {
//      print(e);
//    }
//  }
//
////  void messagesStream() async {
////    _firestore.collection('messages').snapshots();
////  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      backgroundColor: Color(0xffEEF4F6),
//      appBar: AppBar(
//        title: Text('Chat'),
//        backgroundColor: Colors.pinkAccent,
//        actions: <Widget>[
//          Padding(
//            padding: const EdgeInsets.all(10),
//            child: IconButton(
//              icon: Icon(Icons.video_call),
//              onPressed: () {
//                Navigator.push(context, MaterialPageRoute(builder: (context) {
//                  return IndexPage();
//                }));
//              },
//            ),
//          ),
//          Padding(
//            padding: const EdgeInsets.all(10),
//            child: Icon(Icons.search),
//          ),
//          Padding(
//            padding: const EdgeInsets.all(10),
//            child: Icon(Icons.settings),
//          )
//        ],
//      ),
//      body: SafeArea(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//          crossAxisAlignment: CrossAxisAlignment.stretch,
//          children: <Widget>[
//            MessagesStream(),
//            Container(
//              child: Row(
//                crossAxisAlignment: CrossAxisAlignment.center,
//                children: <Widget>[
//                  Expanded(
//                    child: TextField(
//                      controller: messageTextController,
//                      onChanged: (value) {
//                        messageText = value;
//                      },
//                    ),
//                  ),
//                  FlatButton(
//                    onPressed: () {
//                      messageTextController.clear();
//                      _firestore.collection('messages').add({
//                        'text': messageText,
//                        'sender': loggedInUser.email,
//                      });
//                    },
//                    child: Text('Send'),
//                  )
//                ],
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}
//
//class MessagesStream extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return StreamBuilder<QuerySnapshot>(
//      stream: _firestore.collection('messages').snapshots(),
//      builder: (context, snapshot) {
//        if (!snapshot.hasData) {
//          return Center(
//            child: CircularProgressIndicator(
//              backgroundColor: Colors.lightBlueAccent,
//            ),
//          );
//        }
//        final messages = snapshot.data.documents.reversed;
//        List<MessageBubble> messageBubbles = [];
//        for (var message in messages) {
//          final messageText = message.data['text'];
//          final messageSender = message.data['sender'];
//
//          final currentUser = loggedInUser.email;
//
//          final messageBubble = MessageBubble(
//              sender: messageSender,
//              text: messageText,
//              isMe: currentUser == messageSender);
//          messageBubbles.add(messageBubble);
//        }
//        return Expanded(
//            child: ListView(
//                reverse: true,
//                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
//                children: messageBubbles));
//      },
//    );
//  }
//}
//
//class MessageBubble extends StatelessWidget {
//  MessageBubble({this.sender, this.text, this.isMe});
//
//  final String sender;
//  final String text;
//  final bool isMe;
//
//  @override
//  Widget build(BuildContext context) {
//    return Padding(
//      padding: const EdgeInsets.all(10),
//      child: Column(
//        crossAxisAlignment:
//            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//        children: <Widget>[
//          Text(sender,
//              style: TextStyle(
//                fontSize: 12,
//                color: Colors.black,
//              )),
//          Material(
//              borderRadius: isMe
//                  ? BorderRadius.only(
//                      topLeft: Radius.circular(30),
//                      bottomLeft: Radius.circular(30),
//                      bottomRight: Radius.circular(30))
//                  : BorderRadius.only(
//                      topRight: Radius.circular(30),
//                      bottomLeft: Radius.circular(30),
//                      bottomRight: Radius.circular(30)),
//              elevation: 3,
//              color: isMe ? Colors.pinkAccent : Colors.white,
//              child: Padding(
//                padding:
//                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                child: Text(text, style: TextStyle(fontSize: 15)),
//              )),
//        ],
//      ),
//    );
//  }
//}
