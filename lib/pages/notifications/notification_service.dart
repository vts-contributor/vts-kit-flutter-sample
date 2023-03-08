import 'dart:async';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sample/routes/routes_handler.dart';

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

  Future<void> initNotification() async {
    //icon notification android
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

    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        if (notificationResponse.payload != null) {
          final path = notificationResponse.payload.toString();
          RoutesHandler.shared.redirectRoute(path);
        }
      },
    );
  }

  Future<void> initInfo() async {
    //listen to show notification
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null) {
          showNotification(message);
        }
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
      String path = message.data.values.toString();
      RoutesHandler.shared.redirectRoute(path);
    }
  }

  Future<void> showNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    if (notification != null) {
      String url = message.notification?.android?.imageUrl ??
          message.notification?.apple?.imageUrl ??
          "";
      if (url.isNotEmpty) {
        imageNotification(message);
      } else {
        basicNotification(message);
      }
    }
  }

//Show basic notification with title and text
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

//Show notification with image
  Future<void> imageNotification(RemoteMessage message) async {
    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final url = message.notification?.android?.imageUrl ??
        message.notification?.apple?.imageUrl ??
        "";
    final String largeIconPath = await _downloadAndSaveFile(url, 'largeIcon');
    final String bigPicturePath = await _downloadAndSaveFile(url, 'bigPicture');

    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath),
      largeIcon: FilePathAndroidBitmap(largeIconPath),
      contentTitle: message.notification?.title ?? "",
      htmlFormatContentTitle: true,
      summaryText: message.notification?.body ?? "",
      htmlFormatSummaryText: true,
    );
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

//Download and save image file
  Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }
}
