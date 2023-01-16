import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/localizations/localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sample/l10n/supportLocale.dart';
import 'package:sample/notifications/firebase_controller.dart';
import 'package:sample/notifications/notifications_controller.dart';
import 'package:sample/provider/localeProvider.dart';
import 'package:sample/routes/routes.dart';
import 'package:sample/routes/routes.gr.dart';

import 'package:sample/theme.dart';

//String initialRoute = SPLASH_SCREEN;
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //firebase push notification
  AwesomeNotifications().createNotificationFromJsonData(message.data);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Setting for firebase initial
  ////////////////////////////////////////////////////////////////
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getInitialMessage();
  await FirebaseMessaging.instance.getNotificationSettings();
  await FirebaseMessaging.instance.getToken();
  await NotificationsController.initializeLocalNotifications();
  await NotificationsController.startListeningNotificationEvents();
  //////////////////////////////////////////////////////////////////

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    NotificationsController.createNewNotification(message);
    AwesomeNotifications().createNotificationFromJsonData(message.data);
  });
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
  // This widget is the root of your application.

  @override
  void initState() {
    super.initState();
    FirebaseController().navigateToPageOnBackground(
        const BottomNavBar(children: [UsersRouter()]));
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
