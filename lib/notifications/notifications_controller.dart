import 'dart:async';
import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:sample/routes/routes.gr.dart';
import 'package:sample/utils/common_function.dart';

import '../main.dart';

class NotificationsController {
  static ReceivedAction? initialCallAction;

  ///  *********************************************
  ///     INITIALIZATIONS
  ///  *********************************************
  ///
  static Future<void> initializeLocalNotifications() async {
    await AwesomeNotifications().initialize(
        null,
        [
          NotificationChannel(
              channelGroupKey: 'basic_tests',
              channelKey: 'basic_channel',
              channelName: 'Basic notifications',
              channelDescription: 'Notification channel for basic tests',
              defaultColor: const Color(0xFF9D50DD),
              ledColor: Colors.white,
              importance: NotificationImportance.High),
          NotificationChannel(
              channelGroupKey: 'basic_tests',
              channelKey: 'badge_channel',
              channelName: 'Badge indicator notifications',
              channelDescription:
                  'Notification channel to activate badge indicator',
              channelShowBadge: true,
              defaultColor: const Color(0xFF9D50DD),
              ledColor: Colors.yellow),
          NotificationChannel(
              channelGroupKey: 'category_tests',
              channelKey: 'call_channel',
              channelName: 'Calls Channel',
              channelDescription: 'Channel with call ringtone',
              defaultColor: const Color(0xFF9D50DD),
              importance: NotificationImportance.Max,
              ledColor: Colors.white,
              channelShowBadge: true,
              locked: true,
              defaultRingtoneType: DefaultRingtoneType.Ringtone),
          NotificationChannel(
              channelGroupKey: 'category_tests',
              channelKey: 'alarm_channel',
              channelName: 'Alarms Channel',
              channelDescription: 'Channel with alarm ringtone',
              defaultColor: const Color(0xFF9D50DD),
              importance: NotificationImportance.Max,
              ledColor: Colors.white,
              channelShowBadge: true,
              locked: true,
              defaultRingtoneType: DefaultRingtoneType.Alarm),
          NotificationChannel(
              channelGroupKey: 'channel_tests',
              channelKey: 'updated_channel',
              channelName: 'Channel to update',
              channelDescription: 'Notifications with not updated channel',
              defaultColor: const Color(0xFF9D50DD),
              ledColor: Colors.white),
          NotificationChannel(
            channelGroupKey: 'chat_tests',
            channelKey: 'chats',
            channelName: 'Chat groups',
            channelDescription:
                'This is a simple example channel of a chat group',
            channelShowBadge: true,
            importance: NotificationImportance.Max,
            ledColor: Colors.white,
            defaultColor: const Color(0xFF9D50DD),
          ),
          NotificationChannel(
              channelGroupKey: 'vibration_tests',
              channelKey: 'low_intensity',
              channelName: 'Low intensity notifications',
              channelDescription:
                  'Notification channel for notifications with low intensity',
              defaultColor: Colors.green,
              ledColor: Colors.green,
              vibrationPattern: lowVibrationPattern),
          NotificationChannel(
              channelGroupKey: 'vibration_tests',
              channelKey: 'medium_intensity',
              channelName: 'Medium intensity notifications',
              channelDescription:
                  'Notification channel for notifications with medium intensity',
              defaultColor: Colors.yellow,
              ledColor: Colors.yellow,
              vibrationPattern: mediumVibrationPattern),
          NotificationChannel(
              channelGroupKey: 'vibration_tests',
              channelKey: 'high_intensity',
              channelName: 'High intensity notifications',
              channelDescription:
                  'Notification channel for notifications with high intensity',
              defaultColor: Colors.red,
              ledColor: Colors.red,
              vibrationPattern: highVibrationPattern),
          NotificationChannel(
              channelGroupKey: 'privacy_tests',
              channelKey: "private_channel",
              channelName: "Privates notification channel",
              channelDescription: "Privates notification from lock screen",
              playSound: true,
              defaultColor: Colors.red,
              ledColor: Colors.red,
              vibrationPattern: lowVibrationPattern,
              defaultPrivacy: NotificationPrivacy.Private),
          // NotificationChannel(
          //     channelGroupKey: 'sound_tests',
          //     icon: 'resource://drawable/res_power_ranger_thunder',
          //     channelKey: "custom_sound",
          //     channelName: "Custom sound notifications",
          //     channelDescription: "Notifications with custom sound",
          //     playSound: true,
          //     soundSource: 'resource://raw/res_morph_power_rangers',
          //     defaultColor: Colors.red,
          //     ledColor: Colors.red,
          //     vibrationPattern: lowVibrationPattern),
          NotificationChannel(
              channelGroupKey: 'sound_tests',
              channelKey: "silenced",
              channelName: "Silenced notifications",
              channelDescription: "The most quiet notifications",
              playSound: false,
              enableVibration: false,
              enableLights: false),
          // NotificationChannel(
          //     channelGroupKey: 'media_player_tests',
          //     icon: 'resource://drawable/res_media_icon',
          //     channelKey: 'media_player',
          //     channelName: 'Media player controller',
          //     channelDescription: 'Media player controller',
          //     defaultPrivacy: NotificationPrivacy.Public,
          //     enableVibration: false,
          //     enableLights: false,
          //     playSound: false,
          //     locked: true),
          NotificationChannel(
              channelGroupKey: 'image_tests',
              channelKey: 'big_picture',
              channelName: 'Big pictures',
              channelDescription: 'Notifications with big and beautiful images',
              defaultColor: const Color(0xFF9D50DD),
              ledColor: const Color(0xFF9D50DD),
              vibrationPattern: lowVibrationPattern,
              importance: NotificationImportance.High),
          NotificationChannel(
              channelGroupKey: 'layout_tests',
              channelKey: 'big_text',
              channelName: 'Big text notifications',
              channelDescription: 'Notifications with a expandable body text',
              defaultColor: Colors.blueGrey,
              ledColor: Colors.blueGrey,
              vibrationPattern: lowVibrationPattern),
          NotificationChannel(
              channelGroupKey: 'layout_tests',
              channelKey: 'inbox',
              channelName: 'Inbox notifications',
              channelDescription: 'Notifications with inbox layout',
              defaultColor: const Color(0xFF9D50DD),
              ledColor: const Color(0xFF9D50DD),
              vibrationPattern: mediumVibrationPattern),
          NotificationChannel(
            channelGroupKey: 'schedule_tests',
            channelKey: 'scheduled',
            channelName: 'Scheduled notifications',
            channelDescription: 'Notifications with schedule functionality',
            defaultColor: const Color(0xFF9D50DD),
            ledColor: const Color(0xFF9D50DD),
            vibrationPattern: lowVibrationPattern,
            importance: NotificationImportance.High,
            defaultRingtoneType: DefaultRingtoneType.Alarm,
            criticalAlerts: true,
          ),
          // NotificationChannel(
          //     channelGroupKey: 'layout_tests',
          //     icon: 'resource://drawable/res_download_icon',
          //     channelKey: 'progress_bar',
          //     channelName: 'Progress bar notifications',
          //     channelDescription: 'Notifications with a progress bar layout',
          //     defaultColor: Colors.deepPurple,
          //     ledColor: Colors.deepPurple,
          //     vibrationPattern: lowVibrationPattern,
          //     onlyAlertOnce: true),
          NotificationChannel(
              channelGroupKey: 'grouping_tests',
              channelKey: 'grouped',
              channelName: 'Grouped notifications',
              channelDescription: 'Notifications with group functionality',
              groupKey: 'grouped',
              groupSort: GroupSort.Desc,
              groupAlertBehavior: GroupAlertBehavior.Children,
              defaultColor: Colors.lightGreen,
              ledColor: Colors.lightGreen,
              vibrationPattern: lowVibrationPattern,
              importance: NotificationImportance.High)
        ],
        channelGroups: [
          NotificationChannelGroup(
              channelGroupKey: 'basic_tests', channelGroupName: 'Basic tests'),
          NotificationChannelGroup(
              channelGroupKey: 'category_tests',
              channelGroupName: 'Category tests'),
          NotificationChannelGroup(
              channelGroupKey: 'image_tests', channelGroupName: 'Images tests'),
          NotificationChannelGroup(
              channelGroupKey: 'schedule_tests',
              channelGroupName: 'Schedule tests'),
          NotificationChannelGroup(
              channelGroupKey: 'chat_tests', channelGroupName: 'Chat tests'),
          NotificationChannelGroup(
              channelGroupKey: 'channel_tests',
              channelGroupName: 'Channel tests'),
          // NotificationChannelGroup(
          //     channelGroupKey: 'sound_tests', channelGroupName: 'Sound tests'),
          NotificationChannelGroup(
              channelGroupKey: 'vibration_tests',
              channelGroupName: 'Vibration tests'),
          NotificationChannelGroup(
              channelGroupKey: 'privacy_tests',
              channelGroupName: 'Privacy tests'),
          // NotificationChannelGroup(
          //     channelGroupKey: 'layout_tests',
          //     channelGroupName: 'Layout tests'),
          NotificationChannelGroup(
              channelGroupKey: 'grouping_tests',
              channelGroupName: 'Grouping tests'),
          // NotificationChannelGroup(
          //     channelGroupKey: 'media_player_tests',
          //     channelGroupName: 'Media Player tests')
        ],
        debug: true);
  }

