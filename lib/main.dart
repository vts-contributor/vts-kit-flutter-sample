import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/localizations/localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sample/firebase_options.dart';
import 'package:sample/l10n/supportLocale.dart';
import 'package:sample/pages/notifications/notification_service.dart';
import 'package:sample/provider/localeProvider.dart';
import 'package:sample/routes/routes.gr.dart';

import 'package:sample/theme.dart';

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
  // This widget is the root of your application.

  @override
  void initState() {
    super.initState();
    NotificationService().requestPermissionToSendNotifications();
    NotificationService().initNotification();
    NotificationService().initInfo();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LocaleProvider(),
      builder: (context, child) {
        return Consumer<LocaleProvider>(
          builder: (context, provider, child) {
            return ScreenUtilInit(
              designSize: const Size(360, 690),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context, child) {
                return MaterialApp.router(
                  title: 'Flutter Demo',
                  theme: theme(),
                  localizationsDelegates: const [
                    AppLocalizations.delegate, //ung dung
                    CoreLocalizations.delegate, //mac dinh cua thu vien
                    ExternalLocalizations.delegate, //da ngon ngu tu file .json
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  locale: provider.locale,
                  supportedLocales: L10n.support,
                  routerDelegate: appRouter.delegate(),
                  routeInformationParser: appRouter.defaultRouteParser(),
                );
              },
            );
          },
        );
      },
    );
  }
}
