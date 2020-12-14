import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Center(
              child: RaisedButton(
                child: Text("Bildirim Göster"),
                onPressed: () {
                  LocalNotification().sendNow("Başlık", "Body", "1");
                },
              ),
            ),
          ),
          Container(
            child: Center(
              child: RaisedButton(
                child: Text("zamanlı Bildirim Göster"),
                onPressed: () {
                  LocalNotification().setDailyNotification(
                      13, 22, 1, "Zamanlı ", "Zaman sayaçlı bildirim ");
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LocalNotification {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  LocalNotification() {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  sendNow(String title, String body, String payload) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        '0012', 'Kronometre', 'Kronometre',
        importance: Importance.max, priority: Priority.high, ticker: 'ticker');

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin
        .show(0, title, body, platformChannelSpecifics, payload: payload);
  }

  Future setDailyNotification(
      int hour, int minute, int id, String title, String body) async {
    var time = Time(hour, minute, 0);
    var androidPlatformChannelSpecifics =
        AndroidNotificationDetails('0011', 'Kronometre', 'Kronometre');

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.showDailyAtTime(
        id, title, body, time, platformChannelSpecifics);
  }
}
