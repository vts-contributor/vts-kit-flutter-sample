import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sample/main.dart';
import 'package:sample/routes/routes.gr.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Future<void> subscribeToTopic(String topic) async {
    await FirebaseMessaging.instance.subscribeToTopic(topic);
  }

  Future<void> unSubscribeFromTopic(String topic) async {
    await FirebaseMessaging.instance.unsubscribeFromTopic(topic);
  }

  Future<void> requestPermissionToSendNotifications() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: false,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User granted permisstion");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("User granted provisional permission");
    } else {
      print("User declined or has not accepted permission");
    }
  }

  Future<void> saveToken(String token) async {
    await FirebaseFirestore.instance.collection("UserTokens").doc("User1").set({
      'token': token,
    });
  }

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        _handleMessage();
      },
    );
    var details = await notificationsPlugin.getNotificationAppLaunchDetails();
    if (details!.didNotificationLaunchApp) {}
  }

  Future<void> setupInteractedMessage() async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleMessage();
    });
    FirebaseMessaging.instance.getInitialMessage().then((message) => {
          if (message != null) {_handleMessage()}
        });
  }

  void _handleMessage() {
    appRouter.push(const BottomNavBar(children: [NotificationsRouter()]));
  }

  Future<void> initInfo() async {
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        if (message.notification != null) {
          basicNotification(message);
        }
      },
    );
  }

  void basicNotification(RemoteMessage message) async {
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      message.notification!.body.toString(),
      htmlFormatContentTitle: true,
    );
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max,
            styleInformation: bigTextStyleInformation,
            priority: Priority.high,
            playSound: true);
    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: const DarwinNotificationDetails(),
    );
    await notificationsPlugin.show(
      message.notification.hashCode,
      message.notification?.title,
      message.notification?.body,
      platformChannelSpecifics,
      payload: message.data['title'],
    );
  }

  void imageNotification(RemoteMessage message) async {
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
        message.notification!.body.toString(),
        htmlFormatContentTitle: true);
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max,
            styleInformation: bigTextStyleInformation,
            priority: Priority.high,
            playSound: true);
    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: const DarwinNotificationDetails(),
    );
    await notificationsPlugin.show(
      message.notification.hashCode,
      message.notification?.title,
      message.notification?.body,
      platformChannelSpecifics,
      payload: message.data['title'],
    );
  }
}
