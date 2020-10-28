import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firecek_stacked_architecture/services/flashlight_service.dart';
import 'package:firecek_stacked_architecture/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../main.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging();
  Future initialise() async {
    if (Platform.isIOS) {
      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }

    _fcm.configure(
      onBackgroundMessage: backgroundMessageHandler,
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        var _data = message['data'];
        var _title = _data['title'];
        var _content = _data['message'];
        var _productType = _data['product_type'];
        //must update
        showNotificationWithDefaultSound(_title, _content,
            productType: _productType);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        var _data = message['data'];
        var _title = _data['title'];
        var _content = _data['message'];
        var _productType = _data['product_type'];
        //must update
        showNotificationWithDefaultSound(_title, _content,
            productType: _productType);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        var _data = message['data'];
        var _title = _data['title'];
        var _content = _data['message'];
        var _productType = _data['product_type'];
        //must update
        showNotificationWithDefaultSound(_title, _content,
            productType: _productType);
      },
    );
  }

  //add local notification
  static Future showNotificationWithDefaultSound(String title, String message,
      {String productType}) async {
    //flashlight
    FlashLightService _flashLightService = FlashLightService();
    //register plugin
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    //settings
    AndroidInitializationSettings androidInitializationSettings;
    //IOSInitializationSettings iosInitializationSettings;
    InitializationSettings initializationSettings;
    androidInitializationSettings = AndroidInitializationSettings('app_icon');

    initializationSettings =
        InitializationSettings(android: androidInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
    //pattern
    var vibrationPattern = Int64List(4);
    vibrationPattern[0] = 0;
    vibrationPattern[1] = 1000;
    vibrationPattern[2] = 5000;
    vibrationPattern[3] = 2000;
    //waterlevelmonitor
    var waterlevelMonitorAndroidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            '0', 'waterlevelmonitor', 'waterlevelmonitor-notification',
            importance: Importance.high,
            priority: Priority.high,
            enableVibration: true,
            color: Colors.red,
            enableLights: true,
            autoCancel: false,
            playSound: true,
            fullScreenIntent: true,
            vibrationPattern: vibrationPattern,
            ledColor: const Color.fromARGB(255, 255, 255, 0),
            ledOnMs: 1000,
            ledOffMs: 500);
    //firemonitor
    var fireMonitorAndroidPlatformChannelSpecifics = AndroidNotificationDetails(
        '1', 'firemonitor', 'firemonitor-notification',
        importance: Importance.max,
        priority: Priority.max,
        sound: RawResourceAndroidNotificationSound('fire_alarm'),
        enableVibration: true,
        color: Colors.red,
        enableLights: true,
        autoCancel: false,
        playSound: true,
        fullScreenIntent: true,
        vibrationPattern: vibrationPattern,
        ledColor: const Color.fromARGB(255, 255, 0, 0),
        ledOnMs: 1000,
        ledOffMs: 500);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics;
    if (productType == WATERTANKMONITORING) {
      platformChannelSpecifics = NotificationDetails(
          android: waterlevelMonitorAndroidPlatformChannelSpecifics,
          iOS: iOSPlatformChannelSpecifics);
    } else if (productType == FIREMONITORING) {
      await _flashLightService.turnOn();
      platformChannelSpecifics = NotificationDetails(
          android: fireMonitorAndroidPlatformChannelSpecifics,
          iOS: iOSPlatformChannelSpecifics);
    }

    await flutterLocalNotificationsPlugin.show(
      0,
      '$title',
      '$message',
      platformChannelSpecifics,
      payload: 'berhasil',
    );
  }

  static Future onSelectNotification(String payload) async {
    final FlashLightService _flashLightService = FlashLightService();
    await _flashLightService.turnOff();
    if (payload != null) {
      print(payload);
    }
  }

  Future subscribeToTopic(String topic) async {
    bool result = true;

    await _fcm.subscribeToTopic(topic).catchError((error) => result = false);
    print(
        '(TRACE) PushNotificationService:subscribeToTopic. topic: $topic result: $result');
    return result;
  }

  Future unsubscribeToTopic(String topic) async {
    bool result = true;
    print(
        '(TRACE) PushNotificationService:unsubscribeToTopic. topic: $topic  result: $result');
    await _fcm
        .unsubscribeFromTopic(topic)
        .catchError((error) => result = false);
    return result;
  }
}
