// class NotificationService {
//   final FlutterLocalNotificationsPlugin _localNoti;
//   final FirebaseMessaging _message;

//   NotificationService(
//     this._localNoti,
//     this._message,
//   );

//   late AndroidNotificationChannel _channel;
//   late AndroidNotificationDetails _androidDetails;
//   late DarwinNotificationDetails _iosDetails;

//   init() {
//     this._channel = const AndroidNotificationChannel(
//       'high_importance_channel', // id
//       'High Importance Notifications', // title
//       description:
//           'This channel is used for important notifications.', // description
//       importance: Importance.high,
//     );
//     //
//     //   this._androidDetails = AndroidNotificationDetails(
//     //     _channel.id,
//     //     _channel.name,
//     //     channelDescription: _channel.description,
//     //     largeIcon: largeIcon,
//     //     styleInformation: BigPictureStyleInformation(
//     //       FilePathAndroidBitmap(image),
//     //       largeIcon: largeIcon,
//     //       hideExpandedLargeIcon: false,
//     //     ),
//     //     icon: 'launch_background',
//     //   );
//     // }
//   }

//   static void showFlutterNotification(RemoteMessage message) async {
//     print(message.toMap());
//     RemoteNotification? notification = message.notification;

//     if (notification != null) {
//       final url =
//           notification.apple?.imageUrl ?? notification.android?.imageUrl ?? '';
//       if (url.isNotEmpty) {
//         final image = await DownloadUtil.downloadAndSaveFile(url, 'noti_image');
//         final largeIcon =
//             ByteArrayAndroidBitmap(await DownloadUtil.getByteArrayFromUrl(url));
//         print(image);
//         flutterLocalNotificationsPlugin.show(
//           notification.hashCode,
//           notification.title,
//           notification.body,
//           NotificationDetails(
//               android: AndroidNotificationDetails(
//                 channel.id,
//                 channel.name,
//                 channelDescription: channel.description,
//                 largeIcon: largeIcon,
//                 styleInformation: BigPictureStyleInformation(
//                   FilePathAndroidBitmap(image),
//                   largeIcon: largeIcon,
//                   hideExpandedLargeIcon: false,
//                 ),
//                 icon: 'launch_background',
//               ),
//               iOS: DarwinNotificationDetails(
//                   subtitle: notification.apple?.subtitle,
//                   presentSound: true,
//                   interruptionLevel: InterruptionLevel.critical,
//                   attachments: [
//                     DarwinNotificationAttachment(
//                       image,
//                     ),
//                   ])),
//         );
//       } else {
//         flutterLocalNotificationsPlugin.show(
//           notification.hashCode,
//           notification.title,
//           notification.body,
//           NotificationDetails(
//               android: AndroidNotificationDetails(
//                 channel.id,
//                 channel.name,
//                 channelDescription: channel.description,
//                 icon: 'launch_background',
//               ),
//               iOS: DarwinNotificationDetails(
//                   subtitle: notification.apple?.subtitle,
//                   presentSound: true,
//                   interruptionLevel: InterruptionLevel.critical,
//                   attachments: [])),
//         );
//       }
//     }
//   }
// }


// mport 'dart:io';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// import 'package:mark_core/mark_core.dart';
// import 'package:mark_member_app/core/locator.dart';
// import 'package:mark_member_app/core/mark_mem_constants.dart';
// import 'package:mark_member_app/core/navigation/app_navigator.dart';
// import 'package:mark_member_app/core/navigation/route.dart';
// import 'package:mark_member_app/core/repository/announcement_repo.dart';
// import 'package:mark_member_app/core/repository/auth_repository.dart';
// import 'package:mark_member_app/core/repository/designer_profile_repo.dart';
// import 'package:mark_member_app/core/repository/designer_repo.dart';
// import 'package:mark_member_app/core/repository/director_repo.dart';
// import 'package:mark_member_app/core/repository/profile_repo.dart';
// import 'package:mark_member_app/module/login/screen/login_screen.dart';
// import 'package:mark_member_app/module/main/bloc/main_bloc.dart';
// import 'package:mark_member_app/module/main/screen/main_screen.dart';
// import 'package:mark_member_app/theme/main_theme.dart';
// import 'package:mark_member_app/utils/download_utils.dart';
// import 'package:mark_member_app/utils/notification_service.dart';

