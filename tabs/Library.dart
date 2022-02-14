import 'package:flutter/material.dart';
import '../src/pages/index.dart';
import 'package:lottie/lottie.dart';
import '../src/pages/call.dart';
import '../setting.dart';
import 'package:delight/search.dart';

List watchHistory = [];

class MyLibraryPage extends StatefulWidget {
  const MyLibraryPage();
  @override
  _MyLibraryPageState createState() => _MyLibraryPageState();
}

class _MyLibraryPageState extends State<MyLibraryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffEEF4F6),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Library'),
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
        body: watchHistory.length == 0
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
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 280, 5),
                    child: Text(
                      'History',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    height: 180,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: watchHistory.length,
                      itemBuilder: (context, index) {
                        String watchHistoryChannel = watchHistory[index];
                        return GestureDetector(
                          onTap: () {
                            IndexState().onJoin();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CallPage(
                                  channelName: watchHistoryChannel,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 50,
                            width: 190,
                            child: Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Image.asset('images/pinkbg.jpg'),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      watchHistoryChannel,
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
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
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 5, 250, 5),
                    child: Text(
                      'Local Files',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: ListTile(
                      leading: Icon(Icons.history),
                      title: Text('History'),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: ListTile(
                      leading: Icon(Icons.file_download),
                      title: Text('Downloads'),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: ListTile(
                      leading: Icon(Icons.ondemand_video),
                      title: Text('Your videos'),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: ListTile(
                      leading: Icon(Icons.local_offer),
                      title: Text('Purchases'),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: ListTile(
                      leading: Icon(Icons.watch_later),
                      title: Text('Watch later'),
                    ),
                  ),
                ],
              ));
  }
}
