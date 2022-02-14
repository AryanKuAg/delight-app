import 'package:flutter/material.dart';
import 'package:whiteboardkit/whiteboardkit.dart';

class MyWhiteBoard extends StatefulWidget {
  @override
  _MyWhiteBoardState createState() => _MyWhiteBoardState();
}

class _MyWhiteBoardState extends State<MyWhiteBoard> {
  DrawingController controller;
  @override
  void initState() {
    controller = DrawingController();
    controller.onChange().listen((draw) {
      //do something with it
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('White Board'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Whiteboard(
                controller: controller,
              ),
            ),
          ],
        ));
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }
}
