import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sample/main.dart';
import 'package:sample/routes/routes.gr.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  // static final BehaviorSubject<String?> onNotifications =
  //     BehaviorSubject<String?>();
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
    var details = await notificationsPlugin.getNotificationAppLaunchDetails();
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
        final String? payload = notificationResponse.payload;
        _handleMessage();
      },
    );
  }

  Future<void> initInfo() async {
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        if (message.notification != null) {
          print("messageId: " + message.messageId.toString());
          print("messageTitle: " + message.notification!.title.toString());
          print("messageContent: " + message.notification!.body.toString());
          // print("messageImageAndroid: " +
          //     message.notification!.android!.imageUrl.toString());
          print("messageImageApple: " +
              message.notification!.apple!.imageUrl.toString());
          // if (message.notification?.android?.imageUrl != null ||
          //     message.notification?.apple?.imageUrl != null) {
          showImageNotification(message);
          // } else {
          //   showBasicNotification(message);
          // }
        }
      },
    );
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

  void showBasicNotification(RemoteMessage message) async {
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
      //payload: message.data[""],
    );
  }
  //   void showFlutterNotification(RemoteMessage message) async {
  //   print(message.toMap());
  //   RemoteNotification? notification = message.notification;

  //   if (notification != null) {
  //     final url =
  //         notification.apple?.imageUrl ?? notification.android?.imageUrl ?? '';
  //     if (url.isNotEmpty) {
  //       final image = await _downloadAndSaveFile(url, 'noti_image');
  //       // final largeIcon =
  //       //     ByteArrayAndroidBitmap(await DownloadUtil.getByteArrayFromUrl(url));
  //       print(image);
  //       notificationsPlugin.show(
  //         notification.hashCode,
  //         notification.title,
  //         notification.body,
  //         NotificationDetails(
  //             android: AndroidNotificationDetails(
  //               message.messageId,
  //               channel.name,
  //               channelDescription: channel.description,
  //               //largeIcon: largeIcon,
  //               styleInformation: BigPictureStyleInformation(
  //                 FilePathAndroidBitmap(image),
  //                 //largeIcon: largeIcon,
  //                 hideExpandedLargeIcon: false,
  //               ),
  //               icon: 'launch_background',
  //             ),
  //             iOS: DarwinNotificationDetails(
  //                 subtitle: notification.apple?.subtitle,
  //                 presentSound: true,
  //                 interruptionLevel: InterruptionLevel.critical,
  //                 attachments: [
  //                   DarwinNotificationAttachment(
  //                     image,
  //                   ),
  //                 ])),
  //       );
  //     } else {
  //       notificationsPlugin.show(
  //         notification.hashCode,
  //         notification.title,
  //         notification.body,
  //         NotificationDetails(
  //             android: AndroidNotificationDetails(
  //               channel.id,
  //               channel.name,
  //               channelDescription: channel.description,
  //               icon: 'launch_background',
  //             ),
  //             iOS: DarwinNotificationDetails(
  //                 subtitle: notification.apple?.subtitle,
  //                 presentSound: true,
  //                 interruptionLevel: InterruptionLevel.critical,
  //                 attachments: [])),
  //       );
  //     }
  //   }
  // }
  Future<void> showImageNotification(RemoteMessage message) async {
    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final url = message.notification?.android?.imageUrl ??
        message.notification?.apple?.imageUrl ??
        "";
    final String largeIconPath = await _downloadAndSaveFile(url, 'largeIcon');
    final String bigPicturePath = await _downloadAndSaveFile(url, 'bigPicture');

    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(FilePathAndroidBitmap(bigPicturePath),
            //largeIcon: FilePathAndroidBitmap(largeIconPath),
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
      //payload: "",
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
