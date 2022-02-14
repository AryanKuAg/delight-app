import 'dart:async';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import '../utils/settings.dart';
import 'whiteboard.dart';

class CallPage extends StatefulWidget {
  /// non-modifiable channel name of the page
  final String channelName;

  /// Creates a call page with given channel name.
  const CallPage({Key key, this.channelName}) : super(key: key);

  @override
  _CallPageState createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  static final _users = <int>[];
  final _infoStrings = <String>[];
  bool muted = false;

  @override
  void dispose() {
    // clear users
    _users.clear();
    // destroy sdk
    AgoraRtcEngine.leaveChannel();
    AgoraRtcEngine.destroy();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // initialize agora sdk
    initialize();
  }

  Future<void> initialize() async {
    if (APP_ID.isEmpty) {
      setState(() {
        _infoStrings.add(
          'APP_ID missing, please provide your APP_ID in settings.dart',
        );
        _infoStrings.add('Agora Engine is not starting');
      });
      return;
    }

    await _initAgoraRtcEngine();
    _addAgoraEventHandlers();
    await AgoraRtcEngine.enableWebSdkInteroperability(true);
    await AgoraRtcEngine.setParameters(
        '''{\"che.video.lowBitRateStreamParameter\":{\"width\":320,\"height\":180,\"frameRate\":15,\"bitRate\":140}}''');
    await AgoraRtcEngine.joinChannel(null, widget.channelName, null, 0);
  }

  /// Create agora sdk instance and initialize
  Future<void> _initAgoraRtcEngine() async {
    await AgoraRtcEngine.create(APP_ID);
    await AgoraRtcEngine.enableVideo();
  }

  /// Add agora event handlers
  void _addAgoraEventHandlers() {
    AgoraRtcEngine.onError = (dynamic code) {
      setState(() {
        final info = 'onError: $code';
        _infoStrings.add(info);
      });
    };

    AgoraRtcEngine.onJoinChannelSuccess = (
      String channel,
      int uid,
      int elapsed,
    ) {
      setState(() {
        final info = 'onJoinChannel: $channel, uid: $uid';
        _infoStrings.add(info);
      });
    };

    AgoraRtcEngine.onLeaveChannel = () {
      setState(() {
        _infoStrings.add('onLeaveChannel');
        _users.clear();
      });
    };

    AgoraRtcEngine.onUserJoined = (int uid, int elapsed) {
      setState(() {
        final info = 'userJoined: $uid';
        _infoStrings.add(info);
        _users.add(uid);
      });
    };

    AgoraRtcEngine.onUserOffline = (int uid, int reason) {
      setState(() {
        final info = 'userOffline: $uid';
        _infoStrings.add(info);
        _users.remove(uid);
      });
    };

    AgoraRtcEngine.onFirstRemoteVideoFrame = (
      int uid,
      int width,
      int height,
      int elapsed,
    ) {
      setState(() {
        final info = 'firstRemoteVideo: $uid ${width}x $height';
        _infoStrings.add(info);
      });
    };
  }

  /// Helper function to get list of native views
  List<Widget> _getRenderViews() {
    final List<AgoraRenderWidget> list = [
      AgoraRenderWidget(0, local: true, preview: true),
    ];
    _users.forEach((int uid) => list.add(AgoraRenderWidget(uid)));
    return list;
  }

  /// Video view wrapper
  Widget _videoView(view) {
    return Expanded(child: Container(child: view));
  }

  /// Video view row wrapper
  Widget _expandedVideoRow(List<Widget> views) {
    final wrappedViews = views.map<Widget>(_videoView).toList();
    return Expanded(
      child: Row(
        children: wrappedViews,
      ),
    );
  }

  //my page view controller for too many pages..
  final controller = PageController(
    initialPage: 1,
  );

