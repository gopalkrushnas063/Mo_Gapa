import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:ui/main.dart';

class FirebaseApi{
  // create an instance of Firebase Messaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  // Function to initialize notifications
  Future<void> initNotification() async{
    // request permission from user (will prompt user)
    await _firebaseMessaging.requestPermission();

    //fetch the FCM token for this device
    final fCMToken = await _firebaseMessaging.getToken();

    // print the token (normally you would send this to your server)
    print("Token: $fCMToken");

    //initialize further settings for push notification
    initPushNotification();
  }

  // Function to handel received messages
  void handelMessage(RemoteMessage? message){
    // if message is null, do nothing
    if(message == null) return;

    // navigate to new screen when message is received and user taps notification
    navigatorKey.currentState?.pushNamed(
      'notification_screen',
      arguments: message,
    );
  }

  // Function to initialize foreground and background settings
  Future initPushNotification() async{
    //handel notification if the app was terminated and now opened
    FirebaseMessaging.instance.getInitialMessage().then(handelMessage);

    // attach event listener for when a notification opens the app 
    FirebaseMessaging.onMessageOpenedApp.listen(handelMessage);
  }
}