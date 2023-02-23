import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/localizations/localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:sample/firebase_options.dart';
import 'package:sample/l10n/supportLocale.dart';
import 'package:sample/pages/notifications/notification_service.dart';
import 'package:sample/pages/settings/setting_getx_controller.dart';
import 'package:sample/routes/routes.gr.dart';
import 'package:sample/theme/theme.dart';

import 'package:sample/theme/theme_getx_controller.dart';
import 'package:sample/utils/cache/cache_getx_controller.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print('Handling a background message ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.requestPermission();
  await FirebaseMessaging.instance.getInitialMessage();
  await FirebaseMessaging.instance.getNotificationSettings();
  await FirebaseMessaging.instance.getToken();
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  //////////////////////////////////////
  String? token = await FirebaseMessaging.instance.getToken();
  print("token: " + token.toString());
  /////////////////////////////////////
  Get.lazyPut(() => SettingGetX(), tag: SettingGetX.tag);
  Get.lazyPut(() => CacheGetx(), tag: CacheGetx.tag);
  Get.lazyPut(() => ThemeGetX(), tag: ThemeGetX.tag);

  await _getLocale();
  await _getTheme();
  runApp(const MyMainApp());
}

final appRouter = AppRouter();

class MyMainApp extends StatefulWidget {
  const MyMainApp({Key? key}) : super(key: key);
  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<MyMainApp> createState() => _MyMainAppState();
}

class _MyMainAppState extends State<MyMainApp> {
  String mtoken = "";
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    NotificationService().requestPermissionToSendNotifications();
    NotificationService().initNotification();
    NotificationService().initInfo();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    SettingGetX languageGetX = Get.find(tag: SettingGetX.tag);
    ThemeGetX themeGetX = Get.find<ThemeGetX>(tag: ThemeGetX.tag);
    return Obx(() {
      return MaterialApp.router(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: themeGetX.themeGetx.value,
        localizationsDelegates: const [
          AppLocalizations.delegate, //ung dung
          CoreLocalizations.delegate, //mac dinh cua thu vien
          ExternalLocalizations.delegate, //da ngon ngu tu file .json
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: languageGetX.localeGetx.value,
        supportedLocales: L10n.support,
        routerDelegate: appRouter.delegate(),
        routeInformationParser: appRouter.defaultRouteParser(),
      );
    });
  }
}

Future _getLocale() async {
  final cacheGetx = Get.find<CacheGetx>(tag: CacheGetx.tag);
  final settingGetX = Get.find<SettingGetX>(tag: SettingGetX.tag);
  await cacheGetx.loadFromDisk();

  if (cacheGetx.locale.isNotEmpty) {
    if (cacheGetx.locale == 'vi') {
      settingGetX.localeGetx.value = const Locale('vi');
    } else {
      settingGetX.localeGetx.value = const Locale('en');
    }
  } else {
    if (Platform.localeName.toLowerCase() == 'vi_vn'.toLowerCase()) {
      settingGetX.localeGetx.value = const Locale('vi');
    } else {
      settingGetX.localeGetx.value = const Locale('en');
    }
  }
}

Future _getTheme() async {
  final cacheGetx = Get.find<CacheGetx>(tag: CacheGetx.tag);
  final ThemeGetX themeGetX = Get.find<ThemeGetX>(tag: ThemeGetX.tag);
  await cacheGetx.loadFromDisk();
  String theme = cacheGetx.theme.toString();
  if (theme.isNotEmpty) {
    if (theme == "primary_theme") {
      themeGetX.themeGetx.value = primaryTheme;
    } else if (theme == "secondary_theme") {
      themeGetX.themeGetx.value = secondaryTheme;
    }
  } else {
    themeGetX.themeGetx.value = primaryTheme;
  }
}
