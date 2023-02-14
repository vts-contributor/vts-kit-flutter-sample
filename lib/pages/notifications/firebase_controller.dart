import 'package:auto_route/auto_route.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:sample/main.dart';

class FirebaseController {
  Future<void> subscribeToTopic(String topic) async {
    await FirebaseMessaging.instance.subscribeToTopic(topic);
  }

  Future<void> unSubscribeFromTopic(String topic) async {
    await FirebaseMessaging.instance.unsubscribeFromTopic(topic);
  }

  Future<String?> getFCMToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    return token;
  }

  // Navigate to specific page when user tap on notification and app is on background running.
  Future<void> navigateToPageOnBackground(PageRouteInfo<dynamic> route) async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      appRouter.push(route);
    });
  }
}
