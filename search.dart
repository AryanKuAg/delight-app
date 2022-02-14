import 'package:delight/tabs/Library.dart';
import 'package:flutter/material.dart';
import './src/pages/index.dart';
import './src/pages/call.dart';
import 'package:delight/tabs/home.dart';

class ChannelSearch extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder(
                    stream: firestore.collection('channelNames').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return CircularProgressIndicator();
                      }
                      return snapshot.data.documents;
                    }) ==
                null ||
            query.length == 0
        ? Text(
            'No data Found.                             (☞ﾟヮﾟ)☞',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 30,
                wordSpacing: 4,
                fontWeight: FontWeight.bold,
                color: Colors.black38),
          )
        : GestureDetector(
            onTap: () {
              watchHistory.add(query);
              IndexState().onJoin();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CallPage(
                    channelName: query,
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
                      query,
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

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = watchHistory;

    return ListView.builder(
        itemBuilder: (context, index) {
          return Expanded(
            child: ListTile(
              onTap: () {
                showResults(context);
              },
              leading: Icon(Icons.history),
              title: RichText(
                text: TextSpan(
                    text: suggestionList[index].substring(0, query.length),
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                          text: suggestionList[index].substring(query.length),
                          style: TextStyle(color: Colors.grey))
                    ]),
              ),
            ),
          );
        },
        itemCount: suggestionList.length);
  }
}