  /// Video layout wrapper
  Widget _viewRows() {
    final views = _getRenderViews();
    switch (views.length) {
      case 1:
        return PageView(
            controller: controller, children: [singleView(views, 0)]);
      case 2:
        return PageView(
          controller: controller,
          children: [doubleView(views, 0, 1)],
        );
      case 3:
        return PageView(
          controller: controller,
          children: [tripleView(views, 0, 2, 3)],
        );
      case 4:
        return PageView(controller: controller, children: [
          quadView(views, 0, 2, 4),
        ]);
      case 5:
        return PageView(
            controller: controller,
            children: [quadView(views, 0, 2, 4), singleView(views, 4)]);
      case 6:
        return PageView(
          controller: controller,
          children: [quadView(views, 0, 2, 4), doubleView(views, 4, 5)],
        );
      case 7:
        return PageView(
          controller: controller,
          children: [quadView(views, 0, 2, 4), tripleView(views, 4, 6, 7)],
        );
      case 8:
        return PageView(
          controller: controller,
          children: [
            quadView(views, 0, 2, 4),
            quadView(views, 4, 6, 8),
          ],
        );
      case 9:
        return PageView(
          controller: controller,
          children: [
            quadView(views, 0, 2, 4),
            quadView(views, 4, 6, 8),
            singleView(views, 8)
          ],
        );
      case 10:
        return PageView(
          controller: controller,
          children: [
            quadView(views, 0, 2, 4),
            quadView(views, 4, 6, 8),
            doubleView(views, 8, 9)
          ],
        );
      case 11:
        return PageView(
          controller: controller,
          children: [
            quadView(views, 0, 2, 4),
            quadView(views, 4, 6, 8),
            tripleView(views, 8, 10, 11)
          ],
        );
      case 12:
        return PageView(
          controller: controller,
          children: [
            quadView(views, 0, 2, 4),
            quadView(views, 4, 6, 8),
            quadView(views, 8, 10, 12)
          ],
        );
      case 13:
        return PageView(
          controller: controller,
          children: [
            quadView(views, 0, 2, 4),
            quadView(views, 4, 6, 8),
            quadView(views, 8, 10, 12),
            singleView(views, 12)
          ],
        );
      case 14:
        return PageView(
          controller: controller,
          children: [
            quadView(views, 0, 2, 4),
            quadView(views, 4, 6, 8),
            quadView(views, 8, 10, 12),
            doubleView(views, 12, 13)
          ],
        );
      case 15:
        return PageView(
          controller: controller,
          children: [
            quadView(views, 0, 2, 4),
            quadView(views, 4, 6, 8),
            quadView(views, 8, 10, 12),
            tripleView(views, 12, 14, 15)
          ],
        );
      case 16:
        return PageView(
          controller: controller,
          children: [
            quadView(views, 0, 2, 4),
            quadView(views, 4, 6, 8),
            quadView(views, 8, 10, 12),
            quadView(views, 12, 14, 16)
          ],
        );
      case 17:
        return PageView(
          controller: controller,
          children: [
            quadView(views, 0, 2, 4),
            quadView(views, 4, 6, 8),
            quadView(views, 8, 10, 12),
            quadView(views, 12, 14, 16),
            singleView(views, 16)
          ],
        );
      case 18:
        return PageView(
          controller: controller,
          children: [
            quadView(views, 0, 2, 4),
            quadView(views, 4, 6, 8),
            quadView(views, 8, 10, 12),
            quadView(views, 12, 14, 16),
            doubleView(views, 16, 17)
          ],
        );
      case 19:
        return PageView(
          controller: controller,
          children: [
            quadView(views, 0, 2, 4),
            quadView(views, 4, 6, 8),
            quadView(views, 8, 10, 12),
            quadView(views, 12, 14, 16),
            tripleView(views, 16, 18, 19)
          ],
        );
      case 20:
        return PageView(
          controller: controller,
          children: [
            quadView(views, 0, 2, 4),
            quadView(views, 4, 6, 8),
            quadView(views, 8, 10, 12),
            quadView(views, 12, 14, 16),
            quadView(views, 16, 18, 20),
          ],
        );
      case 21:
        return PageView(
          controller: controller,
          children: [
            quadView(views, 0, 2, 4),
            quadView(views, 4, 6, 8),
            quadView(views, 8, 10, 12),
            quadView(views, 12, 14, 16),
            quadView(views, 16, 18, 20),
            singleView(views, 20)
          ],
        );
      case 22:
        return PageView(
          controller: controller,
          children: [
            quadView(views, 0, 2, 4),
            quadView(views, 4, 6, 8),
            quadView(views, 8, 10, 12),
            quadView(views, 12, 14, 16),
            quadView(views, 16, 18, 20),
            doubleView(views, 20, 21)
          ],
        );
      case 23:
        return PageView(
          controller: controller,
          children: [
            quadView(views, 0, 2, 4),
            quadView(views, 4, 6, 8),
            quadView(views, 8, 10, 12),
            quadView(views, 12, 14, 16),
            quadView(views, 16, 18, 20),
            tripleView(views, 20, 22, 23)
          ],
        );
      case 24:
        return PageView(
          controller: controller,
          children: [
            quadView(views, 0, 2, 4),
            quadView(views, 4, 6, 8),
            quadView(views, 8, 10, 12),
            quadView(views, 12, 14, 16),
            quadView(views, 16, 18, 20),
            quadView(views, 20, 22, 24),
          ],
        );
      case 25:
        return PageView(
          controller: controller,
          children: [
            quadView(views, 0, 2, 4),
            quadView(views, 4, 6, 8),
            quadView(views, 8, 10, 12),
            quadView(views, 12, 14, 16),
            quadView(views, 16, 18, 20),
            quadView(views, 20, 22, 24),
            singleView(views, 24)
          ],
        );
      case 26:
        return PageView(
          controller: controller,
          children: [
            quadView(views, 0, 2, 4),
            quadView(views, 4, 6, 8),
            quadView(views, 8, 10, 12),
            quadView(views, 12, 14, 16),
            quadView(views, 16, 18, 20),
            quadView(views, 20, 22, 24),
            doubleView(views, 24, 25)
          ],
        );
      case 27:
        return PageView(
          controller: controller,
          children: [
            quadView(views, 0, 2, 4),
            quadView(views, 4, 6, 8),
            quadView(views, 8, 10, 12),
            quadView(views, 12, 14, 16),
            quadView(views, 16, 18, 20),
            quadView(views, 20, 22, 24),
            tripleView(views, 24, 26, 27)
          ],
        );
      case 28:
        return PageView(
          controller: controller,
          children: [
            quadView(views, 0, 2, 4),
            quadView(views, 4, 6, 8),
            quadView(views, 8, 10, 12),
            quadView(views, 12, 14, 16),
            quadView(views, 16, 18, 20),
            quadView(views, 20, 22, 24),
            quadView(views, 24, 26, 28),
          ],
        );
      case 29:
        return PageView(
          controller: controller,
          children: [
            quadView(views, 0, 2, 4),
            quadView(views, 4, 6, 8),
            quadView(views, 8, 10, 12),
            quadView(views, 12, 14, 16),
            quadView(views, 16, 18, 20),
            quadView(views, 20, 22, 24),
            quadView(views, 24, 26, 28),
            singleView(views, 28)
          ],
        );
      case 30:
        return PageView(
          controller: controller,
          children: [
            quadView(views, 0, 2, 4),
            quadView(views, 4, 6, 8),
            quadView(views, 8, 10, 12),
            quadView(views, 12, 14, 16),
            quadView(views, 16, 18, 20),
            quadView(views, 20, 22, 24),
            quadView(views, 24, 26, 28),
            doubleView(views, 28, 29)
          ],
        );
      case 31:
        return PageView(
          controller: controller,
          children: [
            quadView(views, 0, 2, 4),
            quadView(views, 4, 6, 8),
            quadView(views, 8, 10, 12),
            quadView(views, 12, 14, 16),
            quadView(views, 16, 18, 20),
            quadView(views, 20, 22, 24),
            quadView(views, 24, 26, 28),
            tripleView(views, 28, 30, 31)
          ],
        );
      case 32:
        return PageView(
          controller: controller,
          children: [
            quadView(views, 0, 2, 4),
            quadView(views, 4, 6, 8),
            quadView(views, 8, 10, 12),
            quadView(views, 12, 14, 16),
            quadView(views, 16, 18, 20),
            quadView(views, 20, 22, 24),
            quadView(views, 24, 26, 28),
            quadView(views, 28, 30, 32),
          ],
        );
      case 33:
        return PageView(
          controller: controller,
          children: [
            quadView(views, 0, 2, 4),
            quadView(views, 4, 6, 8),
            quadView(views, 8, 10, 12),
            quadView(views, 12, 14, 16),
            quadView(views, 16, 18, 20),
            quadView(views, 20, 22, 24),
            quadView(views, 24, 26, 28),
            quadView(views, 28, 30, 32),
            singleView(views, 32)
          ],
        );
      case 34:
        return PageView(
          controller: controller,
          children: [
            quadView(views, 0, 2, 4),
            quadView(views, 4, 6, 8),
            quadView(views, 8, 10, 12),
            quadView(views, 12, 14, 16),
            quadView(views, 16, 18, 20),
            quadView(views, 20, 22, 24),
            quadView(views, 24, 26, 28),
            quadView(views, 28, 30, 32),
            doubleView(views, 32, 33)
          ],
        );
      case 35:
        return PageView(
          controller: controller,
          children: [
            quadView(views, 0, 2, 4),
            quadView(views, 4, 6, 8),
            quadView(views, 8, 10, 12),
            quadView(views, 12, 14, 16),
            quadView(views, 16, 18, 20),
            quadView(views, 20, 22, 24),
            quadView(views, 24, 26, 28),
            quadView(views, 28, 30, 32),
            tripleView(views, 32, 34, 35)
          ],
        );
      case 36:
        return PageView(
          controller: controller,
          children: [
            quadView(views, 0, 2, 4),
            quadView(views, 4, 6, 8),
            quadView(views, 8, 10, 12),
            quadView(views, 12, 14, 16),
            quadView(views, 16, 18, 20),
            quadView(views, 20, 22, 24),
            quadView(views, 24, 26, 28),
            quadView(views, 28, 30, 32),
            quadView(views, 32, 34, 36),
          ],
        );
      case 37:
        return PageView(
          controller: controller,
          children: [
            quadView(views, 0, 2, 4),
            quadView(views, 4, 6, 8),
            quadView(views, 8, 10, 12),
            quadView(views, 12, 14, 16),
            quadView(views, 16, 18, 20),
            quadView(views, 20, 22, 24),
            quadView(views, 24, 26, 28),
            quadView(views, 28, 30, 32),
            quadView(views, 32, 34, 36),
            singleView(views, 36)
          ],
        );
      case 38:
        return PageView(
          controller: controller,
          children: [
            quadView(views, 0, 2, 4),
            quadView(views, 4, 6, 8),
            quadView(views, 8, 10, 12),
            quadView(views, 12, 14, 16),
            quadView(views, 16, 18, 20),
            quadView(views, 20, 22, 24),
            quadView(views, 24, 26, 28),
            quadView(views, 28, 30, 32),
            quadView(views, 32, 34, 36),
            doubleView(views, 36, 37)
          ],
        );
      case 39:
        return PageView(
          controller: controller,
          children: [
            quadView(views, 0, 2, 4),
            quadView(views, 4, 6, 8),
            quadView(views, 8, 10, 12),
            quadView(views, 12, 14, 16),
            quadView(views, 16, 18, 20),
            quadView(views, 20, 22, 24),
            quadView(views, 24, 26, 28),
            quadView(views, 28, 30, 32),
            quadView(views, 32, 34, 36),
            tripleView(views, 36, 38, 39)
          ],
        );
      case 40:
        return PageView(
          controller: controller,
          children: [
            quadView(views, 0, 2, 4),
            quadView(views, 4, 6, 8),
            quadView(views, 8, 10, 12),
            quadView(views, 12, 14, 16),
            quadView(views, 16, 18, 20),
            quadView(views, 20, 22, 24),
            quadView(views, 24, 26, 28),
            quadView(views, 28, 30, 32),
            quadView(views, 32, 34, 36),
            quadView(views, 36, 38, 40),
          ],
        );
      case 41:
        return PageView(
          controller: controller,
          children: [
            quadView(views, 0, 2, 4),
            quadView(views, 4, 6, 8),
            quadView(views, 8, 10, 12),
            quadView(views, 12, 14, 16),
            quadView(views, 16, 18, 20),
            quadView(views, 20, 22, 24),
            quadView(views, 24, 26, 28),
            quadView(views, 28, 30, 32),
            quadView(views, 32, 34, 36),
            quadView(views, 36, 38, 40),
            singleView(views, 40)
          ],
        );
      case 42:
        return PageView(
          controller: controller,
          children: [
            quadView(views, 0, 2, 4),
            quadView(views, 4, 6, 8),
            quadView(views, 8, 10, 12),
            quadView(views, 12, 14, 16),
            quadView(views, 16, 18, 20),
            quadView(views, 20, 22, 24),
            quadView(views, 24, 26, 28),
            quadView(views, 28, 30, 32),
            quadView(views, 32, 34, 36),
            quadView(views, 36, 38, 40),
            doubleView(views, 40, 41)
          ],
        );
      case 43:
        return PageView(
          controller: controller,
          children: [
            quadView(views, 0, 2, 4),
            quadView(views, 4, 6, 8),
            quadView(views, 8, 10, 12),
            quadView(views, 12, 14, 16),
            quadView(views, 16, 18, 20),
            quadView(views, 20, 22, 24),
            quadView(views, 24, 26, 28),
            quadView(views, 28, 30, 32),
            quadView(views, 32, 34, 36),
            quadView(views, 36, 38, 40),
            tripleView(views, 40, 42, 43)
          ],
        );
      case 44:
        return PageView(
          controller: controller,
          children: [
            quadView(views, 0, 2, 4),
            quadView(views, 4, 6, 8),
            quadView(views, 8, 10, 12),
            quadView(views, 12, 14, 16),
            quadView(views, 16, 18, 20),
            quadView(views, 20, 22, 24),
            quadView(views, 24, 26, 28),
            quadView(views, 28, 30, 32),
            quadView(views, 32, 34, 36),
            quadView(views, 36, 38, 40),
            quadView(views, 40, 42, 44),
          ],
        );
      case 45:
        return PageView(
          controller: controller,
          children: [
            quadView(views, 0, 2, 4),
            quadView(views, 4, 6, 8),
            quadView(views, 8, 10, 12),
            quadView(views, 12, 14, 16),
            quadView(views, 16, 18, 20),
            quadView(views, 20, 22, 24),
            quadView(views, 24, 26, 28),
            quadView(views, 28, 30, 32),
            quadView(views, 32, 34, 36),
            quadView(views, 36, 38, 40),
            quadView(views, 40, 42, 44),
            singleView(views, 44)
          ],
        );
      case 46:
        return PageView(
          controller: controller,
          children: [
            quadView(views, 0, 2, 4),
            quadView(views, 4, 6, 8),
            quadView(views, 8, 10, 12),
            quadView(views, 12, 14, 16),
            quadView(views, 16, 18, 20),
            quadView(views, 20, 22, 24),
            quadView(views, 24, 26, 28),
            quadView(views, 28, 30, 32),
            quadView(views, 32, 34, 36),
            quadView(views, 36, 38, 40),
            quadView(views, 40, 42, 44),
            doubleView(views, 44, 45)
          ],
        );
      case 47:
        return PageView(
          controller: controller,
          children: [
            quadView(views, 0, 2, 4),
            quadView(views, 4, 6, 8),
            quadView(views, 8, 10, 12),
            quadView(views, 12, 14, 16),
            quadView(views, 16, 18, 20),
            quadView(views, 20, 22, 24),
            quadView(views, 24, 26, 28),
            quadView(views, 28, 30, 32),
            quadView(views, 32, 34, 36),
            quadView(views, 36, 38, 40),
            quadView(views, 40, 42, 44),
            tripleView(views, 44, 46, 47)
          ],
        );
      case 48:
        return PageView(
          controller: controller,
          children: [
            quadView(views, 0, 2, 4),
            quadView(views, 4, 6, 8),
            quadView(views, 8, 10, 12),
            quadView(views, 12, 14, 16),
            quadView(views, 16, 18, 20),
            quadView(views, 20, 22, 24),
            quadView(views, 24, 26, 28),
            quadView(views, 28, 30, 32),
            quadView(views, 32, 34, 36),
            quadView(views, 36, 38, 40),
            quadView(views, 40, 42, 44),
            quadView(views, 44, 46, 48),
          ],
        );
      case 49:
        return PageView(
          controller: controller,
          children: [
            quadView(views, 0, 2, 4),
            quadView(views, 4, 6, 8),
            quadView(views, 8, 10, 12),
            quadView(views, 12, 14, 16),
            quadView(views, 16, 18, 20),
            quadView(views, 20, 22, 24),
            quadView(views, 24, 26, 28),
            quadView(views, 28, 30, 32),
            quadView(views, 32, 34, 36),
            quadView(views, 36, 38, 40),
            quadView(views, 40, 42, 44),
            quadView(views, 44, 46, 48),
            singleView(views, 48)
          ],
        );
      case 50:
        return PageView(
          controller: controller,
          children: [
            quadView(views, 0, 2, 4),
            quadView(views, 4, 6, 8),
            quadView(views, 8, 10, 12),
            quadView(views, 12, 14, 16),
            quadView(views, 16, 18, 20),
            quadView(views, 20, 22, 24),
            quadView(views, 24, 26, 28),
            quadView(views, 28, 30, 32),
            quadView(views, 32, 34, 36),
            quadView(views, 36, 38, 40),
            quadView(views, 40, 42, 44),
            quadView(views, 44, 46, 48),
            doubleView(views, 48, 49)
          ],
        );
      case 51:
        return PageView(
          controller: controller,
          children: [
            quadView(views, 0, 2, 4),
            quadView(views, 4, 6, 8),
            quadView(views, 8, 10, 12),
            quadView(views, 12, 14, 16),
            quadView(views, 16, 18, 20),
            quadView(views, 20, 22, 24),
            quadView(views, 24, 26, 28),
            quadView(views, 28, 30, 32),
            quadView(views, 32, 34, 36),
            quadView(views, 36, 38, 40),
            quadView(views, 40, 42, 44),
            quadView(views, 44, 46, 48),
            tripleView(views, 48, 50, 51)
          ],
        );
      case 52:
        return PageView(
          controller: controller,
          children: [
            quadView(views, 0, 2, 4),
            quadView(views, 4, 6, 8),
            quadView(views, 8, 10, 12),
            quadView(views, 12, 14, 16),
            quadView(views, 16, 18, 20),
            quadView(views, 20, 22, 24),
            quadView(views, 24, 26, 28),
            quadView(views, 28, 30, 32),
            quadView(views, 32, 34, 36),
            quadView(views, 36, 38, 40),
            quadView(views, 40, 42, 44),
            quadView(views, 44, 46, 48),
            quadView(views, 48, 50, 52),
          ],
        );
      default:
    }
    return Container();
  }

