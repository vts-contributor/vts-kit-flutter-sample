import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sample/main.dart';
import 'package:sample/routes/routes.gr.dart';

const String notificationPage = "notification_page";
const String dashboardPage = "dashboard_page";
const String messageDataKey = "click_action";

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
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await notificationsPlugin.getNotificationAppLaunchDetails();

    final didNotificationLaunchApp =
        notificationAppLaunchDetails?.didNotificationLaunchApp ?? false;

    if (didNotificationLaunchApp) {
      //_handleMessage();
    } else {
      await notificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {
          if (notificationResponse.payload != null) {
            switch (notificationResponse.payload) {
              case notificationPage:
                _handleMessage(
                    const BottomNavBar(children: [NotificationsRouter()]));
                break;
              case dashboardPage:
                _handleMessage(
                    const BottomNavBar(children: [DashboardRouter()]));
                break;
              default:
                _handleMessage(const LoginRouter());
            }
          }
        },
      );
    }
  }

  Future<void> initInfo() async {
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        print("messageId: " + message.messageId.toString());
        print("messageTitle: " + message.notification!.title.toString());
        print("messageContent: " + message.notification!.body.toString());
        if (message.data.keys.contains(messageDataKey)) {
          print("This is a payload: " + message.data.values.toString());
        }
        showNotification(message);
      },
    );
    //notification while the app is in the background state
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _redirectNotification(message);
    });
    //notification while the app is in the terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        _redirectNotification(message);
      }
    });
  }

  void _redirectNotification(RemoteMessage message) {
    if (message.data.keys.contains(messageDataKey)) {
      if (message.data.values.contains(dashboardPage)) {
        _handleMessage(const BottomNavBar(children: [DashboardRouter()]));
      } else if (message.data.values.contains(notificationPage)) {
        _handleMessage(const BottomNavBar(children: [NotificationsRouter()]));
      }
    }
  }

  void _handleMessage(PageRouteInfo<dynamic> route) {
    appRouter.push(route);
  }

  Future<void> showNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    if (notification != null) {
      if (message.notification?.android?.imageUrl != null ||
          message.notification?.apple?.imageUrl != null) {
        imageNotification(message);
      } else {
        basicNotification(message);
      }
    }
  }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  void basicNotification(RemoteMessage message) async {
    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
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
      id,
      message.notification?.title ?? "",
      message.notification?.body ?? "",
      platformChannelSpecifics,
      payload: message.data['click_action'],
    );
  }

  Future<void> imageNotification(RemoteMessage message) async {
    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final url = message.notification?.android?.imageUrl ??
        message.notification?.apple?.imageUrl ??
        "";
    final String largeIconPath = await _downloadAndSaveFile(url, 'largeIcon');
    final String bigPicturePath = await _downloadAndSaveFile(url, 'bigPicture');

    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(FilePathAndroidBitmap(bigPicturePath),
            largeIcon: FilePathAndroidBitmap(largeIconPath),
            contentTitle: message.notification?.title ?? "",
            htmlFormatContentTitle: true,
            summaryText: message.notification?.body ?? "",
            htmlFormatSummaryText: true);
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channelId2',
      'channelName',
      importance: Importance.max,
      styleInformation: bigPictureStyleInformation,
      priority: Priority.high,
      playSound: true,
    );
    DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails(
            subtitle: message.notification?.apple?.subtitle ?? "",
            presentSound: true,
            interruptionLevel: InterruptionLevel.critical,
            attachments: [
          DarwinNotificationAttachment(
            bigPicturePath,
          ),
        ]);
    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    await notificationsPlugin.show(
      id,
      message.notification?.title ?? "",
      message.notification?.body ?? "",
      platformChannelSpecifics,
      payload: message.data['click_action'],
    );
  }

  Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }
}