  static Future<void> initializeNotificationsEventListeners() async {
    // Only after at least the action method is set, the notification events are delivered
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationsController.onActionReceivedMethod,
        onNotificationCreatedMethod:
            NotificationsController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
            NotificationsController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
            NotificationsController.onDismissActionReceivedMethod);
  }

  ///  *********************************************
  ///     NOTIFICATION EVENTS LISTENER
  ///  *********************************************
  ///  Notifications events are only delivered after call this method
  static Future<void> startListeningNotificationEvents() async {
    AwesomeNotifications()
        .setListeners(onActionReceivedMethod: onActionReceivedMethod);
  }

  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    // do something here
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    // do something here
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {}

  ///  *********************************************
  ///     NOTIFICATION EVENTS
  ///  *********************************************
  ///
  /// Use this method to navigate if the user press the notification
  @pragma('vm:entry-point')
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    loadSingletonPage(const BottomNavBar(children: [UsersRouter()]),
        receivedAction: receivedAction);
  }

  ///  *********************************************
  ///     REQUESTING NOTIFICATION PERMISSIONS
  ///  *********************************************
  ///
  static Future<bool> displayNotificationRationale() async {
    bool userAuthorized = false;
    BuildContext context = MyMainApp.navigatorKey.currentContext!;
    await showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text('Get Notified!',
                style: Theme.of(context).textTheme.titleLarge),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                SizedBox(height: 20),
                Text('Allow App to send you notifications!'),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text(
                    'Deny',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.red),
                  )),
              TextButton(
                  onPressed: () async {
                    userAuthorized = true;
                    Navigator.of(ctx).pop();
                  },
                  child: Text(
                    'Allow',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.deepPurple),
                  )),
            ],
          );
        });
    return userAuthorized &&
        await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  ///  *********************************************
  ///     NOTIFICATION CREATION METHODS
  ///  *********************************************
  ///
  ///
  static Future<void> createNewNotification(RemoteMessage message) async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) isAllowed = await displayNotificationRationale();
    if (!isAllowed) return;
    if (Platform.isAndroid) {
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: DateTime.now().millisecondsSinceEpoch.remainder(100005),
          channelKey: 'basic_channel',
          title: message.notification?.title,
          body: message.notification?.body,
        ),
      );
    }
  }

  static Future<void> resetBadgeCounter() async {
    await AwesomeNotifications().resetGlobalBadge();
  }

  static Future<void> cancelNotifications() async {
    await AwesomeNotifications().cancelAll();
  }

  static Future<void> interceptInitialCallActionRequest() async {
    ReceivedAction? receivedAction =
        await AwesomeNotifications().getInitialNotificationAction();

    if (receivedAction?.channelKey == 'call_channel') {
      initialCallAction = receivedAction;
    }
  }
}