  Container quadView(
      views, int firstStartingPart, int firstEndingPart, int secondEndingPart) {
    return Container(
        child: Column(
      children: <Widget>[
        _expandedVideoRow(views.sublist(firstStartingPart, firstEndingPart)),
        _expandedVideoRow(views.sublist(firstEndingPart, secondEndingPart))
      ],
    ));
  }

  Container tripleView(
      views, int firstStartingPart, int firstEndingPart, int secondEndingPart) {
    return Container(
        child: Column(
      children: <Widget>[
        _expandedVideoRow(views.sublist(firstStartingPart, firstEndingPart)),
        _expandedVideoRow(views.sublist(firstEndingPart, secondEndingPart))
      ],
    ));
  }

  Container doubleView(
      views, int userViewNumberPart1, int userViewNumberPart2) {
    return Container(
        child: Column(
      children: <Widget>[
        _expandedVideoRow([views[userViewNumberPart1]]),
        _expandedVideoRow([views[userViewNumberPart2]])
      ],
    ));
  }

  Container singleView(views, int userViewNumber) {
    return Container(
        child: Column(
      children: <Widget>[_videoView(views[userViewNumber])],
    ));
  }

  /// Toolbar layout
  Widget _toolbar() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: _onToggleMute,
            child: Icon(
              muted ? Icons.mic_off : Icons.mic,
              color: muted ? Colors.white : Colors.blueAccent,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: muted ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12.0),
          ),
          RawMaterialButton(
            onPressed: () => _onCallEnd(context),
            child: Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
          ),
          RawMaterialButton(
            onPressed: _onSwitchCamera,
            child: Icon(
              Icons.switch_camera,
              color: Colors.blueAccent,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12.0),
          )
        ],
      ),
    );
  }

  /// Info panel to show logs
  Widget _panel() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48),
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        heightFactor: 0.5,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 48),
          child: ListView.builder(
            reverse: true,
            itemCount: _infoStrings.length,
            itemBuilder: (BuildContext context, int index) {
              if (_infoStrings.isEmpty) {
                return null;
              }
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 10,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
//                    Flexible(
//                      child: Container(
//                        padding: const EdgeInsets.symmetric(
//                          vertical: 2,
//                          horizontal: 5,
//                        ),
//                        decoration: BoxDecoration(
//                          color: Colors.yellowAccent,
//                          borderRadius: BorderRadius.circular(5),
//                        ),
//                        child: Text(
//                          _infoStrings[index],
//                          style: TextStyle(color: Colors.blueGrey),
//                        ),
//                      ),
//                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _onCallEnd(BuildContext context) {
    Navigator.pop(context);
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    AgoraRtcEngine.muteLocalAudioStream(muted);
  }

  void _onSwitchCamera() {
    AgoraRtcEngine.switchCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
            child: IconButton(
              icon: Icon(Icons.brush),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MyWhiteBoard();
                }));
              },
            ),
          ),
        ],
        title: Text('Delight Video chat'),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          children: <Widget>[
            _viewRows(),
            _panel(),
            _toolbar(),
          ],
        ),
      ),
    );
  }
}
