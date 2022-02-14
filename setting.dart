import 'package:flutter/material.dart';

class SettingItems extends StatefulWidget {
  @override
  _SettingItemsState createState() => _SettingItemsState();
}

class _SettingItemsState extends State<SettingItems> {
  bool _switchValTrue = true;
  bool _switchValFalse = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
      ),
      body: ListView(
        children: <Widget>[
          FlatButton(
            onPressed: () {},
            child: ListTile(
              title: Text('Watch later'),
              trailing: Switch(
                  onChanged: (bool value) {
                    setState(() {
                      this._switchValTrue = value;
                    });
                  },
                  value: this._switchValTrue),
            ),
          ),
          FlatButton(
            onPressed: () {},
            child: ListTile(
              title: Text('Watch later'),
              trailing: Switch(
                  onChanged: (bool value) {
                    setState(() {
                      this._switchValTrue = value;
                    });
                  },
                  value: this._switchValTrue),
            ),
          ),
          FlatButton(
            onPressed: () {},
            child: ListTile(
              title: Text('Watch later'),
              trailing: Switch(
                  onChanged: (bool value) {
                    setState(() {
                      this._switchValTrue = value;
                    });
                  },
                  value: this._switchValTrue),
            ),
          ),
          FlatButton(
            onPressed: () {},
            child: ListTile(
              title: Text('Watch later'),
              trailing: Switch(
                  onChanged: (bool value) {
                    setState(() {
                      this._switchValTrue = value;
                    });
                  },
                  value: this._switchValTrue),
            ),
          ),
          FlatButton(
            onPressed: () {},
            child: ListTile(
              title: Text('Watch later'),
              trailing: Switch(
                  onChanged: (bool value) {
                    setState(() {
                      this._switchValTrue = value;
                    });
                  },
                  value: this._switchValTrue),
            ),
          ),
          FlatButton(
            onPressed: () {},
            child: ListTile(
              title: Text('Watch later'),
              trailing: Switch(
                  onChanged: (bool value) {
                    setState(() {
                      this._switchValTrue = value;
                    });
                  },
                  value: this._switchValTrue),
            ),
          ),
          FlatButton(
            onPressed: () {},
            child: ListTile(
              title: Text('Watch later'),
              trailing: Switch(
                  onChanged: (bool value) {
                    setState(() {
                      this._switchValTrue = value;
                    });
                  },
                  value: this._switchValTrue),
            ),
          ),
          FlatButton(
            onPressed: () {},
            child: ListTile(
              title: Text('Watch later'),
              trailing: Switch(
                  onChanged: (bool value) {
                    setState(() {
                      this._switchValTrue = value;
                    });
                  },
                  value: this._switchValTrue),
            ),
          ),
          FlatButton(
            onPressed: () {},
            child: ListTile(
              title: Text('Watch later'),
              trailing: Switch(
                  onChanged: (bool value) {
                    setState(() {
                      this._switchValTrue = value;
                    });
                  },
                  value: this._switchValTrue),
            ),
          ),
          FlatButton(
            onPressed: () {},
            child: ListTile(
              title: Text('Watch later'),
              trailing: Switch(
                  onChanged: (bool value) {
                    setState(() {
                      this._switchValTrue = value;
                    });
                  },
                  value: this._switchValTrue),
            ),
          ),
          FlatButton(
            onPressed: () {},
            child: ListTile(
              title: Text('Watch later'),
              trailing: Switch(
                  onChanged: (bool value) {
                    setState(() {
                      this._switchValTrue = value;
                    });
                  },
                  value: this._switchValTrue),
            ),
          ),
          FlatButton(
            onPressed: () {},
            child: ListTile(
              title: Text('Watch later'),
              trailing: Switch(
                  onChanged: (bool value) {
                    setState(() {
                      this._switchValTrue = value;
                    });
                  },
                  value: this._switchValTrue),
            ),
          ),
          FlatButton(
            onPressed: () {},
            child: ListTile(
              title: Text('Watch later'),
              trailing: Switch(
                  onChanged: (bool value) {
                    setState(() {
                      this._switchValTrue = value;
                    });
                  },
                  value: this._switchValTrue),
            ),
          ),
          FlatButton(
            onPressed: () {},
            child: ListTile(
              title: Text('Watch later'),
              trailing: Switch(
                  onChanged: (bool value) {
                    setState(() {
                      this._switchValTrue = value;
                    });
                  },
                  value: this._switchValTrue),
            ),
          )
        ],
      ),
    );
  }
}
