import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mogapabahi/features/notification/view/notification_screen.dart';
import 'package:mogapabahi/main.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class OneSignalService {
  static String? oneSignalToken;
  static bool _notificationHandled = false;

  static initializeOneSignal() {
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    OneSignal.initialize("ef913ce7-4ade-48b8-98fa-5ff2af18b678");
    OneSignal.Notifications.requestPermission(true);

    OneSignal.User.pushSubscription.addObserver((state) {
      oneSignalToken = OneSignal.User.pushSubscription.id;
      debugPrint("Opted In: ${OneSignal.User.pushSubscription.optedIn}");
      debugPrint("Subscription ID: ${OneSignal.User.pushSubscription.id}");
      debugPrint("Token: ${OneSignal.User.pushSubscription.token}");
      debugPrint("State: ${state.current.jsonRepresentation()}");
    });

    // Add click listener only once
    OneSignalService.handleNotificationClick();
  }

  static loginUser(String email) {
    OneSignal.login(email);
  }

  static handleNotificationClick() {
    OneSignal.Notifications.addClickListener((OSNotificationClickEvent event) {
      if (_notificationHandled) return;

      _notificationHandled = true; // Mark the notification as handled
      debugPrint("------Notification click event triggered------");
      final notificationData = event.notification.additionalData;
      if (notificationData != null) {
        debugPrint('Notification Data: $notificationData');
        parseNotification(notificationData);
      }
    });
  }

  static parseNotification(Map<String, dynamic> notificationData) {
    final key = notificationData['storyId'];

    Fluttertoast.showToast(
      msg: "Your story ID is $key",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );

    navigatorKey.currentState?.push(MaterialPageRoute(
      builder: (context) => NotificationScreen(),
    )).then((_) {
      _notificationHandled = false;
    });
  }

  static handleInApp() {
    _notificationHandled = false;
  }
}
