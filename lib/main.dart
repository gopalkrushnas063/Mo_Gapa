import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/api/firebase_api.dart';
import 'package:ui/firebase_options.dart';
import 'package:ui/features/notification/view/notification_page.dart';
import 'package:ui/welcome_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotification();
  runApp(
    // ChangeNotifierProvider(
    //   create: (context) => StoryViewModel(),
    //   child: const MyApp(),
    // ),
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(255, 218, 142, 11),
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mo Gapa Bahi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 218, 142, 11),
        ),
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),
      navigatorKey: navigatorKey,
      routes: {
        '/notification_screen': (context) => const NotificationPage(),
      },
    );
  }
}