// /// Initialize the [FlutterLocalNotificationsPlugin] package.
// late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // await Firebase.initializeApp();
//   await setupFlutterNotifications();
//   NotificationService.showFlutterNotification(message);
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call initializeApp before using other Firebase services.
//   print('Handling a background message ${message.messageId}');
// }

// /// Create a [AndroidNotificationChannel] for heads up notifications
// late AndroidNotificationChannel channel;

// bool isFlutterLocalNotificationsInitialized = false;
// final message = FirebaseMessaging.instance;

// Future<void> setupFlutterNotifications() async {
//   if (isFlutterLocalNotificationsInitialized) {
//     return;
//   }
//   channel = const AndroidNotificationChannel(
//     'high_importance_channel', // id
//     'High Importance Notifications', // title
//     description:
//         'This channel is used for important notifications.', // description
//     importance: Importance.high,
//   );

//   flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//   // await flutterLocalNotificationsPlugin
//   //     .resolvePlatformSpecificImplementation<
//   //         AndroidFlutterLocalNotificationsPlugin>()
//   //     ?.createNotificationChannel(channel);

//   /// Update the iOS foreground notification presentation options to allow
//   /// heads up notifications.

//   NotificationSettings settings = await message.requestPermission(
//     alert: true,
//     announcement: false,
//     badge: true,
//     carPlay: false,
//     criticalAlert: false,
//     provisional: false,
//     sound: true,
//   );
//   await message.setForegroundNotificationPresentationOptions(
//     alert: true,
//     badge: true,
//     sound: true,
//   );

//   isFlutterLocalNotificationsInitialized = true;
// }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   setupLocator();
//   setUpMembersBloc();
//   await DataInstance().initPreference();
//   await DataInstance().checkDeviceInfo();
//   await Firebase.initializeApp();
//   await setupFlutterNotifications();


//   /firebase message listen
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//   var initMessage = await FirebaseMessaging.instance.getInitialMessage();
//   if (initMessage != null) {
//     if (initMessage.data['review_id'] != null) {
//       MBNavigator()
//           .moveToViewReview(reviewId: int.parse(initMessage.data['review_id']));
//     }
//     if (initMessage.data['project_id'] != null) {
//       MBNavigator()
//           .moveToViewProject(int.parse(initMessage.data['project_id']));
//     }
//   }
//   FirebaseMessaging.onMessage.listen(
//     (message) {
//       NotificationService.showFlutterNotification(message);
//     },
//   );

//   FirebaseMessaging.onMessageOpenedApp.listen((message) {
//     print(message.notification?.toMap());
//     if (message.data['review_id'] != null) {
//       MBNavigator()
//           .moveToViewReview(reviewId: int.parse(message.data['review_id']));
//     }
//     if (message.data['project_id'] != null) {
//       MBNavigator().moveToViewProject(int.parse(message.data['project_id']));
//     }
//   });
//   // DataInstance().initialLink = await FirebaseDynamicLinks.instance.getInitialLink();

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       navigatorKey: locator<GlobalKey<NavigatorState>>(),
//       onGenerateRoute: MBRouter.generateRoute,
//       theme: kShrineTheme,
//       // theme: ThemeData(
//       //   primarySwatch: Colors.blue,
//       // ),
//       // initialRoute: '/',
//       // routes: {
//       //   MainScreen.routeName: (context) => MainScreen()
//       // },
//       home: FutureBuilder(builder: (context, snapshot) => _getFirstScreen()),
//     );
//   }

//   Widget _getFirstScreen() {
//     return FutureBuilder<String?>(
//       future: FirebaseMessaging.instance.getToken(),
//       builder: (context, snapshot) {
//         print('Firebase token: ${snapshot.data}');
//         DataInstance().firebaseToken = snapshot.data;
//         return BlocProvider.value(
//             value: locator<MainBloc>()..add(MainStarted()),
//             child:
//                 BlocConsumer<MainBloc, MainState>(listener: (context, state) {
//               if (state.status == StateStatus.failure) {
//                 PrefsInstance().saveAccessToken('');
//                 PrefsInstance().saveLogin(false);
//                 AnimationDialog(context, content: state.message, onOk: () {})
//                     .error();
//               }
//             }, builder: (_, state) {
//               if (state.status == StateStatus.failure) {
//                 return LoginScreen();
//               }
//               if (!DataInstance().isLogin ||
//                   DataInstance().accessToken.isEmpty) {
//                 return LoginScreen();
//               }
//               return MainScreen();
//             }));
//       },
//     );
//   }
// }