import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class OneSignalService {
  static String? oneSignalToken;

  static initializeOneSignal() {
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    OneSignal.initialize("e4a28ef9-0bd0-4a1b-a12e-021b2338e2f2");
    OneSignal.Notifications.requestPermission(true);

    OneSignal.User.pushSubscription.addObserver((state) {
      oneSignalToken = OneSignal.User.pushSubscription.id;
      debugPrint("Opted In: ${OneSignal.User.pushSubscription.optedIn}");
      debugPrint("Subscription ID: ${OneSignal.User.pushSubscription.id}");
      debugPrint("Token: ${OneSignal.User.pushSubscription.token}");
      debugPrint("State: ${state.current.jsonRepresentation()}");
    });
  }

  static loginUser(String email) {
    OneSignal.login(email);
  }

  static handleNotificationClick(BuildContext context) {
    
  }

  
  static handleInApp() {}
}