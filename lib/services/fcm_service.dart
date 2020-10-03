import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firecek_stacked_architecture/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging();
  Future initialise() async {
    if (Platform.isIOS) {
      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        var _data = message['data'];
        var _title = _data['title'];
        var _content = _data['message'];
        _showNotification(_title, _content);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }

  dynamic _showNotification(String title, String content) {
    return showSimpleNotification(
      Text(title),
      subtitle: Text(content),
      background: Colors.red,
      duration: notificationShowTime,
      autoDismiss: true,
      trailing: Builder(builder: (context) {
        return FlatButton(
            textColor: Colors.yellow,
            onPressed: () {
              OverlaySupportEntry.of(context).dismiss();
            },
            child: Text('Dismiss'));
      }),
    );
  }

  Future subscribeToTopic(String topic) async {
    print('(TRACE) PushNotificationService:subscribeToTopic. topic: $topic');
    await _fcm.subscribeToTopic(topic);
  }

  Future unsubscribeToTopic(String topic) async {
    print('(TRACE) PushNotificationService:unsubscribeToTopic. topic: $topic');
    await _fcm.unsubscribeFromTopic(topic);
  }
}
